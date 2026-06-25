import 'package:flutter/material.dart';
import '../../Models/risk_result.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  Color _colorFor(RiskLevel level) {
    switch (level) {
      case RiskLevel.muitoBaixo:
        return const Color(0xFF2E7D32);
      case RiskLevel.baixo:
        return const Color(0xFF66BB6A);
      case RiskLevel.moderado:
        return const Color(0xFFFFA000);
      case RiskLevel.alto:
        return const Color(0xFFE65100);
      case RiskLevel.extremo:
        return const Color(0xFFC62828);
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)!.settings.arguments as RiskResult;
    final color = _colorFor(result.risco);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F3F5),
      appBar: AppBar(
        title: const Text('Resultado da Avaliação'),
        centerTitle: true,
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
            const SizedBox(height: 20),
            _buildAxisCard(
              title: 'Nível de Vulnerabilidade',
              value: result.nivelVulnerabilidade,
              score: result.vulnerabilidade,
            ),
            const SizedBox(height: 12),
            _buildAxisCard(
              title: 'Nível de Ameaça',
              value: result.nivelAmeaca,
              score: result.ameaca,
            ),
            const SizedBox(height: 20),
            _buildRecommendation(result, color),
            const SizedBox(height: 24),
            _buildDisclaimer(),
          ],
        ),
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
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Grau de Risco',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            result.risco.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
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
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            score.toStringAsFixed(2),
            style: const TextStyle(fontSize: 16, color: Colors.grey),
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
          Text(
            'O que você pode fazer agora',
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
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
