/// Numero brasileiro normalizado para o formato E.164 exigido pelo Firebase.
class BrazilianPhoneNumber {
  const BrazilianPhoneNumber._({required this.e164, required this.formatted});

  final String e164;
  final String formatted;

  /// Aceita numero nacional ou internacional e remove apenas caracteres de
  /// apresentacao, como espacos, parenteses e hifens.
  static BrazilianPhoneNumber? tryParse(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    final nationalNumber = switch (digits.length) {
      10 || 11 => digits,
      12 || 13 when digits.startsWith('55') => digits.substring(2),
      _ => null,
    };

    if (nationalNumber == null || !_isValidNationalNumber(nationalNumber)) {
      return null;
    }

    return BrazilianPhoneNumber._(
      e164: '+55$nationalNumber',
      formatted: _formatNationalNumber(nationalNumber),
    );
  }

  static bool _isValidNationalNumber(String value) {
    if (!RegExp(r'^[1-9]\d{9,10}$').hasMatch(value)) return false;

    final localNumber = value.substring(2);
    return localNumber.length == 8 || localNumber.length == 9;
  }

  static String _formatNationalNumber(String value) {
    final ddd = value.substring(0, 2);
    final localNumber = value.substring(2);
    final splitAt = localNumber.length == 9 ? 5 : 4;
    return '+55 ($ddd) ${localNumber.substring(0, splitAt)}-${localNumber.substring(splitAt)}';
  }
}
