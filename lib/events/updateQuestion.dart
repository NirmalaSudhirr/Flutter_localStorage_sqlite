import 'package:question_and_answer_app/events/questionsEvent.dart';
import 'package:question_and_answer_app/model/questions.dart';


class UpdateQuestion extends QuestionsEvent {
  Questions newQuestion;
  int questionIndex;

  UpdateQuestion(int index, Questions question) {
    newQuestion = question;
    questionIndex = index;
  }
}
