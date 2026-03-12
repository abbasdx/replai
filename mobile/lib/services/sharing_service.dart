import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import '../config/api_config.dart';

class SharingService {
  StreamSubscription<List<SharedMediaFile>>? _intentSub;
  String? _lastProcessedPayload;

  /// Initializes listening for incoming text shares across cold and warm starts.
  void initialize({required void Function(String text) onSharedText}) {
    if (kIsWeb) return;

    try {
      // 1. Warm-start: Listen to shares while the app is alive in the background
      _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen(
        (List<SharedMediaFile> files) {
          _handleSharedFiles(files, onSharedText);
        },
        onError: (err) {
          debugPrint('ReceiveSharingIntent getMediaStream error: $err');
        },
      );

      // 2. Cold-start: Read shares that launched the application from a terminated state
      ReceiveSharingIntent.instance.getInitialMedia().then((List<SharedMediaFile> files) {
        _handleSharedFiles(files, onSharedText);
        ReceiveSharingIntent.instance.reset();
      }).catchError((err) {
        debugPrint('ReceiveSharingIntent getInitialMedia error: $err');
      });
    } catch (e) {
      debugPrint('SharingService initialization exception: $e');
    }
  }

  void _handleSharedFiles(
    List<SharedMediaFile> files,
    void Function(String text) onTextReceived,
  ) {
    if (files.isEmpty) return;

    for (final file in files) {
      final textCandidate = file.path;
      if (_isValidShareText(textCandidate)) {
        final sanitized = _sanitizeText(textCandidate);
        if (sanitized == _lastProcessedPayload) {
          continue; // Avoid processing the same share event twice
        }
        _lastProcessedPayload = sanitized;
        onTextReceived(sanitized);
        break;
      }
    }
  }

  bool _isValidShareText(String? candidate) {
    if (candidate == null) return false;
    return candidate.trim().isNotEmpty;
  }

  String _sanitizeText(String text) {
    var result = text.trim();
    if (result.length > ApiConfig.maxInputCharacters) {
      result = result.substring(0, ApiConfig.maxInputCharacters);
    }
    return result;
  }

  void dispose() {
    _intentSub?.cancel();
    _intentSub = null;
  }
}