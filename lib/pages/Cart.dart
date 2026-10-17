import 'dart:async';
import 'package:dona_josy/models/cart.dart' as model;
import 'package:dona_josy/components/SkeletonList.dart';
import 'package:dona_josy/store/cart.store.dart';
import 'package:dona_josy/utils/product_image_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key, required this.isAdmin});
  final bool isAdmin;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> with WidgetsBindingObserver {
  Timer? _notificationTimer;
  static const _statuses = <String, String>{
    'ANDAMENTO': 'Em andamento',
    'FINALIZADO': 'Finalizado',
    'PAGO': 'Pago',
    'ENTREGUE': 'Entregue',
    'CANCELADO': 'Cancelado',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartStore>().load(context, isAdmin: widget.isAdmin, page: 0);
    });
    if (!widget.isAdmin) {
      _notificationTimer = Timer.periodic(const Duration(seconds: 45), (_) {
        if (mounted)
          unawaited(context.read<CartStore>().refreshNotifications());
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !widget.isAdmin && mounted) {
      unawaited(context.read<CartStore>().refreshNotifications());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _notificationTimer?.cancel();
    super.dispose();
  }

  Widget _filters(CartStore store) {
    if (widget.isAdmin) {
      return Column(
        children: [
          TextField(
            controller: store.nameFilter,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => store.filterAdmin(context),
            decoration: InputDecoration(
              labelText: 'Buscar produto por nome',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                tooltip: 'Limpar busca',
                icon: const Icon(Icons.clear),
                onPressed: () {
                  store.nameFilter.clear();
                  store.filterAdmin(context);
                },
              ),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: store.categoryFilter,
            decoration: const InputDecoration(
              labelText: 'Status dos itens',
              border: OutlineInputBorder(),
            ),
            items: [
              const DropdownMenuItem(value: '', child: Text('Todos')),
              ..._statuses.entries.map(
                  (entry) => DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
                ),
            ],
            onChanged: (value) => store.setAdminCategory(value, context),
          ),
        ],
      );
    }

    return DropdownButtonFormField<String>(
      value: store.statusFilter,
      decoration: const InputDecoration(
        labelText: 'Status dos itens',
        border: OutlineInputBorder(),
      ),
      items: _statuses.entries
          .map(
            (entry) =>
                DropdownMenuItem(value: entry.key, child: Text(entry.value)),
          )
          .toList(),
      onChanged: (value) => store.changeStatusFilter(value, context),
    );
  }

  Future<void> _editStatus(CartStore store, model.Cart item) async {
    var selectedStatus = item.status ?? 'ANDAMENTO';
    final updated = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Editar status do carrinho'),
        content: DropdownButtonFormField<String>(
          value: selectedStatus,
          decoration: const InputDecoration(labelText: 'Status'),
          items: _statuses.entries
              .map(
                (entry) => DropdownMenuItem(
                  value: entry.key,
                  child: Text(entry.value),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) selectedStatus = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: store.isMutating
                ? null
                : () async {
                    final success = await store.updateCartStatus(
                      context,
                      item,
                      selectedStatus,
                      isAdmin: true,
                    );
                    if (dialogContext.mounted)
                      Navigator.pop(dialogContext, success);
                  },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
    if (updated == true && mounted) setState(() {});
  }

  Future<void> _cancelItem(CartStore store, model.Cart item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cancelar item?'),
        content: Text(
          '${item.product?.name ?? 'Este item'} será marcado como cancelado e continuará no histórico do carrinho.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Cancelar item'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await store.updateCartStatus(context, item, 'CANCELADO', isAdmin: false);
    }
  }

  Widget _cartItem(model.Cart item, CartStore store) {
    final product = item.product;
    final image = product?.image ?? '';
    final imageUrl = productImageUri(image)?.toString();
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 84,
                  height: 84,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(
                    width: 84,
                    height: 84,
                    child: Icon(Icons.image_not_supported_outlined),
                  ),
                ),
              ),
            if (imageUrl != null) const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product?.name ?? 'Produto',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product?.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Status: ${_statuses[item.status] ?? item.status ?? '—'}',
                  ),
                  if (widget.isAdmin && item.userName != null)
                    Text('Cliente: ${item.userName}'),
                  if (widget.isAdmin && item.userEmail != null)
                    Text(item.userEmail!),
                  const SizedBox(height: 6),
                  Text(
                    'R\$ ${(product?.price ?? 0).toStringAsFixed(2).replaceAll('.', ',')}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (widget.isAdmin)
                    OutlinedButton.icon(
                      onPressed: store.isMutating
                          ? null
                          : () => _editStatus(store, item),
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Editar status'),
                    )
                  else
                    OutlinedButton.icon(
                      onPressed: store.isMutating
                          ? null
                          : () => _cancelItem(store, item),
                      icon: const Icon(Icons.remove_shopping_cart_outlined),
                      label: const Text('Remover do carrinho'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userPayment(CartStore store) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        Text(
          'Total: R\$ ${store.total.toStringAsFixed(2).replaceAll('.', ',')}',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (store.statusFilter == 'ANDAMENTO') ...[
          const SizedBox(height: 12),
          if (store.pixCopyPaste == null)
            FilledButton.icon(
              onPressed: store.carts.isEmpty || store.isPixLoading
                  ? null
                  : () => store.generatePix(context),
              icon: store.isPixLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.pix),
              label: const Text('Gerar código Pix'),
            )
          else ...[
            const Text('Pix copia e cola'),
            const SizedBox(height: 6),
            SelectableText(store.pixCopyPaste!),
            const SizedBox(height: 6),
            OutlinedButton.icon(
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(text: store.pixCopyPaste!),
                );
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Código Pix copiado.')),
                  );
                }
              },
              icon: const Icon(Icons.copy),
              label: const Text('Copiar código Pix'),
            ),
          ],
        ],
      ],
    );
  }

  Widget _notificationMessages(CartStore store) {
    if (widget.isAdmin || store.unreadNotifications.isEmpty)
      return const SizedBox.shrink();
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Atualizações do pedido',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            ...store.unreadNotifications
                .take(3)
                .map(
                  (notification) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.notifications_active_outlined),
                    title: Text(
                      notification['message'] as String? ??
                          'Seu pedido foi atualizado.',
                    ),
                    trailing: IconButton(
                      tooltip: 'Marcar como lida',
                      onPressed: () => store.markNotificationRead(
                        notification['id'].toString(),
                      ),
                      icon: const Icon(Icons.check),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<CartStore>();
    return Observer(
      builder: (_) => RefreshIndicator(
        onRefresh: () => store.load(
          context,
          isAdmin: widget.isAdmin,
          page: store.currentPage,
        ),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          children: [
            _filters(store),
            const SizedBox(height: 12),
            _notificationMessages(store),
            if (store.isLoading) const SkeletonList(count: 3),
            if (!store.isLoading && store.carts.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text('Nenhum item encontrado.')),
              ),
            if (!store.isLoading)
              ...store.carts.map((item) => _cartItem(item, store)),
            if (store.totalPages > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    tooltip: 'Página anterior',
                    onPressed: store.currentPage > 0
                        ? () => store.load(
                            context,
                            isAdmin: widget.isAdmin,
                            page: store.currentPage - 1,
                          )
                        : null,
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Text(
                    'Página ${store.currentPage + 1} de ${store.totalPages}',
                  ),
                  IconButton(
                    tooltip: 'Próxima página',
                    onPressed: store.currentPage + 1 < store.totalPages
                        ? () => store.load(
                            context,
                            isAdmin: widget.isAdmin,
                            page: store.currentPage + 1,
                          )
                        : null,
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            if (!widget.isAdmin) _userPayment(store),
          ],
        ),
      ),
    );
  }
}
