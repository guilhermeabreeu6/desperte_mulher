/// Classificação final da Matriz de Risco AR PAX (5 níveis, igual ao portal).
enum RiskLevel { muitoBaixo, baixo, moderado, alto, extremo }

extension RiskLevelInfo on RiskLevel {
  String get label {
    switch (this) {
      case RiskLevel.muitoBaixo:
        return 'Muito Baixo';
      case RiskLevel.baixo:
        return 'Baixo';
      case RiskLevel.moderado:
        return 'Moderado';
      case RiskLevel.alto:
        return 'Alto';
      case RiskLevel.extremo:
        return 'Extremo';
    }
  }

  int get percentual {
    switch (this) {
      case RiskLevel.muitoBaixo:
        return 20;
      case RiskLevel.baixo:
        return 40;
      case RiskLevel.moderado:
        return 60;
      case RiskLevel.alto:
        return 80;
      case RiskLevel.extremo:
        return 100;
    }
  }

  String get recomendacao {
    switch (this) {
      case RiskLevel.muitoBaixo:
        return 'O risco identificado é baixo, mas mesmo assim existe. '
            'Continue atenta a qualquer mudança de comportamento e mantenha contatos de apoio por perto.';
      case RiskLevel.baixo:
        return 'Procure manter uma rede de apoio (familiares, amigos) informada da sua situação '
            'e guarde os contatos de emergência e da Casa da Mulher Brasileira mais próxima.';
      case RiskLevel.moderado:
        return 'Recomendamos buscar orientação especializada (Defensoria Pública, Delegacia da Mulher) '
            'para avaliar medidas protetivas e planejar sua segurança.';
      case RiskLevel.alto:
        return 'Sua situação indica risco elevado. Procure imediatamente a Delegacia da Mulher ou '
            'o Ministério Público para solicitar uma medida protetiva de urgência.';
      case RiskLevel.extremo:
        return 'Risco extremo identificado. Procure ajuda imediatamente: disque 180 (Central de '
            'Atendimento à Mulher) ou 190 (Polícia Militar) e, se possível, vá a um local seguro agora.';
    }
  }
}

class RiskResult {
  final double vulnerabilidade;
  final double ameaca;
  final String nivelVulnerabilidade;
  final String nivelAmeaca;
  final RiskLevel risco;

  RiskResult({
    required this.vulnerabilidade,
    required this.ameaca,
    required this.nivelVulnerabilidade,
    required this.nivelAmeaca,
    required this.risco,
  });
}
