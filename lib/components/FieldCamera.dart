import 'dart:io';

import 'package:dona_josy/components/AppText.dart';
import 'package:dona_josy/utils/product_image_url.dart';
import 'package:flutter/material.dart';

class FieldCamera extends StatefulWidget {
  const FieldCamera({
    super.key,
    required this.storedImageKit,
    required this.takePicture,
    required this.label,
    this.linkImage,
  });

  final File? storedImageKit;
  final Function(String) takePicture;
  final String label;
  final String? linkImage;

  @override
  State<FieldCamera> createState() => _FieldCameraState();
}

class _FieldCameraState extends State<FieldCamera> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.maxFinite,
          alignment: Alignment.centerLeft,
          child: AppText(text: widget.label, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        if (widget.storedImageKit != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              widget.storedImageKit!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          )
        else if (widget.linkImage?.isNotEmpty == true)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              productImageUri(widget.linkImage)?.toString() ?? '',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _emptyPreview(),
            ),
          )
        else
          _emptyPreview(),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () => widget.takePicture('camera'),
                icon: const Icon(Icons.camera_alt),
                label: const AppText(text: 'Tirar foto', fontSize: 12.0,),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: () => widget.takePicture('gallery'),
                icon: const Icon(Icons.image),
                label: const AppText(text: 'Galeria', fontSize: 12.0,),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _emptyPreview() => Container(
    width: double.infinity,
    height: 200,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Center(child: AppText(text: 'Nenhuma imagem selecionada', textAlign: TextAlign.center)),
  );
}
