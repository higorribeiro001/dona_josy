import 'package:flutter/services.dart';

/// Loads public app configuration from the bundled .env asset.
/// Do not store secrets here: Flutter bundles assets into the app package.
abstract final class AppEnv {
  static const _defaultApiBaseUrl =
      'http://127.0.0.1:8080/api/v1';
  static const _defaultAssistantBaseUrl =
      'http://127.0.0.1:8080/api/v1/chat-messages';

  static String apiBaseUrl = _defaultApiBaseUrl;
  static String assistantBaseUrl = _defaultAssistantBaseUrl;

  static Future<void> load() async {
    final values = <String, String>{};
    final contents = await rootBundle.loadString('.env');

    for (final rawLine in contents.split('\n')) {
      final line = rawLine.trim();
      if (line.isEmpty || line.startsWith('#')) continue;
      final separator = line.indexOf('=');
      if (separator < 1) continue;

      final key = line.substring(0, separator).trim();
      var value = line.substring(separator + 1).trim();
      if (value.length >= 2 &&
          ((value.startsWith('"') && value.endsWith('"')) ||
              (value.startsWith("'") && value.endsWith("'")))) {
        value = value.substring(1, value.length - 1);
      }
      values[key] = value;
    }

    apiBaseUrl = _normalizeBaseUrl(
      values['API_BASE_URL'] ?? _defaultApiBaseUrl,
    );
    assistantBaseUrl = _normalizeBaseUrl(
      values['ASSISTANT_API_BASE_URL'] ?? _defaultAssistantBaseUrl,
    );
  }

  static String _normalizeBaseUrl(String value) {
    final uri = Uri.parse(value);
    if (!uri.hasScheme || !uri.hasAuthority) {
      throw FormatException('URL inválida no arquivo .env: $value');
    }
    return value.replaceFirst(RegExp(r'/+$'), '');
  }

  static Uri apiUri(String path, {Map<String, String>? queryParameters}) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    final uri = Uri.parse('$apiBaseUrl$normalizedPath');
    return queryParameters == null
        ? uri
        : uri.replace(queryParameters: queryParameters);
  }
}
