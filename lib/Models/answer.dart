/// Representa uma opção de resposta de uma questão.
///
/// [activates] indica se a seleção dessa opção conta como afirmativa
/// para os critérios da questão (equivalente ao valor 0/1 das fórmulas
/// da planilha oficial AR PAX/FRIDA).
class Answer {
  final String title;
  final bool activates;

  Answer({
    required this.title,
    required this.activates,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      title: json['title'] as String,
      activates: json['activates'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'activates': activates,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Answer && other.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}
