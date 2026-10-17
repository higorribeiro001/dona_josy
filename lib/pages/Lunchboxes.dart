import 'package:dona_josy/components/AppText.dart';
import 'package:dona_josy/components/CardProduct.dart';
import 'package:dona_josy/components/SkeletonList.dart';
import 'package:dona_josy/components/FieldCamera.dart';
import 'package:dona_josy/components/TextFormFieldApp.dart';
import 'package:dona_josy/models/lunchboxe.dart';
import 'package:dona_josy/store/lunchboxe.store.dart';
import 'package:dona_josy/utils/currency_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Lunchboxes extends StatefulWidget {
  const Lunchboxes({super.key, required this.isAdmin});
  final bool isAdmin;

  @override
  State<Lunchboxes> createState() => _LunchboxesState();
}

class _LunchboxesState extends State<Lunchboxes> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LunchboxeStore>().getLunchboxes(context, page: 0);
    });
  }

  Future<void> _showProductDialog(
    LunchboxeStore store, {
    Lunchboxe? lunchboxe,
  }) async {
    store.clear();
    if (lunchboxe == null) {
      store.setIsEditing(false);
    } else {
      store.getLunchboxe(lunchboxe);
    }
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(lunchboxe == null ? 'Cadastrar marmita' : 'Editar marmita'),
        content: SingleChildScrollView(
          child: Form(
            key: store.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFieldApp(label: 'Nome*', controller: store.name),
                const SizedBox(height: 8),
                Observer(
                  builder: (_) => FieldCamera(
                    storedImageKit: store.storedImage,
                    takePicture: store.takePicture,
                    label: 'Imagem*:',
                    linkImage: store.image,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormFieldApp(
                  label: 'Descrição*',
                  controller: store.description,
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                TextFormFieldApp(
                  label: 'Preço*',
                  controller: store.price,
                  type: TextInputType.number,
                  inputFormatters: [BrazilianCurrencyInputFormatter()],
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              final saved = await store.addLunchboxe(context);
              if (saved && dialogContext.mounted) Navigator.pop(dialogContext);
            },
            child: Text(lunchboxe == null ? 'Salvar' : 'Atualizar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<LunchboxeStore>();
    return Observer(
      builder: (_) => RefreshIndicator(
        onRefresh: () => store.getLunchboxes(context, page: store.currentPage),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: store.searchName,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) => store.searchLunchboxes(context, value),
                    onSubmitted: (value) => store.searchLunchboxes(
                      context,
                      value,
                      immediate: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Buscar marmita por nome',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        tooltip: 'Limpar busca',
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          store.searchName.clear();
                          store.searchLunchboxes(context, '', immediate: true);
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                if (widget.isAdmin) ...[
                  const SizedBox(width: 8),
                  IconButton.filled(
                    tooltip: 'Cadastrar marmita',
                    onPressed: () => _showProductDialog(store),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            if (store.isLoading) const SkeletonList(productCards: true),
            if (!store.isLoading && store.lunchboxes.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: AppText(text: 'Nenhuma marmita encontrada.', textAlign: TextAlign.center)),
              ),
            if (!store.isLoading)
              ...store.lunchboxes.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CardProduct(
                    id: item.id,
                    name: item.name,
                    image: item.image,
                    description: item.description,
                    price: item.price,
                    isAdmin: widget.isAdmin,
                    isActive: item.isActive,
                    onToggleActive: () => store.setProductActive(item, context),
                    onAddToCart: () => store.addToCart(item, context),
                    onEdit: () => _showProductDialog(store, lunchboxe: item),
                  ),
                ),
              ),
            if (store.totalPages > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    tooltip: 'Página anterior',
                    onPressed: store.currentPage > 0
                        ? () => store.getLunchboxes(
                            context,
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
                        ? () => store.getLunchboxes(
                            context,
                            page: store.currentPage + 1,
                          )
                        : null,
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
