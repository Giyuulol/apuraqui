import 'package:flutter/services.dart';

/// Mantem uma mascara visual sem alterar a regra de normalizacao do dominio.
class BrazilianPhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final includesCountryCode = newValue.text.trimLeft().startsWith('+');
    final hasCountryCode = includesCountryCode && digits.startsWith('55');
    final nationalNumber = hasCountryCode ? digits.substring(2) : digits;

    if (nationalNumber.length > 11) return oldValue;

    final formattedNationalNumber = _formatNationalNumber(nationalNumber);
    final formatted = hasCountryCode
        ? '+55${formattedNationalNumber.isEmpty ? '' : ' $formattedNationalNumber'}'
        : formattedNationalNumber;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatNationalNumber(String value) {
    if (value.isEmpty) return '';

    final buffer = StringBuffer();
    final hyphenIndex = value.length == 11 ? 7 : 6;
    for (var index = 0; index < value.length; index++) {
      if (index == 2) buffer.write(') ');
      if (index == 0) buffer.write('(');
      if (index == hyphenIndex) buffer.write('-');
      buffer.write(value[index]);
    }
    return buffer.toString();
  }
}
