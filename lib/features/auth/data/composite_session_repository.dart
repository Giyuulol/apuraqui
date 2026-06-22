import 'dart:async';

import '../domain/auth_session.dart';
import '../domain/phone_verification.dart';
import '../domain/session_repository.dart';

class CompositeSessionRepository implements SessionRepository {
  CompositeSessionRepository({
    required SessionRepository demoRepository,
    required SessionRepository phoneRepository,
  }) : _demoRepository = demoRepository,
       _phoneRepository = phoneRepository;

  final SessionRepository _demoRepository;
  final SessionRepository _phoneRepository;

  @override
  Stream<AuthSession?> watchSession() {
    late StreamController<AuthSession?> controller;
    StreamSubscription<AuthSession?>? demoSubscription;
    StreamSubscription<AuthSession?>? phoneSubscription;
    AuthSession? demoSession;
    AuthSession? phoneSession;

    void emitCurrent() {
      if (!controller.isClosed) {
        controller.add(phoneSession ?? demoSession);
      }
    }

    controller = StreamController<AuthSession?>(
      onListen: () {
        demoSubscription = _demoRepository.watchSession().listen((session) {
          demoSession = session;
          emitCurrent();
        }, onError: controller.addError);

        phoneSubscription = _phoneRepository.watchSession().listen((session) {
          phoneSession = session;
          emitCurrent();
        }, onError: controller.addError);
      },
      onCancel: () async {
        await demoSubscription?.cancel();
        await phoneSubscription?.cancel();
      },
    );

    return controller.stream;
  }

  @override
  Future<bool> signInWithDemoCredentials({
    required String login,
    required String password,
  }) async {
    await _phoneRepository.logout();
    return _demoRepository.signInWithDemoCredentials(
      login: login,
      password: password,
    );
  }

  @override
  Future<PhoneVerification> requestPhoneVerification(String phoneNumber) async {
    await _demoRepository.logout();
    return _phoneRepository.requestPhoneVerification(phoneNumber);
  }

  @override
  Future<AuthSession> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  }) {
    return _phoneRepository.confirmPhoneCode(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  @override
  Future<void> logout() async {
    await Future.wait([_demoRepository.logout(), _phoneRepository.logout()]);
  }
}
