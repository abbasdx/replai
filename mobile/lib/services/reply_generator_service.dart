import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:email_writer_flutter/controllers/api_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/reply_request.dart';
import '../models/reply_response.dart';

class ReplyGeneratorService {
  final http.Client _client;

  ReplyGeneratorService({http.Client? client})
      : _client = client ?? http.Client();

  Future<String> generateReply(GenerateReplyRequest request) async {
    return _post(
      path: ApiConfig.generateReplyPath,
      body: request.toJson(),
    );
  }

  Future<String> improveReply(ImproveReplyRequest request) async {
    return _post(
      path: ApiConfig.improveReplyPath,
      body: request.toJson(),
    );
  }

  Future<String> _post({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}$path');
    debugPrint('--> POST $uri');
    debugPrint('--> PAYLOAD: ${jsonEncode(body)}');

    try {
      final response = await _client
          .post(
            uri,
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(ApiConfig.requestTimeout);

      debugPrint('<-- STATUS ${response.statusCode}: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final parsed = ReplyResponse.fromRawBody(response.body);
        if (parsed.reply.trim().isEmpty) {
          throw const ApiException('Server returned an empty reply.');
        }
        return parsed.reply.trim();
      }

      throw ApiException(
        _extractErrorMessage(response.body, response.statusCode),
        statusCode: response.statusCode,
      );
    } on SocketException {
      throw const ApiException(
        'Network error: Unable to reach replaiserver.abbasansari.me.',
      );
    } on TimeoutException {
      throw const ApiException(
        'Request timed out. The server took too long to respond.',
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  String _extractErrorMessage(String rawBody, int statusCode) {
    if (rawBody.trim().isEmpty) {
      return 'Server returned status $statusCode.';
    }
    try {
      final decoded = jsonDecode(rawBody);
      if (decoded is Map<String, dynamic>) {
        final message = decoded['message'] ??
            decoded['error'] ??
            decoded['detail'] ??
            decoded['data'];
        if (message is String && message.trim().isNotEmpty) {
          return message.trim();
        }
      }
    } catch (_) {}
    return 'Request failed ($statusCode). Ensure input is 30 to 4000 characters.';
  }
}