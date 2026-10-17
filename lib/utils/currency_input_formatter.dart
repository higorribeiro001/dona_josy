import 'package:flutter/services.dart';

String formatBrazilianCurrencyValue(double value) {
  final centsText = (value * 100).round().toString().padLeft(3, '0');
  final whole = centsText.substring(0, centsText.length - 2);
  final cents = centsText.substring(centsText.length - 2);
  final groupedWhole = whole.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return '$groupedWhole,$cents';
}

class BrazilianCurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) {
      return const TextEditingValue(text: '');
    }

    final formatted = formatBrazilianCurrencyValue(
      int.parse(digits).toDouble() / 100,
    );
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
