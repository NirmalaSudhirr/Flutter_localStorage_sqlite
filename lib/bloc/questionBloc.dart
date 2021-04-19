
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_and_answer_app/events/addQuestion.dart';
import 'package:question_and_answer_app/events/deleteQuestion.dart';
import 'package:question_and_answer_app/events/questionsEvent.dart';
import 'package:question_and_answer_app/events/setQuestions.dart';
import 'package:question_and_answer_app/events/updateQuestion.dart';
import 'package:question_and_answer_app/model/questions.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, List<Questions>> {
  @override
  List<Questions> get initialState => <Questions>[];

  @override
  Stream<List<Questions>> mapEventToState(QuestionsEvent event) async* {
    if (event is SetQuestions) {
      yield event.foodList;
    } else if (event is AddQuestion) {
      List<Questions> newState = List.from(state);
      if (event.newQuestion != null) {
        newState.add(event.newQuestion);
      }
      yield newState;
    } else if (event is DeleteQuestion) {
      List<Questions> newState = List.from(state);
      newState.removeAt(event.questionsIndex);
      yield newState;
    } else if (event is UpdateQuestion) {
      List<Questions> newState = List.from(state);
      newState[event.questionIndex] = event.newQuestion;
      yield newState;
    }
  }
}