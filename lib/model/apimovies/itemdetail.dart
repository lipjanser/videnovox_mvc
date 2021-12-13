import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:videnovox_mvc/model/database/movie.dart';

class ItemDetail {
  /*
   * Projeto de disciplina - Faculdade Ibratec
   * Aluno: Felipe Janser
   * Matrícula: 2016206772
   */

  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String poster;
  final String imdbRating;
  final String imdbID;

  ItemDetail(
      {this.title,
        this.year,
        this.rated,
        this.released,
        this.runtime,
        this.genre,
        this.director,
        this.writer,
        this.actors,
        this.plot,
        this.poster,
        this.imdbRating,
        this.imdbID});

  factory ItemDetail.fromJson(Map<String, dynamic> json) {
    return ItemDetail(
        title: json["Title"],
        year: json["Year"],
        rated: "",
        released: "",
        runtime: "",
        genre: "",
        director: "",
        writer: "",
        actors: "",
        plot: "",
        poster: json["Poster"],
        imdbRating: "",
        imdbID: json["imdbID"]);
  }

  factory ItemDetail.fromDBJson(Movie movie) {
    return ItemDetail(
        title: movie.title,
        year: movie.year,
        rated: "",
        released: "",
        runtime: "",
        genre: "",
        director: "",
        writer: "",
        actors: "",
        plot: "",
        poster: movie.poster,
        imdbRating: "",
        imdbID: movie.imdbid);
  }

  static Future<dynamic> retrieveData(String idmovie) async {
    final response = await http.get("http://www.omdbapi.com/?apikey=SUA_CHAVE_AQUI&i=$idmovie");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erro ao tentar recuperar dados.");
    }
  }
}
