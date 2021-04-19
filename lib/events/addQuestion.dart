import 'package:question_and_answer_app/events/questionsEvent.dart';
import 'package:question_and_answer_app/model/questions.dart';


class AddQuestion extends QuestionsEvent {
  Questions newQuestion;

  AddQuestion(Questions question) {
    newQuestion = question;
  }
}
