import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_and_answer_app/bloc/questionBloc.dart';
import 'package:question_and_answer_app/db/questionAndAnswerDatabase.dart';
import 'package:question_and_answer_app/events/addQuestion.dart';
import 'package:question_and_answer_app/events/updateQuestion.dart';
import 'package:question_and_answer_app/model/questions.dart';

class QuestionForm extends StatefulWidget {
  final Questions questions;
  final int questionIndex;

  QuestionForm({this.questions, this.questionIndex});

  @override
  State<StatefulWidget> createState() {
    return QuestionFormState();
  }
}

class QuestionFormState extends State<QuestionForm> {
  String _question;
  String _answer;
  String _tags;
  String _views;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildQuestions() {
    return TextFormField(
      initialValue: _question,
      decoration: InputDecoration(labelText: 'Question'),
      maxLength: 150,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Question is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _question = value;
      },
    );
  }

  Widget _buildAnswers() {
    return TextFormField(
      initialValue: _answer,
      decoration: InputDecoration(labelText: 'Answer'),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Answer is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _answer = value;
      },
    );
  }
  Widget _buildTags() {
    return TextFormField(
      initialValue: _tags,
      decoration: InputDecoration(labelText: 'Tag'),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Tag is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _tags = value;
      },
    );
  }

  Widget _buildViews() {
    return TextFormField(
      initialValue: _views,
      decoration: InputDecoration(labelText: 'Views'),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Views is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _views = value;
      },
    );
  }





  @override
  void initState() {
    super.initState();
    if (widget.questions != null) {
      _question = widget.questions.question;
      _answer = widget.questions.answer;
      _tags= widget.questions.tag;
      _views = widget.questions.views;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Questions Form")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildQuestions(),
              _buildAnswers(),
              SizedBox(height: 16),
              _buildTags(),
              SizedBox(height: 20),
              _buildViews(),
              widget.questions == null
                  ? ElevatedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();

                  Questions questions = Questions(
                    question: _question,
                    answer: _answer,
                    tag: _tags,
                    views: _views,
                  );

                  DatabaseProvider.db.insert(questions).then(
                        (storedQuestion) =>
                        BlocProvider.of<QuestionsBloc>(context).add(
                          AddQuestion(storedQuestion),
                        ),
                  );

                  Navigator.pop(context);
                },
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  ElevatedButton(
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        print("form");
                        return;
                      }

                      _formKey.currentState.save();

                      Questions question = Questions(
                        question: _question,
                        answer: _answer,
                        tag: _tags,
                        views: _views
                      );

                      DatabaseProvider.db.update(widget.questions).then(
                            (storedQuestion) =>
                            BlocProvider.of<QuestionsBloc>(context).add(
                              UpdateQuestion(widget.questionIndex, question),
                            ),
                      );

                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
