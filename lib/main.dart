import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_and_answer_app/bloc/questionBloc.dart';
import 'package:question_and_answer_app/questionsList.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuestionsBloc>(
      create: (context) => QuestionsBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: QuestionsList(),
      ),
    );
  }
}
