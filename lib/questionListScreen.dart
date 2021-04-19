import 'package:flutter/material.dart';
import 'package:question_and_answer_app/questionsList.dart';

class QuestionsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Question and Answers Platform')),
      body: QuestionsList(),
    );
  }
}
