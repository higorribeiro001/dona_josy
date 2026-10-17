import 'dart:convert';

import 'package:dona_josy/config/app_env.dart';
import 'package:dona_josy/utils/headers/headers.dart';
import 'package:http/http.dart' as http;

class CartsApi {
  Future<http.Response> getCarts({
    required int page,
    String? status,
    String? name,
    String? category,
  }) async {
    final query = <String, String>{'page': '$page', 'size': '10'};
    if (status != null && status.isNotEmpty) query['statusCart'] = status;
    if (name != null && name.trim().isNotEmpty) query['name'] = name.trim();
    if (category != null && category.isNotEmpty) query['category'] = category;
    return http.get(
      AppEnv.apiUri('/carts', queryParameters: query),
      headers: await Header().getHeader(),
    );
  }

  Future<http.Response> getTotal({String? status}) async {
    return http.get(
      AppEnv.apiUri('/carts/total', queryParameters: {
        if (status != null && status.isNotEmpty) 'statusCart': status,
      }),
      headers: await Header().getHeader(),
    );
  }

  Future<http.Response> generatePix() async {
    return http.post(
      AppEnv.apiUri('/payments/pix'),
      headers: await Header().getHeader(),
    );
  }

  Future<http.Response> addProduct(String productId) async {
    return http.post(
      AppEnv.apiUri('/carts'),
      headers: await Header().getHeader(),
      body: jsonEncode({'product_id': productId}),
    );
  }

  Future<http.Response> updateCartStatus({
    required String cartId,
    required String productId,
    required String status,
  }) async {
    return http.put(
      AppEnv.apiUri('/carts/$cartId'),
      headers: await Header().getHeader(),
      body: jsonEncode({'product_id': productId, 'status_cart': status}),
    );
  }

  Future<http.Response> getUnreadNotifications() async {
    return http.get(
      AppEnv.apiUri('/notifications/unread'),
      headers: await Header().getHeader(),
    );
  }

  Future<http.Response> markNotificationRead(String notificationId) async {
    return http.patch(
      AppEnv.apiUri('/notifications/$notificationId/read'),
      headers: await Header().getHeader(),
    );
  }
}
