import 'dart:convert';
import 'package:dona_josy/config/app_env.dart';
import 'package:dona_josy/utils/headers/headers.dart';
import 'package:http/http.dart' as http;

class AssistantApi {
  String get urlApi => '${AppEnv.assistantBaseUrl}/';

  Future getChats() async {
    return await http.get(
      Uri.parse('${urlApi}items/format/'),
      headers: await Header().getHeader(),
    );
  }

  Future setChat(String message) async {
    final url = Uri.parse(urlApi);

    final body = {'message': message, 'is_assistant': false};

    return await http.post(
      url,
      headers: await Header().getHeader(),
      body: jsonEncode(body),
    );
  }
}
