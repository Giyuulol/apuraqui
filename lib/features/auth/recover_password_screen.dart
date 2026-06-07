import 'package:flutter/material.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  static const _knownEmail = 'demo@apuraqui.app';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (_emailController.text.trim().toLowerCase() != _knownEmail) {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Conta não encontrada'),
          content: Text(
            'Não encontramos nenhum registro para ${_emailController.text.trim()}. Verifique se o dado foi digitado corretamente.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tentar Novamente'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Criar Nova Conta'),
            ),
          ],
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            PasswordRecoverySentScreen(email: _emailController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF12A150), Color(0xFF0B4B9A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.how_to_vote_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'ApurAqui',
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A2A5E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Recuperação de Senha',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'Digite seu e-mail cadastrado para receber as instruções de recuperação de senha.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 18),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'seu@email.com',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (!email.contains('@') || !email.contains('.')) {
                      return 'Informe um e-mail válido';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.mail_outline),
                  label: const Text('Enviar Instruções'),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Lembrou a senha? Voltar ao Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordRecoverySentScreen extends StatelessWidget {
  const PasswordRecoverySentScreen({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF12A150), Color(0xFF0B4B9A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.how_to_vote_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'ApurAqui',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1A2A5E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Recuperação de Senha',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F5E1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: Color(0xFFD1FAE5),
                        child: Icon(
                          Icons.check_rounded,
                          color: Color(0xFF168821),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'E-mail Enviado!',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enviamos as instruções de recuperação de senha para $email',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7D6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Verifique sua caixa de entrada e também a pasta de spam. O link de recuperação expira em 24 horas.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(
                      context,
                    ).popUntil((route) => route.isFirst),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Voltar ao Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
