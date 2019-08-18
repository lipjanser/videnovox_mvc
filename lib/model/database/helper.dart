import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _database;

  /*
   * Projeto de disciplina - Faculdade Ibratec
   * Aluno: Felipe Janser
   * Matrícula: 2016206772
   */

  DBHelper._createInstance();

  factory DBHelper() {
    if (_dbHelper == null) return _dbHelper = DBHelper._createInstance();
    return _dbHelper;
  }

  Future<Database> get database async {
    if(_database == null){
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    var db = await openDatabase(
      join(await getDatabasesPath(), 'movie_database.db'),
      version: 1,
      onCreate: _createDatabase,
    );

    return db;
  }

  _createDatabase(Database db, int newVersion) async {
    await db.execute('CREATE TABLE movies(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, year TEXT, imdbid TEXT, type TEXT, poster TEXT)');
  }
}