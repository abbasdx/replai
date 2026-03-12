import 'dart:convert';

class ReplyResponse {
  final String reply;

  const ReplyResponse({required this.reply});

  factory ReplyResponse.fromRawBody(String rawBody) {
    final trimmed = rawBody.trim();
    if (trimmed.isEmpty) {
      return const ReplyResponse(reply: '');
    }

    try {
      final decoded = jsonDecode(trimmed);

      if (decoded is String) {
        return ReplyResponse(reply: decoded.trim());
      }

      if (decoded is Map<String, dynamic>) {
        // Check direct keys for both Generate and Improve endpoints
        final directCandidate = decoded['reply'] ??
            decoded['improvedReply'] ??
            decoded['generatedReply'] ??
            decoded['improvedDraft'] ??
            decoded['draftReply'] ??
            decoded['result'] ??
            decoded['content'] ??
            decoded['text'] ??
            decoded['message'];

        if (directCandidate is String && directCandidate.trim().isNotEmpty) {
          return ReplyResponse(reply: directCandidate.trim());
        }

        // Check nested 'data' object if wrapped in a standard API response
        final data = decoded['data'];
        if (data is String && data.trim().isNotEmpty) {
          return ReplyResponse(reply: data.trim());
        }
        if (data is Map<String, dynamic>) {
          final nestedCandidate = data['reply'] ??
              data['improvedReply'] ??
              data['generatedReply'] ??
              data['improvedDraft'] ??
              data['result'] ??
              data['content'] ??
              data['text'];
          if (nestedCandidate is String && nestedCandidate.trim().isNotEmpty) {
            return ReplyResponse(reply: nestedCandidate.trim());
          }
        }
      }
    } catch (_) {
      // If response is plain text (not JSON), return it directly
      return ReplyResponse(reply: trimmed);
    }

    return const ReplyResponse(reply: '');
  }
}