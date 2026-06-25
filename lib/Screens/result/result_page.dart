import 'package:flutter/material.dart';
import '../../Models/risk_result.dart';
import '../../common/app_bar_actions.dart';
import '../../common/app_routes.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  static const _levelColors = [
    Color(0xFF2E7D32),
    Color(0xFF66BB6A),
    Color(0xFFFFA000),
    Color(0xFFE65100),
    Color(0xFFC62828),
  ];

  static const _levelLabels = ['Muito\nBaixo', 'Baixo', 'Moderado', 'Alto', 'Extremo'];

  Color _colorFor(RiskLevel level) => _levelColors[level.index];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final RiskResult result;
    String? name;
    if (args is RiskResult) {
      result = args;
    } else {
      final map = args as Map<String, dynamic>;
      result = map['result'] as RiskResult;
      name = map['name'] as String?;
    }

    final color = _colorFor(result.risco);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(name != null ? 'Resultado de $name' : 'Resultado da Avaliação'),
        centerTitle: true,
        actions: const [AppBarActions()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (result.risco == RiskLevel.alto || result.risco == RiskLevel.extremo)
              _buildEmergencyBanner(),
            if (result.risco == RiskLevel.alto || result.risco == RiskLevel.extremo)
              const SizedBox(height: 16),
            _buildRiskCard(result, color),
            const SizedBox(height: 16),
            _buildRiskLevelBar(result.risco, cs),
            const SizedBox(height: 20),
            _buildAxisCard(
              title: 'Nível de Vulnerabilidade',
              value: result.nivelVulnerabilidade,
              score: result.vulnerabilidade,
              cs: cs,
            ),
            const SizedBox(height: 12),
            _buildAxisCard(
              title: 'Nível de Ameaça',
              value: result.nivelAmeaca,
              score: result.ameaca,
              cs: cs,
            ),
            const SizedBox(height: 20),
            _buildRecommendation(result, color),
            const SizedBox(height: 24),
            _buildDisclaimer(),
            const SizedBox(height: 16),
            Center(
              child: TextButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.profilePage),
                icon: const Icon(Icons.shield_outlined, size: 16),
                label: const Text('Ver recursos de ajuda'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskLevelBar(RiskLevel current, ColorScheme cs) {
    final levels = RiskLevel.values;
    final currentIndex = current.index;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Escala de Risco',
            style: TextStyle(
              fontSize: 12,
              color: cs.onSurface.withValues(alpha: 0.6),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(levels.length, (i) {
              final isActive = i == currentIndex;
              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isActive)
                      Icon(Icons.arrow_drop_down, color: _levelColors[i], size: 22)
                    else
                      const SizedBox(height: 22),
                    Container(
                      height: isActive ? 20 : 12,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: _levelColors[i].withValues(alpha: isActive ? 1.0 : 0.25),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: _levelColors[i].withValues(alpha: 0.45),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _levelLabels[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 9,
                        height: 1.3,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                        color: isActive
                            ? _levelColors[i]
                            : cs.onSurface.withValues(alpha: 0.35),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFC62828),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_rounded, color: Colors.white, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Procure ajuda imediatamente',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Disque 180 — Central da Mulher\nDisque 190 — Polícia Militar',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskCard(RiskResult result, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.75)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Grau de Risco',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            result.risco.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${result.risco.percentual}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAxisCard({
    required String title,
    required String value,
    required double score,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: cs.onSurface.withValues(alpha: 0.6),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            score.toStringAsFixed(2),
            style: TextStyle(fontSize: 16, color: cs.onSurface.withValues(alpha: 0.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendation(RiskResult result, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                'O que você pode fazer agora',
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(result.risco.recomendacao),
        ],
      ),
    );
  }

  Widget _buildDisclaimer() {
    return const Text(
      'Esta avaliação tem caráter informativo e não substitui o atendimento de '
      'serviços especializados de proteção à mulher.',
      style: TextStyle(fontSize: 12, color: Colors.grey),
      textAlign: TextAlign.center,
    );
  }
}
