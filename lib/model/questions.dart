import 'package:question_and_answer_app/db/questionAndAnswerDatabase.dart';

class Questions {
  int id;
  String question;
  String answer;
  String tag;
  String views;

  Questions({this.id, this.question, this.answer, this.views,this.tag});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_QUESTION: question,
      DatabaseProvider.COLUMN_ANSWER: answer,
      DatabaseProvider.COLUMN_TAGS: tag,
      DatabaseProvider.COLUMN_VIEWS : views
    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  Questions.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    question = map[DatabaseProvider.COLUMN_QUESTION];
    answer = map[DatabaseProvider.COLUMN_ANSWER];
    tag = map[DatabaseProvider.COLUMN_TAGS];
    views = map[DatabaseProvider.COLUMN_VIEWS];

  }
}
