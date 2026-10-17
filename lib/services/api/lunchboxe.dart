import 'dart:convert';
import 'dart:io';

import 'package:dona_josy/config/app_env.dart';
import 'package:dona_josy/utils/headers/headers.dart';
import 'package:http/http.dart' as http;

class LunchboxeApi {
  static const String _path = '/products';

  Future<http.Response> getLunchboxe({
    required int page,
    String name = '',
  }) async {
    final query = <String, String>{
      'category': 'MARMITA',
      'page': '$page',
      'size': '10',
      if (name.trim().isNotEmpty) 'name': name.trim(),
    };
    return http.get(
      AppEnv.apiUri(_path, queryParameters: query),
      headers: await Header().getHeader(),
    );
  }

  Future<http.Response> setLunchboxe(
    String name,
    File image,
    String description,
    String price,
  ) async {
    final request = http.MultipartRequest('POST', AppEnv.apiUri(_path));
    request.headers.addAll(await Header().getHeader());
    request.fields['name'] = name;
    request.fields['category'] = 'MARMITA';
    request.fields['description'] = description;
    request.fields['isActive'] = 'true';
    request.fields['price'] = price.replaceAll('.', '').replaceAll(',', '.');
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    return http.Response.fromStream(await request.send());
  }

  Future<http.Response> updateLunchboxe(
    String id,
    String name,
    File? image,
    String description,
    String price,
    bool isActive,
  ) async {
    final request = http.MultipartRequest(
      'PUT',
      AppEnv.apiUri('$_path/$id'),
    );
    request.headers.addAll(await Header().getHeader());
    request.fields['name'] = name;
    request.fields['category'] = 'MARMITA';
    request.fields['description'] = description;
    request.fields['isActive'] = '$isActive';
    request.fields['price'] = price.replaceAll('.', '').replaceAll(',', '.');
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }
    return http.Response.fromStream(await request.send());
  }

  Future<http.Response> setActive(String id, bool isActive) async {
    return http.patch(
      AppEnv.apiUri('$_path/$id'),
      headers: await Header().getHeader(),
      body: jsonEncode(isActive),
    );
  }
}
