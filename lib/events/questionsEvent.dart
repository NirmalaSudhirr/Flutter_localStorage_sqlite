/*import 'package:question_and_answer_app/model/questions.dart';

enum EventType { add, delete }

class QuestionsEvent {
  Questions food;
  int foodIndex;
  EventType eventType;

  QuestionsEvent.add(Questions food) {
    this.eventType = EventType.add;
    this.food = food;
  }

  QuestionsEvent.delete(int index) {
    this.eventType = EventType.delete;
    this.foodIndex = index;
  }
}
*/


abstract class QuestionsEvent{}