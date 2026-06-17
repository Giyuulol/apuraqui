import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/preferences/app_preferences_providers.dart';
import 'application/auth_providers.dart';
import 'create_account_screen.dart';
import 'recover_password_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _rememberedLoginLoaded = false;

  @override
  void initState() {
    super.initState();
    Future<void>.microtask(_loadRememberedLogin);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final preferences = ref.read(appPreferencesRepositoryProvider);
    final shouldRememberLogin = _rememberMe;
    final loginToRemember = _emailController.text.trim();

    if (shouldRememberLogin) {
      await preferences.saveRememberedLogin(loginToRemember);
    }

    final authenticated = await ref
        .read(authControllerProvider.notifier)
        .login(
          login: _emailController.text,
          password: _passwordController.text,
        );
    if (authenticated) {
      if (!shouldRememberLogin) {
        await preferences.clearRememberedLogin();
      }
      return;
    }

    if (shouldRememberLogin) {
      await preferences.clearRememberedLogin();
    }

    if (!mounted) return;

    _showAccessDeniedDialog();
  }

  Future<void> _loadRememberedLogin() async {
    final rememberedLogin = await ref
        .read(appPreferencesRepositoryProvider)
        .getRememberedLogin();

    if (!mounted || _rememberedLoginLoaded) return;

    setState(() {
      _rememberedLoginLoaded = true;
      if (rememberedLogin != null && _emailController.text.trim().isEmpty) {
        _emailController.text = rememberedLogin;
        _rememberMe = true;
      }
    });
  }

  void _handleForgotPassword() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const RecoverPasswordScreen()));
  }

  void _handleCreateAccount() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const CreateAccountScreen()));
  }

  void _showAccessDeniedDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFE4E4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: Color(0xFFE10600),
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Acesso Negado',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: const Color(0xFF111827),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'E-mail, CPF ou senha incorretos. Verifique seus dados e tente novamente.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6B7280),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF111827),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Tentar Novamente'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF002776),
                    side: const BorderSide(color: Color(0xFF002776), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _handleForgotPassword();
                  },
                  child: const Text('Esqueci minha senha'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider).isLoading;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF009B3A), Color(0xFFFFDF00), Color(0xFF002776)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const Positioned(
                top: -96,
                right: -96,
                child: _DecorativeCircle(size: 260, opacity: 0.24),
              ),
              const Positioned(
                bottom: -112,
                left: -112,
                child: _DecorativeCircle(size: 280, opacity: 0.18),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 430),
                    child: Column(
                      children: [
                        _LoginCard(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          obscurePassword: _obscurePassword,
                          rememberMe: _rememberMe,
                          isLoading: isLoading,
                          onTogglePassword: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          onRememberMeChanged: (value) {
                            setState(() {
                              _rememberMe = value;
                            });
                          },
                          onForgotPassword: _handleForgotPassword,
                          onSubmit: _handleLogin,
                          onCreateAccount: _handleCreateAccount,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.rememberMe,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onRememberMeChanged,
    required this.onForgotPassword,
    required this.onSubmit,
    required this.onCreateAccount,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool rememberMe;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final ValueChanged<bool> onRememberMeChanged;
  final VoidCallback onForgotPassword;
  final VoidCallback onSubmit;
  final VoidCallback onCreateAccount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.22),
            blurRadius: 32,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _BrandHeader(),
            const SizedBox(height: 22),
            Text(
              'Entrar',
              style: textTheme.titleLarge?.copyWith(
                color: const Color(0xFF111827),
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            _LabeledTextField(
              controller: emailController,
              label: 'E-mail ou CPF',
              hint: 'email@exemplo.com',
              icon: Icons.person_outline,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                final input = value?.trim() ?? '';
                if (input.isEmpty) return 'Informe seu e-mail ou CPF';
                if (input.length > 100) {
                  return 'Informe no máximo 100 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _LabeledTextField(
              controller: passwordController,
              label: 'Senha',
              hint: 'Digite sua senha',
              icon: Icons.lock_outline,
              obscureText: obscurePassword,
              trailing: IconButton(
                tooltip: obscurePassword ? 'Mostrar senha' : 'Ocultar senha',
                onPressed: onTogglePassword,
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Informe sua senha';
                if (!_isStrongPassword(value)) {
                  return 'Use 8+ caracteres com letra, número e símbolo';
                }
                if (value.length > 50) {
                  return 'Informe no máximo 50 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: MergeSemantics(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => onRememberMeChanged(!rememberMe),
                      child: Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) =>
                                onRememberMeChanged(value ?? false),
                            activeColor: const Color(0xFF009B3A),
                            visualDensity: VisualDensity.compact,
                          ),
                          const Flexible(child: Text('Lembrar-me')),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: onForgotPassword,
                      child: const Text(
                        'Esqueci a senha',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF002776),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _PrimaryLoginButton(isLoading: isLoading, onPressed: onSubmit),
            const SizedBox(height: 22),
            const _DividerLabel(),
            const SizedBox(height: 18),
            SizedBox(
              height: 50,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF002776),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: onCreateAccount,
                child: Text(
                  'Criar nova conta',
                  style: textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool _isStrongPassword(String value) {
  if (value.length < 8) return false;
  final hasLetter = RegExp(r'[A-Za-zÀ-ÿ]').hasMatch(value);
  final hasNumber = RegExp(r'\d').hasMatch(value);
  final hasSymbol = RegExp(r'[^A-Za-zÀ-ÿ0-9]').hasMatch(value);
  return hasLetter && hasNumber && hasSymbol;
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          width: 82,
          height: 82,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF009B3A), Color(0xFF002776)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 39, 118, 0.25),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.how_to_vote_outlined,
            color: Colors.white,
            size: 44,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'ApurAqui',
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium?.copyWith(
            color: const Color(0xFF111827),
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Apuração eleitoral na palma da sua mão!',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(color: const Color(0xFF6B7280)),
        ),
      ],
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  const _LabeledTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.trailing,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? trailing;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: const Color(0xFF374151),
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: const Color(0xFF9CA3AF)),
            suffixIcon: trailing,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFF009B3A), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE10600), width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE10600), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _PrimaryLoginButton extends StatelessWidget {
  const _PrimaryLoginButton({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF009B3A), Color(0xFF002776)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 39, 118, 0.26),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: isLoading ? null : onPressed,
          icon: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.arrow_forward_rounded),
          label: Text(isLoading ? 'Entrando...' : 'Acessar Sistema'),
        ),
      ),
    );
  }
}

class _DividerLabel extends StatelessWidget {
  const _DividerLabel();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('ou'),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  const _DecorativeCircle({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }
}
