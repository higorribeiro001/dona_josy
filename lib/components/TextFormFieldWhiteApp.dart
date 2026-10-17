import 'package:dona_josy/store/register.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWhiteApp extends StatefulWidget {
  const TextFormFieldWhiteApp({
    super.key,
    required this.label,
    this.placeholder,
    this.icon,
    this.controller,
    this.onFieldSubmitted,
    this.focusNode,
    this.onChaged,
    this.obscureText,
    this.store,
    this.inputFormatters,
    this.keyboardType,
  });
  final String? label;
  final String? placeholder;
  final Icon? icon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChaged;
  final bool? obscureText;
  final RegisterStore? store;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  State<TextFormFieldWhiteApp> createState() => _TextFormFieldWhiteAppState();
}

class _TextFormFieldWhiteAppState extends State<TextFormFieldWhiteApp> {
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
        keyboardType: widget.keyboardType ?? TextInputType.text,
        cursorColor: Colors.white,
        decoration: InputDecoration(
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
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelText: widget.label,
          hintText: widget.placeholder ?? '',
          suffixIconColor: Colors.white,
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
        ),
        style: TextStyle(color: Colors.white, fontSize: 14.0),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Este campo é obrigatório';
          }

          if (widget.store?.password.text != widget.store?.confPassword.text) {
            return 'As senhas não coincidem';
          }

          return null;
        },
        focusNode: widget.focusNode,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: isPassword,
        onChanged: widget.onChaged,
      ),
    );
  }
}
