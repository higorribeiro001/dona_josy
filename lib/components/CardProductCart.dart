import 'package:animate_do/animate_do.dart';
import 'package:dona_josy/components/AppText.dart';
import 'package:dona_josy/components/RowInfo.dart';
import 'package:dona_josy/components/SelectButton.dart';
import 'package:dona_josy/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardProductCart extends StatelessWidget {
  const CardProductCart({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.status,
    required this.paid,
    this.mark,
    this.remove,
    this.onStatusChanged,
    required this.isAdmin,
  });

  final String id;
  final String name;
  final String image;
  final String description;
  final double price;
  final bool isAdmin;
  final String status;
  final bool paid;
  final String? mark;
  final bool? remove;
  final ValueChanged<String>? onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        elevation: 3,
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      image,
                      width: double.maxFinite,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child:
                        mark != null
                            ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                mark!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            )
                            : SizedBox.shrink(),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                    if (isAdmin == false)
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  status == 'Pendente'
                                      ? Colors.grey
                                      : status == 'Em andamento'
                                      ? Colors.orange
                                      : status == 'Entregue'
                                      ? Colors.green
                                      : Colors.red,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                color:
                                    status == 'Pendente'
                                        ? Colors.black
                                        : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: paid ? Colors.green : Colors.red,

                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              paid ? 'Pago' : 'Não pago',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            if (isAdmin == false)
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                child: Icon(
                                  remove == true
                                      ? Icons.remove_shopping_cart
                                      : Icons.add_shopping_cart,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    if (isAdmin) ...[
                      AppText(
                        text: 'Status:',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      Wrap(
                        spacing: 4,
                        children: [
                          for (final option in [
                            'ANDAMENTO',
                            'FINALIZADO',
                            'PAGO',
                            'ENTREGUE',
                            'CANCELADO',
                          ])
                            Selectbutton(
                              title: option,
                              value: status,
                              setValue: (title) => onStatusChanged?.call(title),
                            ),
                        ],
                      ),
                    ],
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RowInfo(
                                  title: 'Cliente:',
                                  value: 'Fulano de tal',
                                ),
                                RowInfo(
                                  title: 'Telefone:',
                                  value: '(91) 99999-9999',
                                ),
                                RowInfo(
                                  title: 'Endereço:',
                                  value: 'Rua Exemplo, 123 - Cidade/UF',
                                  maxLines: 2,
                                  height: 40,
                                ),
                                RowInfo(
                                  title: 'Bairro:',
                                  value: 'JK',
                                  maxLines: 2,
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          color: themeData.primaryColor,
                          onPressed: () async {
                            const phone = '5591984850712';
                            const message =
                                'Olá, aqui está o comprovante de pagamento.';
                            final url =
                                'https://wa.me/$phone?text=${Uri.encodeComponent(message)}';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Não foi possível abrir o WhatsApp',
                                  ),
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.message),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
