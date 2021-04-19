
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_and_answer_app/bloc/questionBloc.dart';
import 'package:question_and_answer_app/db/questionAndAnswerDatabase.dart';
import 'package:question_and_answer_app/events/deleteQuestion.dart';
import 'package:question_and_answer_app/events/setQuestions.dart';
import 'package:question_and_answer_app/model/questions.dart';
import 'package:question_and_answer_app/questionForm.dart';


class QuestionsList extends StatefulWidget {
  const QuestionsList({Key key}) : super(key: key);

  @override
  _QuestionsListState createState() => _QuestionsListState();
}

class _QuestionsListState extends State<QuestionsList> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getQuestions().then(
          (questionsList) {
        BlocProvider.of<QuestionsBloc>(context).add(SetQuestions(questionsList));
      },
    );
  }

  showFoodDialog(BuildContext context, Questions questions, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(questions.question),
        content: Text("ID ${questions.id}"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionForm(questions: questions, questionIndex: index),
              ),
            ),
            child: Text("Update"),
          ),
          TextButton(
            onPressed: () => DatabaseProvider.db.delete(questions.id).then((_) {
              BlocProvider.of<QuestionsBloc>(context).add(
                DeleteQuestion(index),
              );
              Navigator.pop(context);
            }),
            child: Text("Delete"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building entire Question and Answers list scaffold");
    return Scaffold(
      appBar: AppBar(
        title: Text("Question and Answer Platform"),
        /*leading: Image.asset(
          'assets/images/logo.png',
        ),*/
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey,
        child: BlocConsumer<QuestionsBloc, List<Questions>>(
          builder: (context, questionsList) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                print("questionsList: $questionsList");

                Questions questions = questionsList[index];
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text("${questions.question}\n", style: TextStyle(fontSize: 26)),
                    subtitle: Text(
                      "Answer: ${questions.answer}\n\n Tag: ${questions.tag}\n\n Views: ${questions.views}",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () => showFoodDialog(context, questions, index),
                  ),
                );
              },
              itemCount: questionsList.length,
            );
          },
          listener: (BuildContext context, questionList) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => QuestionForm()),
        ),
      ),
    );
  }
}
