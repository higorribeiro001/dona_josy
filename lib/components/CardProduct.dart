import 'package:flutter/material.dart';
import 'package:dona_josy/utils/product_image_url.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.isAdmin,
    required this.isActive,
    this.onToggleActive,
    this.onAddToCart,
    this.onEdit,
  });

  final String id;
  final String name;
  final String image;
  final String description;
  final double price;
  final bool isAdmin;
  final bool isActive;
  final Future<void> Function()? onToggleActive;
  final Future<void> Function()? onAddToCart;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final imageUrl = productImageUri(image);
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            imageUrl?.toString() ?? '',
            height: 210,
            fit: BoxFit.cover,
            errorBuilder: (_, error, ___) {
              debugPrint('Falha ao carregar imagem $imageUrl: $error');
              return const SizedBox(
                height: 210,
                child: Center(child: Icon(Icons.image_not_supported_outlined)),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(description, maxLines: 3, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isAdmin)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Editar produto',
                            onPressed: onEdit,
                            icon: const Icon(Icons.edit_outlined),
                          ),
                          Text(isActive ? 'Ativo' : 'Inativo'),
                          Switch(
                            value: isActive,
                            onChanged: onToggleActive == null
                                ? null
                                : (_) => onToggleActive!(),
                          ),
                        ],
                      )
                    else
                      FilledButton.tonalIcon(
                        onPressed: onAddToCart,
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text('Adicionar'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
