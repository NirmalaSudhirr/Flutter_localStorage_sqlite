import 'package:question_and_answer_app/events/questionsEvent.dart';


class DeleteQuestion extends QuestionsEvent {
  int questionsIndex;

  DeleteQuestion(int index) {
    questionsIndex = index;
  }
}
