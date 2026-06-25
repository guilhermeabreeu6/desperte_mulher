import 'package:flutter/material.dart';
import '../common/app_routes.dart';
import '../common/app_bar_actions.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildGradientHeader(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  _buildDescription(context),
                  const SizedBox(height: 20),
                  _buildPrivacyBadge(context),
                  const Spacer(),
                  _buildAnonymousButton(context),
                  const SizedBox(height: 12),
                  _buildIdentifiedButton(context),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.of(context).padding.top + 36,
        24,
        36,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Desperte Mulher',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Avaliação de risco — AR PAX/FRIDA',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -8,
            right: -8,
            child: Theme(
              data: ThemeData.dark(),
              child: const AppBarActions(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      'Responda um questionário de 5 etapas e descubra seu nível de risco '
      'de violência doméstica com base na metodologia AR PAX/FRIDA.',
      style: TextStyle(
        fontSize: 16,
        height: 1.6,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPrivacyBadge(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF7B1FA2).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF7B1FA2).withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock_outline, color: Color(0xFF7B1FA2), size: 16),
          const SizedBox(width: 8),
          Text(
            'Nenhum dado é armazenado ou enviado',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnonymousButton(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.quizPage),
        icon: const Icon(Icons.person_off_outlined),
        label: const Text(
          'Iniciar questionário anonimamente',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildIdentifiedButton(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () => _showNameSheet(context),
        icon: const Icon(Icons.person_outline),
        label: const Text(
          'Iniciar questionário se identificando',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  void _showNameSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => _NameSheet(
        onConfirm: (name) {
          Navigator.pop(sheetContext);
          Navigator.pushNamed(
            context,
            AppRoutes.quizPage,
            arguments: name,
          );
        },
        onSkip: () {
          Navigator.pop(sheetContext);
          Navigator.pushNamed(context, AppRoutes.quizPage);
        },
      ),
    );
  }
}

class _NameSheet extends StatefulWidget {
  final ValueChanged<String> onConfirm;
  final VoidCallback onSkip;

  const _NameSheet({required this.onConfirm, required this.onSkip});

  @override
  State<_NameSheet> createState() => _NameSheetState();
}

class _NameSheetState extends State<_NameSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirm() {
    final name = _controller.text.trim();
    if (name.isNotEmpty) {
      widget.onConfirm(name);
    } else {
      widget.onSkip();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Como podemos te chamar?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'Apenas o primeiro nome — usado só para personalizar o resultado. '
            'Nada é salvo.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Seu nome',
              prefixIcon: Icon(Icons.person_outline),
            ),
            onSubmitted: (_) => _confirm(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _confirm,
              child: const Text('Continuar', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: widget.onSkip,
            child: const Text('Continuar sem me identificar'),
          ),
        ],
      ),
    );
  }
}
