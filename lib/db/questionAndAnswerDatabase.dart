import 'package:path/path.dart';
import 'package:question_and_answer_app/model/questions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static const String TABLE_QUESTION = "question";
  static const String COLUMN_ID = "id";
  static const String COLUMN_QUESTION = "question";
  static const String COLUMN_ANSWER = "answer";
  static const String COLUMN_TAGS = "tags";
  static const String COLUMN_VIEWS = "views";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'foodDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating food table");

        await database.execute(
          "CREATE TABLE $TABLE_QUESTION ("
              "$COLUMN_ID INTEGER PRIMARY KEY,"
              "$COLUMN_QUESTION TEXT,"
              "$COLUMN_ANSWER TEXT,"
              "$COLUMN_TAGS TEXT,"
              "$COLUMN_VIEWS INTEGER"
              ")",
        );
      },
    );
  }

  Future<List<Questions>> getQuestions() async {
    final db = await database;

    var questions = await db
        .query(TABLE_QUESTION, columns: [COLUMN_ID, COLUMN_QUESTION, COLUMN_ANSWER, COLUMN_TAGS,COLUMN_VIEWS]);

    List<Questions> questionsList = <Questions>[];

    questions.forEach((currentQuestion) {
      Questions question = Questions.fromMap(currentQuestion);

      questionsList.add(question);
    });

    return questionsList;
  }

  Future<Questions> insert(Questions questions) async {
    final db = await database;
    questions.id = await db.insert(TABLE_QUESTION, questions.toMap());
    return questions;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_QUESTION,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Questions questions) async {
    final db = await database;

    return await db.update(
      TABLE_QUESTION,
      questions.toMap(),
      where: "id = ?",
      whereArgs: [questions.id],
    );
  }
}