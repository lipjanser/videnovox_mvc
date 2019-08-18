import 'dart:convert';

import 'package:http/http.dart' as http;

class Item {
  /*
   * Projeto de disciplina - Faculdade Ibratec
   * Aluno: Felipe Janser
   * Matrícula: 2016206772
   */

  final String title;
  final String year;
  final String poster;
  final String imdbID;
  final String type;

  Item(
      {this.title,
        this.year,
        this.poster,
        this.imdbID,
        this.type});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        title: json["Title"],
        year: json["Year"],
        poster: json["Poster"],
        imdbID: json["imdbID"],
        type: json["Type"]);
  }

  static Future<dynamic> retrieveDataApi(String searchtext) async {
    final response = await http.get("http://www.omdbapi.com/?apikey=b446ef61&s=$searchtext");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erro ao tentar recuperar dados.");
    }
  }
}