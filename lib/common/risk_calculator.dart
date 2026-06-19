import '../Models/criterion.dart';
import '../Models/risk_result.dart';

/// Replica fielmente o algoritmo da planilha oficial "Planilha Ajustada.xlsm"
/// (metodologia AR PAX/FRIDA) usada pelo Desperte Mulher.
///
/// Etapas (idênticas às fórmulas da aba "Para testes"):
/// 1. Soma bruta de respostas afirmativas por critério.
/// 2. Conversão da soma bruta em um nível numérico (VR) de 0 a 5.
/// 3. Multiplicação do VR pelo peso do critério (FINAL = VR * PESO).
/// 4. Soma dos 3 critérios de Vulnerabilidade e dos 3 de Ameaça.
/// 5. Classificação de cada eixo em 5 níveis.
/// 6. Cruzamento dos dois eixos na Matriz de Risco -> classificação final.
///
/// Observação: a planilha oficial reaproveita as mesmas faixas numéricas da
/// Vulnerabilidade para classificar a Ameaça (não há uma fórmula separada
/// para a Ameaça na aba de testes). Esse comportamento foi mantido aqui de
/// propósito, para que o app reproduza exatamente o que a planilha calcula.
class RiskCalculator {
  static const _groupA = [2, 4, 5, 7]; // Atratibilidade, Exposição
  static const _groupB = [3, 6, 8, 11]; // Casuística, Motivação, Histórico
  static const _tendenciaThresholds = [4, 7, 10, 13];

  static const Map<Criterion, double> _weights = {
    Criterion.atratibilidade: 1 / 3,
    Criterion.exposicao: 1 / 2,
    Criterion.casuistica: 1 / 4,
    Criterion.motivacao: 1.0,
    Criterion.historico: 1 / 3,
    Criterion.tendencia: 1 / 2,
  };

  // Limiares finais (V MÍN da escala de Vulnerabilidade na planilha),
  // reaproveitados também para a Ameaça.
  static const List<double> _classificationThresholds = [1.1, 2.22, 3.59, 4.66];

  static const List<String> _vulnerabilidadeLevels = [
    'MUITO BAIXA',
    'BAIXA',
    'MEDIA',
    'ALTA',
    'MUITO ALTA',
  ];

  static const List<String> _ameacaLevels = [
    'INSIGNIFICANTE',
    'PEQUENA',
    'MODERADA',
    'SIGNIFICANTE',
    'EXTREMA',
  ];

  // Matriz de Risco: linha = nível de Vulnerabilidade, coluna = nível de Ameaça.
  static const List<List<RiskLevel>> _matrix = [
    // INSIGNIFICANTE      PEQUENA              MODERADA             SIGNIFICANTE         EXTREMA
    [RiskLevel.muitoBaixo, RiskLevel.muitoBaixo, RiskLevel.baixo, RiskLevel.alto, RiskLevel.alto], // MUITO BAIXA
    [RiskLevel.muitoBaixo, RiskLevel.baixo, RiskLevel.moderado, RiskLevel.alto, RiskLevel.alto], // BAIXA
    [RiskLevel.baixo, RiskLevel.baixo, RiskLevel.moderado, RiskLevel.extremo, RiskLevel.extremo], // MEDIA
    [RiskLevel.baixo, RiskLevel.moderado, RiskLevel.alto, RiskLevel.extremo, RiskLevel.extremo], // ALTA
    [RiskLevel.moderado, RiskLevel.moderado, RiskLevel.alto, RiskLevel.extremo, RiskLevel.extremo], // MUITO ALTA
  ];

  static int _vr(int raw, List<int> thresholds) {
    if (raw <= 0) return 0;
    if (raw < thresholds[0]) return 1;
    if (raw < thresholds[1]) return 2;
    if (raw < thresholds[2]) return 3;
    if (raw < thresholds[3]) return 4;
    return 5;
  }

  static int _levelIndex(double value) {
    for (var i = 0; i < _classificationThresholds.length; i++) {
      if (value < _classificationThresholds[i]) return i;
    }
    return _classificationThresholds.length;
  }

  static RiskResult calculate(Map<Criterion, int> rawTotals) {
    int raw(Criterion c) => rawTotals[c] ?? 0;

    final vrAtratibilidade = _vr(raw(Criterion.atratibilidade), _groupA);
    final vrExposicao = _vr(raw(Criterion.exposicao), _groupA);
    final vrCasuistica = _vr(raw(Criterion.casuistica), _groupB);
    final vrMotivacao = _vr(raw(Criterion.motivacao), _groupB);
    final vrHistorico = _vr(raw(Criterion.historico), _groupB);
    final vrTendencia = _vr(raw(Criterion.tendencia), _tendenciaThresholds);

    final finalAtratibilidade = vrAtratibilidade * _weights[Criterion.atratibilidade]!;
    final finalExposicao = vrExposicao * _weights[Criterion.exposicao]!;
    final finalCasuistica = vrCasuistica * _weights[Criterion.casuistica]!;
    final finalMotivacao = vrMotivacao * _weights[Criterion.motivacao]!;
    final finalHistorico = vrHistorico * _weights[Criterion.historico]!;
    final finalTendencia = vrTendencia * _weights[Criterion.tendencia]!;

    final vulnerabilidade = finalAtratibilidade + finalExposicao + finalCasuistica;
    final ameaca = finalMotivacao + finalHistorico + finalTendencia;

    final vulnIndex = _levelIndex(vulnerabilidade);
    final ameacaIndex = _levelIndex(ameaca);

    final risco = _matrix[vulnIndex][ameacaIndex];

    return RiskResult(
      vulnerabilidade: vulnerabilidade,
      ameaca: ameaca,
      nivelVulnerabilidade: _vulnerabilidadeLevels[vulnIndex],
      nivelAmeaca: _ameacaLevels[ameacaIndex],
      risco: risco,
    );
  }
}
