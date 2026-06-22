import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'application/auth_providers.dart';
import 'domain/phone_verification.dart';

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
  String? _errorMessage;

  @override
  void dispose() {
    _phoneController.dispose();
    _smsCodeController.dispose();
    super.dispose();
  }

  Future<void> _requestCode() async {
    if (!(_phoneFormKey.currentState?.validate() ?? false)) return;

    setState(() => _errorMessage = null);
    final verification = await ref
        .read(authControllerProvider.notifier)
        .requestPhoneVerification(_phoneController.text.trim());

    if (!mounted) return;

    if (verification == null) {
      setState(() => _errorMessage = _currentAuthErrorMessage());
      return;
    }

    if (verification.autoVerified) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    setState(() => _verification = verification);
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
                  phoneNumber: _phoneController.text.trim(),
                  isLoading: isVerifying,
                  onConfirm: _confirmCode,
                  onChangePhone: () {
                    setState(() {
                      _verification = null;
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
          'Use o número em formato internacional para receber o código de acesso.',
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
            decoration: const InputDecoration(
              labelText: 'Telefone',
              hintText: '+5585999999999',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            validator: (value) {
              final phone = value?.trim() ?? '';
              final digits = phone.replaceAll(RegExp(r'\D'), '');
              if (!phone.startsWith('+')) {
                return 'Use o formato internacional começando com +55';
              }
              if (digits.length < 12 || digits.length > 15) {
                return 'Informe um telefone válido com DDD';
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
    required this.isLoading,
    required this.onConfirm,
    required this.onChangePhone,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String phoneNumber;
  final bool isLoading;
  final VoidCallback onConfirm;
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
          TextButton(
            onPressed: isLoading ? null : onChangePhone,
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
