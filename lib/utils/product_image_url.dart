import 'package:dona_josy/config/app_env.dart';

Uri? productImageUri(String? image) {
  final value = image?.trim();
  if (value == null || value.isEmpty) return null;

  if (value.startsWith('//')) return Uri.parse('https:$value');

  final parsed = Uri.tryParse(value);
  if (parsed != null &&
      (parsed.scheme == 'http' || parsed.scheme == 'https') &&
      parsed.hasAuthority) {
    if (parsed.scheme == 'http' &&
        parsed.host == Uri.parse(AppEnv.apiBaseUrl).host) {
      return parsed.replace(scheme: 'https');
    }
    return parsed;
  }

  final withoutLeadingSlashes = value.replaceFirst(RegExp(r'^/+'), '');
  final apiBase = Uri.parse(AppEnv.apiBaseUrl);
  if (withoutLeadingSlashes.startsWith('${apiBase.host}/')) {
    return Uri.parse('${apiBase.scheme}://$withoutLeadingSlashes');
  }

  if (withoutLeadingSlashes.startsWith('api/v1/')) {
    return apiBase.resolve('/$withoutLeadingSlashes');
  }
  final relativePath = withoutLeadingSlashes.startsWith('api/')
      ? withoutLeadingSlashes.substring(4)
      : withoutLeadingSlashes;
  return Uri.parse('${AppEnv.apiBaseUrl}/').resolve(relativePath);
}
