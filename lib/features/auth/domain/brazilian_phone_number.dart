/// Numero brasileiro normalizado para o formato E.164 exigido pelo Firebase.
class BrazilianPhoneNumber {
  const BrazilianPhoneNumber._({required this.e164, required this.formatted});

  final String e164;
  final String formatted;

  /// Aceita numero de celular nacional ou internacional e remove apenas
  /// caracteres de apresentacao, como espacos, parenteses e hifens.
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
    // Phone Auth envia um SMS. No Brasil, somente celulares possuem os nove
    // digitos locais iniciados por 9; telefones fixos nao sao destinos validos.
    return RegExp(r'^[1-9][1-9]9\d{8}$').hasMatch(value);
  }

  static String _formatNationalNumber(String value) {
    final ddd = value.substring(0, 2);
    final localNumber = value.substring(2);
    return '+55 ($ddd) ${localNumber.substring(0, 5)}-${localNumber.substring(5)}';
  }
}
