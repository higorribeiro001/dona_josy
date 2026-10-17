import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldApp extends StatefulWidget {
  const TextFormFieldApp({
    super.key,
    required this.label,
    this.placeholder,
    this.icon,
    this.controller,
    this.onFieldSubmitted,
    this.focusNode,
    this.obscureText,
    this.onChaged,
    this.type,
    this.maxLines,
    this.inputFormatters,
  });
  final String? label;
  final String? placeholder;
  final Icon? icon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final bool? obscureText;
  final Function(String)? onChaged;
  final TextInputType? type;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<TextFormFieldApp> createState() => _TextFormFieldAppState();
}

class _TextFormFieldAppState extends State<TextFormFieldApp> {
  bool isPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.obscureText != null && widget.obscureText == true) {
      isPassword = widget.obscureText ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: TextFormField(
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.label,
          hintText: widget.placeholder ?? '',
          prefixIcon: widget.obscureText == null ? widget.icon : null,
          suffixIcon: widget.obscureText != null
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  child: Icon(
                    isPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : const SizedBox(),
        ),
        onChanged: widget.onChaged,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Este campo é obrigatório';
          }
          return null;
        },
        focusNode: widget.focusNode,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: isPassword,
        keyboardType: widget.type ?? TextInputType.text,
        maxLines: widget.maxLines ?? 1,
      ),
    );
  }
}
