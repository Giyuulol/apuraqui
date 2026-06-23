import 'package:apuraqui/features/auth/domain/brazilian_phone_number.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('normaliza numero nacional para E.164', () {
    final phoneNumber = BrazilianPhoneNumber.tryParse('(85) 99999-9999');

    expect(phoneNumber?.e164, '+5585999999999');
    expect(phoneNumber?.formatted, '+55 (85) 99999-9999');
  });

  test('aceita numero internacional formatado', () {
    final phoneNumber = BrazilianPhoneNumber.tryParse('+55 (85) 99999-9999');

    expect(phoneNumber?.e164, '+5585999999999');
  });

  test('rejeita telefone fixo porque Phone Auth exige destino SMS', () {
    expect(BrazilianPhoneNumber.tryParse('(85) 9999-9999'), isNull);
  });

  test('rejeita telefone sem DDD e numero completo', () {
    expect(BrazilianPhoneNumber.tryParse('99999-9999'), isNull);
  });
}
