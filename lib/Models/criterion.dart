/// Os 6 critérios da metodologia AR PAX/FRIDA.
/// Atratibilidade, Exposição e Casuística compõem a Vulnerabilidade da vítima.
/// Motivação, Histórico e Tendência compõem a Ameaça do agressor.
enum Criterion {
  atratibilidade,
  exposicao,
  casuistica,
  motivacao,
  historico,
  tendencia,
}

extension CriterionParsing on Criterion {
  static Criterion fromJson(String value) {
    return Criterion.values.firstWhere(
      (c) => c.name == value,
      orElse: () => throw ArgumentError('Critério desconhecido: $value'),
    );
  }
}
