import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'application/auth_providers.dart';
import 'domain/brazilian_phone_number.dart';
import 'domain/phone_verification.dart';
import 'widgets/brazilian_phone_input_formatter.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final _phoneFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController(text: '+55');
  final _smsCodeController = TextEditingController();

  PhoneVerification? _verification;
  BrazilianPhoneNumber? _phoneNumber;
  Timer? _resendTimer;
  int _resendSecondsRemaining = 0;
  String? _errorMessage;

  static const _resendCooldown = Duration(seconds: 30);

  @override
  void dispose() {
    _resendTimer?.cancel();
    _phoneController.dispose();
    _smsCodeController.dispose();
    super.dispose();
  }

  Future<void> _requestCode({bool validateForm = true}) async {
    if (validateForm && !(_phoneFormKey.currentState?.validate() ?? false)) {
      return;
    }

    final phoneNumber = BrazilianPhoneNumber.tryParse(_phoneController.text);
    if (phoneNumber == null) return;

    setState(() => _errorMessage = null);
    final verification = await ref
        .read(authControllerProvider.notifier)
        .requestPhoneVerification(phoneNumber.e164);

    if (!mounted) return;

    if (verification == null) {
      setState(() => _errorMessage = _currentAuthErrorMessage());
      return;
    }

    if (verification.autoVerified) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    setState(() {
      _phoneNumber = phoneNumber;
      _phoneController.text = phoneNumber.formatted;
      _verification = verification;
      _resendSecondsRemaining = _resendCooldown.inSeconds;
    });
    _startResendCooldown();
  }

  Future<void> _resendCode() async {
    if (_resendSecondsRemaining > 0) return;
    await _requestCode(validateForm: false);
  }

  void _startResendCooldown() {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _resendSecondsRemaining <= 1) {
        timer.cancel();
        if (mounted) setState(() => _resendSecondsRemaining = 0);
        return;
      }
      setState(() => _resendSecondsRemaining--);
    });
  }

  Future<void> _confirmCode() async {
    if (!(_codeFormKey.currentState?.validate() ?? false)) return;

    final verification = _verification;
    if (verification == null) return;

    setState(() => _errorMessage = null);
    final authenticated = await ref
        .read(authControllerProvider.notifier)
        .confirmPhoneCode(
          verificationId: verification.verificationId,
          smsCode: _smsCodeController.text.trim(),
        );

    if (!mounted) return;

    if (authenticated) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    setState(() => _errorMessage = _currentAuthErrorMessage());
  }

  String _currentAuthErrorMessage() {
    final authState = ref.read(authControllerProvider);
    return authState.when(
      data: (state) => state.message ?? 'Não foi possível autenticar.',
      error: (error, _) =>
          ref.read(authControllerProvider.notifier).messageFor(error),
      loading: () => 'Aguarde a operação em andamento.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(authControllerProvider);
    final flowStatus = asyncState.value?.status ?? AuthFlowStatus.idle;
    final isSending = flowStatus == AuthFlowStatus.sendingCode;
    final isVerifying = flowStatus == AuthFlowStatus.verifyingCode;
    final showingCodeStep = _verification != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Entrar com telefone'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF111827),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _PhoneAuthHeader(),
              const SizedBox(height: 24),
              if (showingCodeStep)
                _CodeStep(
                  formKey: _codeFormKey,
                  controller: _smsCodeController,
                  phoneNumber: _phoneNumber?.formatted ?? _phoneController.text,
                  isSending: isSending,
                  isLoading: isVerifying,
                  resendSecondsRemaining: _resendSecondsRemaining,
                  onConfirm: _confirmCode,
                  onResend: _resendCode,
                  onChangePhone: () {
                    _resendTimer?.cancel();
                    setState(() {
                      _verification = null;
                      _phoneNumber = null;
                      _resendSecondsRemaining = 0;
                      _smsCodeController.clear();
                      _errorMessage = null;
                    });
                  },
                )
              else
                _PhoneStep(
                  formKey: _phoneFormKey,
                  controller: _phoneController,
                  isLoading: isSending,
                  onSubmit: _requestCode,
                ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                _ErrorMessage(message: _errorMessage!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneAuthHeader extends StatelessWidget {
  const _PhoneAuthHeader();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF009B3A), Color(0xFF002776)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.phone_android_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Verificação por SMS',
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(
            color: const Color(0xFF111827),
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Use um número de celular com DDD para receber o código de acesso.',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF6B7280),
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class _PhoneStep extends StatelessWidget {
  const _PhoneStep({
    required this.formKey,
    required this.controller,
    required this.isLoading,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.phone,
            autofillHints: const [AutofillHints.telephoneNumber],
            inputFormatters: [BrazilianPhoneInputFormatter()],
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {
              if (!isLoading) onSubmit();
            },
            decoration: const InputDecoration(
              labelText: 'Telefone',
              hintText: '+55 (85) 99999-9999',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            validator: (value) {
              if (BrazilianPhoneNumber.tryParse(value ?? '') == null) {
                return 'Informe um celular com DDD. Exemplo: (85) 99999-9999';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: isLoading ? null : onSubmit,
              icon: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.sms_outlined),
              label: Text(isLoading ? 'Enviando...' : 'Enviar código'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeStep extends StatelessWidget {
  const _CodeStep({
    required this.formKey,
    required this.controller,
    required this.phoneNumber,
    required this.isSending,
    required this.isLoading,
    required this.resendSecondsRemaining,
    required this.onConfirm,
    required this.onResend,
    required this.onChangePhone,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String phoneNumber;
  final bool isSending;
  final bool isLoading;
  final int resendSecondsRemaining;
  final VoidCallback onConfirm;
  final VoidCallback onResend;
  final VoidCallback onChangePhone;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Código enviado para $phoneNumber',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: 6,
            autofillHints: const [AutofillHints.oneTimeCode],
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              labelText: 'Código SMS',
              counterText: '',
              prefixIcon: Icon(Icons.lock_open_outlined),
            ),
            validator: (value) {
              final code = value?.trim() ?? '';
              if (!RegExp(r'^\d{6}$').hasMatch(code)) {
                return 'Informe o código de 6 dígitos';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: isLoading ? null : onConfirm,
              icon: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.verified_user_outlined),
              label: Text(isLoading ? 'Verificando...' : 'Confirmar código'),
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: isLoading || isSending || resendSecondsRemaining > 0
                ? null
                : onResend,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(
              resendSecondsRemaining > 0
                  ? 'Reenviar em 00:${resendSecondsRemaining.toString().padLeft(2, '0')}'
                  : 'Reenviar código',
            ),
          ),
          TextButton(
            onPressed: isLoading || isSending ? null : onChangePhone,
            child: const Text('Alterar telefone'),
          ),
        ],
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4E4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFE10600)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF7F1D1D)),
            ),
          ),
        ],
      ),
    );
  }
}
