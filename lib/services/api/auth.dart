import 'dart:convert';
import 'package:dona_josy/config/app_env.dart';
import 'package:dona_josy/utils/headers/headers.dart';
import 'package:dona_josy/utils/shared/shared.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  String get urlApi => '${AppEnv.apiBaseUrl}/auth/';

  final headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  Future profile() async {
    return await http.get(
      Uri.parse('${urlApi}profile'),
      headers: await Header().getHeader(),
    );
  }

  Future register(
    String name,
    String email,
    String phone,
    String address,
    String num,
    String neighborhood,
    String password,
  ) async {
    final url = Uri.parse('${urlApi}register');

    final body = {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'num': num,
      'neighborhood': neighborhood,
      'password': password,
    };

    return await http.post(
      url,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future edit(
    String id,
    String name,
    String email,
    String phone,
    String address,
    String num,
    String neighborhood,
  ) async {
    final url = Uri.parse('${urlApi}user/$id');

    final body = {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'num': num,
      'neighborhood': neighborhood,
    };

    return await http.put(
      url,
      headers: await Header().getHeader(),
      body: jsonEncode(body),
    );
  }

  Future login(String email, String password) async {
    final body = {'email': email, 'password': password};

    final response = await http.post(
      Uri.parse('${urlApi}login'),
      body: json.encode(body),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      String token = responseData['token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access', token);

      final profileResponse = await profile();
      if (profileResponse.statusCode != 200) {
        await Shared().clearAuthentication();
        return profileResponse;
      }
      final profileData = json.decode(utf8.decode(profileResponse.bodyBytes));
      final role = (profileData['role'] as String? ?? 'USER').toUpperCase();
      await prefs.setString('role', role);
    }

    return response;
  }

  Future logout({String? token, bool clearLocal = true}) async {
    final authToken = token ?? await Shared().get('access');
    if (clearLocal) await Shared().clearAuthentication();
    if (authToken == null) return null;

    return http
        .post(
          Uri.parse('${urlApi}logout'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $authToken",
          },
        )
        .timeout(const Duration(seconds: 8));
  }
}
