import 'dart:convert';

import 'package:dona_josy/components/ScaffoldMessage.dart';
import 'package:dona_josy/models/cart.dart';
import 'package:dona_josy/models/page_result.dart';
import 'package:dona_josy/services/api/carts.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cart.store.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  final CartsApi api = CartsApi();
  final ScaffoldMessage messages = ScaffoldMessage();
  final TextEditingController nameFilter = TextEditingController();

  @observable
  List<Cart> carts = [];
  @observable
  bool isLoading = false;
  @observable
  bool isPixLoading = false;
  @observable
  bool isMutating = false;
  @observable
  int currentPage = 0;
  @observable
  int totalPages = 0;
  @observable
  int totalElements = 0;
  @observable
  String statusFilter = 'ANDAMENTO';
  @observable
  String categoryFilter = '';
  @observable
  double total = 0;
  @observable
  String? pixCopyPaste;
  @observable
  List<Map<String, dynamic>> unreadNotifications = [];

  Future<bool> addProductToCart(BuildContext context, String productId) async {
    try {
      final response = await api.addProduct(productId);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        await load(context, isAdmin: false, page: 0);
        if (context.mounted) {
          messages.showSnackBar(
            'Item adicionado ao carrinho.',
            Colors.green,
            context,
          );
        }
        return true;
      }

      final message = switch (response.statusCode) {
        400 => 'Este produto está indisponível para adicionar ao carrinho.',
        401 ||
        403 => 'Sua sessão expirou ou você não tem permissão. Entre novamente.',
        404 => 'Produto não encontrado. Atualize a lista e tente novamente.',
        _ => 'Não foi possível adicionar o item (erro ${response.statusCode}).',
      };
      if (context.mounted) {
        messages.showSnackBar(message, Colors.redAccent, context);
      }
      return false;
    } catch (_) {
      if (context.mounted) {
        messages.showSnackBar(
          'Falha de conexão ao adicionar o item. Tente novamente.',
          Colors.redAccent,
          context,
        );
      }
      return false;
    }
  }

  @action
  Future<void> load(
    BuildContext context, {
    required bool isAdmin,
    int? page,
  }) async {
    isLoading = true;
    try {
      final requestedPage = page ?? currentPage;
      final response = await api.getCarts(
        page: requestedPage,
        status: isAdmin
            ? (categoryFilter.isEmpty ? null : categoryFilter)
            : statusFilter,
        name: isAdmin ? nameFilter.text : null,
      );
      if (response.statusCode != 200)
        throw Exception('HTTP ${response.statusCode}');
      final pageData = PageResult<Cart>.fromJson(
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
        Cart.fromJson,
      );
      carts = pageData.content;
      currentPage = pageData.number;
      totalPages = pageData.totalPages;
      totalElements = pageData.totalElements;

      if (!isAdmin) {
        final totalResponse = await api.getTotal(status: statusFilter);
        if (totalResponse.statusCode == 200) {
          total = (json.decode(utf8.decode(totalResponse.bodyBytes)) as num)
              .toDouble();
        }
      }
      if (isAdmin) {
        pixCopyPaste = null;
        total = 0;
      } else {
        await refreshNotifications();
      }
    } catch (_) {
      messages.showSnackBar(
        'Não foi possível carregar os itens do carrinho.',
        Colors.redAccent,
        context,
      );
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> refreshNotifications() async {
    try {
      final response = await api.getUnreadNotifications();
      if (response.statusCode != 200) return;
      final decoded =
          json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      unreadNotifications = decoded.cast<Map<String, dynamic>>();
    } catch (_) {
      // Notification polling is secondary to loading the cart itself.
    }
  }

  @action
  Future<void> markNotificationRead(String id) async {
    try {
      final response = await api.markNotificationRead(id);
      if (response.statusCode == 204 || response.statusCode == 200) {
        unreadNotifications = unreadNotifications
            .where((item) => item['id'] != id)
            .toList();
      }
    } catch (_) {
      // Keep the notification visible so it can be retried later.
    }
  }

  @action
  Future<bool> updateCartStatus(
    BuildContext context,
    Cart cart,
    String status, {
    required bool isAdmin,
  }) async {
    final productId = cart.product?.id;
    if (productId == null || isMutating) return false;
    isMutating = true;
    try {
      final response = await api.updateCartStatus(
        cartId: cart.id,
        productId: productId,
        status: status,
      );
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception('HTTP ${response.statusCode}');
      }
      final changed = status != cart.status;
      messages.showSnackBar(
        !isAdmin
            ? 'Item marcado como cancelado.'
            : changed
            ? 'Status atualizado. O cliente foi notificado.'
            : 'O status já estava selecionado.',
        Colors.green,
        context,
      );
      pixCopyPaste = null;
      await load(context, isAdmin: isAdmin, page: currentPage);
      return true;
    } catch (_) {
      messages.showSnackBar(
        'Não foi possível atualizar o status.',
        Colors.redAccent,
        context,
      );
      return false;
    } finally {
      isMutating = false;
    }
  }

  @action
  Future<void> generatePix(BuildContext context) async {
    if (statusFilter != 'ANDAMENTO' || carts.isEmpty || isPixLoading) return;
    isPixLoading = true;
    try {
      final response = await api.generatePix();
      if (response.statusCode != 201)
        throw Exception('HTTP ${response.statusCode}');
      final data =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      total = (data['total'] as num?)?.toDouble() ?? total;
      pixCopyPaste = data['pix']?['copyPaste'] as String?;
    } catch (_) {
      messages.showSnackBar(
        'Não foi possível gerar o código Pix.',
        Colors.redAccent,
        context,
      );
    } finally {
      isPixLoading = false;
    }
  }

  @action
  Future<void> changeStatusFilter(String? value, BuildContext context) async {
    if (value == null) return;
    statusFilter = value;
    currentPage = 0;
    pixCopyPaste = null;
    await load(context, isAdmin: false, page: 0);
  }

  @action
  Future<void> filterAdmin(BuildContext context) async {
    currentPage = 0;
    await load(context, isAdmin: true, page: 0);
  }

  @action
  Future<void> setAdminCategory(String? value, BuildContext context) async {
    categoryFilter = value ?? '';
    await filterAdmin(context);
  }
}
