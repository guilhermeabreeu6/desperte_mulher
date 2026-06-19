import 'question.dart';

class QuizPageResponse {
  final int page;
  final int lastPage;
  final String stepTitle;
  final List<Question> questions;

  QuizPageResponse({
    required this.page,
    required this.lastPage,
    required this.stepTitle,
    required this.questions,
  });

  factory QuizPageResponse.fromJson(Map<String, dynamic> json) {
    return QuizPageResponse(
      page: json['page'] as int,
      lastPage: json['lastPage'] as int,
      stepTitle: json['stepTitle'] as String? ?? '',
      questions: (json['questions'] as List)
          .map((e) => Question.fromJson(e))
          .toList(),
    );
  }
}
