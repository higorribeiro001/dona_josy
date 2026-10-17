import 'package:flutter/services.dart';

String formatPhoneNumber(String value) {
  final digits = value.replaceAll(RegExp(r'\D'), '');
  final phone = digits.length > 10 ? digits.substring(0, 10) : digits;
  if (phone.isEmpty) return '';
  if (phone.length <= 2) return '($phone';

  final areaCode = phone.substring(0, 2);
  final firstPart = phone.substring(2, phone.length.clamp(2, 6).toInt());
  final secondPart = phone.length > 6 ? '-${phone.substring(6)}' : '';
  return '($areaCode) $firstPart$secondPart';
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final phone = digits.length > 10 ? digits.substring(0, 10) : digits;
    final formatted = formatPhoneNumber(phone);
    final selectionOffset = newValue.selection.extentOffset
        .clamp(0, newValue.text.length)
        .toInt();
    final cursorDigits = newValue.selection.isValid
        ? newValue.text
              .substring(0, selectionOffset)
              .replaceAll(RegExp(r'\D'), '')
              .length
        : phone.length;

    var cursorOffset = 0;
    var seenDigits = 0;
    while (cursorOffset < formatted.length && seenDigits < cursorDigits) {
      if (RegExp(r'\d').hasMatch(formatted[cursorOffset])) seenDigits++;
      cursorOffset++;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorOffset),
    );
  }
}
