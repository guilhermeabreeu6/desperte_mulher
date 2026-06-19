import 'answer.dart';
import 'criterion.dart';

enum QuestionType { single, multiple }

/// Uma questão do formulário FRIDA/AR PAX.
///
/// [criteria] define quais dos 6 critérios essa questão alimenta quando
/// o(a) usuário(a) seleciona ao menos uma resposta com [Answer.activates]
/// igual a true (regra idêntica para perguntas de escolha única e múltipla).
class Question {
  final String title;
  final QuestionType type;
  final List<Answer> answers;
  final List<Criterion> criteria;

  Question({
    required this.title,
    required this.type,
    required this.answers,
    required this.criteria,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      title: json['title'] as String,
      type: (json['type'] as String?) == 'multiple'
          ? QuestionType.multiple
          : QuestionType.single,
      answers: (json['answers'] as List)
          .map((item) => Answer.fromJson(item))
          .toList(),
      criteria: (json['criteria'] as List)
          .map((item) => CriterionParsing.fromJson(item as String))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type == QuestionType.multiple ? 'multiple' : 'single',
      'answers': answers.map((e) => e.toJson()).toList(),
      'criteria': criteria.map((e) => e.name).toList(),
    };
  }
}
