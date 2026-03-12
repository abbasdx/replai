import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class ApiConfig {
  static String get baseUrl {
    if (dotenv.isInitialized) {
      final envUrl = dotenv.env['API_BASE_URL']?.trim() ?? '';
      if (envUrl.isNotEmpty) {
        return envUrl.replaceAll(RegExp(r'/+$'), '');
      }
    }

    const dartDefineUrl = String.fromEnvironment('API_BASE_URL');
    if (dartDefineUrl.trim().isNotEmpty) {
      return dartDefineUrl.trim().replaceAll(RegExp(r'/+$'), '');
    }

    // Default directly to production backend so physical devices always connect
    return 'https://replaiserver.abbasansari.me';
  }

  static const String generateReplyPath = '/api/v1/replies/generate';
  static const String improveReplyPath = '/api/v1/replies/improve';
  static const Duration requestTimeout = Duration(seconds: 45);
  static const int minInputCharacters = 30;
  static const int maxInputCharacters = 4000;
}