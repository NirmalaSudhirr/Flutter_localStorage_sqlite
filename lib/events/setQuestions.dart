import 'package:question_and_answer_app/events/questionsEvent.dart';
import 'package:question_and_answer_app/model/questions.dart';


class SetQuestions extends QuestionsEvent {
  List<Questions> foodList;

  SetQuestions(List<Questions> foods) {
    foodList = foods;
  }
}
