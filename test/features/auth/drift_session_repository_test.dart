import 'package:apuraqui/core/database/app_database.dart';
import 'package:apuraqui/features/auth/data/drift_session_repository.dart';
import 'package:apuraqui/features/auth/domain/session_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late SessionRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftSessionRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('aceita somente credenciais validas e persiste sessao', () async {
    final authenticatedDemo = await repository.login(
      login: 'demo@apuraqui.app',
      password: 'Apura@2026',
    );

    expect(authenticatedDemo, isTrue);
    expect((await repository.watchSession().first)?.login, 'demo@apuraqui.app');

    await repository.logout();

    final authenticatedCandidate = await repository.login(
      login: 'candidato@apuraqui.app',
      password: 'Apura@2026',
    );

    expect(authenticatedCandidate, isTrue);
    expect(
      (await repository.watchSession().first)?.login,
      'candidato@apuraqui.app',
    );
  });

  test('credencial invalida nao cria sessao', () async {
    final authenticated = await repository.login(
      login: 'demo@apuraqui.app',
      password: 'senha-incorreta',
    );

    expect(authenticated, isFalse);
    expect(await repository.watchSession().first, isNull);
  });

  test('logout remove sessao persistida', () async {
    await repository.login(login: 'demo@apuraqui.app', password: 'Apura@2026');

    await repository.logout();

    expect(await repository.watchSession().first, isNull);
  });
}
