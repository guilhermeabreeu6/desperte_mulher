import 'dart:convert';
import 'package:flutter/services.dart';
import '../../Models/quiz_page.dart';

class QuizServer {
  Future<QuizPageResponse> fetchQuestions([int page = 1]) async {
    final jsonString = await rootBundle.loadString(
      'assets/Mock/page$page.json',
    );

    final Map<String, dynamic> json = jsonDecode(jsonString);

    return QuizPageResponse.fromJson(json);
  }
}
