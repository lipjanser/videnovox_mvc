import 'helper.dart';
import 'movie.dart';
import 'package:sqflite/sqflite.dart';

class MovieDAO {

  /*
   * Projeto de disciplina - Faculdade Ibratec
   * Aluno: Felipe Janser
   * Matrícula: 2016206772
   */

  Future<List<Movie>> get() async {
    Database db = await DBHelper().database;

    final List<Map<String, dynamic>> maps = await db.query('movies');
    var people = List.generate(maps.length, (i) {
      return Movie.fromJson(maps[i]);
    });
    return people;
  }

  Future<void> insert({Movie movie}) async {
    Database db = await DBHelper().database;

    await db.insert('movies', movie.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Movie movie) async {
    Database db = await DBHelper().database;

    await db.update('movies', movie.toJson(),
        where: "id = ?", whereArgs: [movie.id]);
  }

  Future<void> delete(int id) async {
    Database db = await DBHelper().database;

    await db.delete('movies', where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteByIMDBID(String imdbid) async {
    Database db = await DBHelper().database;

    await db.delete('movies', where: "imdbid = ?", whereArgs: [imdbid]);
  }
}