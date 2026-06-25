import 'package:flutter/material.dart';
import '../common/app_bar_actions.dart';
import '../common/quick_exit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recursos de Ajuda'),
        centerTitle: true,
        actions: const [AppBarActions()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildSectionLabel('Contatos de Emergência', cs),
            const SizedBox(height: 12),
            _buildContactCard(
              context,
              icon: Icons.phone_in_talk,
              number: '180',
              title: 'Central de Atendimento à Mulher',
              subtitle: 'Gratuito · 24h · 7 dias por semana',
              color: const Color(0xFF7B1FA2),
            ),
            const SizedBox(height: 12),
            _buildContactCard(
              context,
              icon: Icons.local_police,
              number: '190',
              title: 'Polícia Militar',
              subtitle: 'Emergências · disponível 24h',
              color: const Color(0xFFC62828),
            ),
            const SizedBox(height: 12),
            _buildContactCard(
              context,
              icon: Icons.local_hospital,
              number: '192',
              title: 'SAMU',
              subtitle: 'Emergências médicas',
              color: const Color(0xFFE65100),
            ),
            const SizedBox(height: 24),
            _buildSectionLabel('Onde Buscar Ajuda', cs),
            const SizedBox(height: 12),
            _buildInfoCard(
              context,
              icon: Icons.account_balance,
              title: 'Delegacia da Mulher (DEAM)',
              body: 'Registra boletins de ocorrência e solicita medidas protetivas de urgência.',
              cs: cs,
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              context,
              icon: Icons.home_work,
              title: 'Casa da Mulher Brasileira',
              body: 'Oferece acolhimento, assistência jurídica, psicológica e serviço de saúde em um único local.',
              cs: cs,
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              context,
              icon: Icons.gavel,
              title: 'Defensoria Pública',
              body: 'Atendimento jurídico gratuito para orientação legal e solicitação de medidas protetivas.',
              cs: cs,
            ),
            const SizedBox(height: 24),
            _buildSectionLabel('Privacidade', cs),
            const SizedBox(height: 12),
            _buildPrivacyCard(cs),
            const SizedBox(height: 24),
            _buildQuickExitButton(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.shield_outlined, color: Colors.white, size: 36),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Você não está sozinha',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Recursos e contatos para situações de risco.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label, ColorScheme cs) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: cs.onSurface.withValues(alpha: 0.45),
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String number,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          number,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: cs.onSurface.withValues(alpha: 0.55),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String body,
    required ColorScheme cs,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF7B1FA2), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyCard(ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF7B1FA2).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: const Color(0xFF7B1FA2).withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.lock_outline, color: Color(0xFF7B1FA2), size: 18),
              SizedBox(width: 8),
              Text(
                'Anonimato garantido',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF7B1FA2)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Este app não coleta, armazena nem transmite nenhum dado pessoal. '
            'Suas respostas são usadas apenas para calcular o risco e são '
            'descartadas ao sair. Funciona 100% offline.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickExitButton() {
    return OutlinedButton.icon(
      onPressed: quickExit,
      icon: const Icon(Icons.exit_to_app),
      label: const Text('Saída Rápida'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red.shade400,
        side: BorderSide(color: Colors.red.shade300),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
