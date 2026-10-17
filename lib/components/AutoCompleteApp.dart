import 'package:dona_josy/components/TextFormFieldApp.dart';
import 'package:flutter/material.dart';

class AutocompleteApp extends StatefulWidget {
  const AutocompleteApp({
    super.key,
    required this.options,
    this.label,
    this.placeholder,
    this.icon,
    this.onSelected,
    this.controller,
    this.onChaged,
  });
  final List<Map<String, String>> options;
  final String? label;
  final String? placeholder;
  final Icon? icon;
  final ValueChanged<Map<String, String>>? onSelected;
  final TextEditingController? controller;
  final Function(String)? onChaged;

  @override
  State<AutocompleteApp> createState() => _AutocompleteAppState();
}

class _AutocompleteAppState extends State<AutocompleteApp> {
  String selectedLabel = '';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Autocomplete<Map<String, String>>(
          displayStringForOption:
              (Map<String, String> option) => option['label'] ?? '',
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<Map<String, String>>.empty();
            }
            return widget.options.where((option) {
              final label = option['label'] ?? '';
              return label.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
            });
          },
          onSelected: (Map<String, String> selection) {
            setState(() {
              widget.controller?.text = selection['label'] ?? '';
              widget.onSelected?.call(selection);
            });
          },
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController _controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            _controller.text = widget.controller?.text ?? '';

            return TextFormFieldApp(
              label: widget.label,
              controller: _controller,
              focusNode: focusNode,
              onFieldSubmitted: (value) => onFieldSubmitted(),
              placeholder: widget.placeholder,
              icon: widget.icon,
              onChaged: widget.onChaged,
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                child: Container(
                  width: constraints.maxWidth,
                  height: 60.0 * options.length.clamp(1, 5),
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final option = options.elementAt(index);
                      return ListTile(
                        title: Text(
                          option['label'] ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => onSelected(option),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
