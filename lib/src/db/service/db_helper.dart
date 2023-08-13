import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/db_model.dart';

class DatabaseHelper {
  static const dbName = 'quiz_db.db';
  static const dbVersion = 1;
  static const dbTable = 'quiz_table';
  static const dbQuestionId = 'questionId'; // COLMID
  static const optionValueColumnName = 'optionValue'; // Use a different column name

  // Constructor
  static final DatabaseHelper instance = DatabaseHelper();

  // Database initialization
  static Database? _db;
  Future<Database?> get database async {
    _db ??= await _initDatabase();
    return _db;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $dbTable (
        $dbQuestionId $idType,
        $optionValueColumnName $intType  -- Use the new column name here
      )
    ''');
  }

  Future<void> insertOrUpdateQuestionOption(
      QuestionOption questionOption) async {
    final db = await instance.database;
    String questionId = questionOption.questionID;
    int optionValue = questionOption.optionValue; // Change variable name to optionValue

    List<Map<String, dynamic>> existingRows = await db!.query(
      dbTable,
      where: '$dbQuestionId = ?',
      whereArgs: [questionId],
    );

    if (existingRows.isEmpty) {
      await db.insert(dbTable, questionOption.toMap());
      quizDebugPrint("Added successfully");
    } else {
      await db.update(
        dbTable,
        questionOption.toMap(),
        where: '$dbQuestionId = ?',
        whereArgs: [questionId],
      );
      quizDebugPrint("Updated successfully");
    }
  }
}
