class Movie {
  /*
   * Projeto de disciplina - Faculdade Ibratec
   * Aluno: Felipe Janser
   * Matrícula: 2016206772
   */

  int id;
  String title;
  String year;
  String imdbid;
  String type;
  String poster;
  Movie({this.id, this.title, this.year, this.imdbid, this.type, this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"],
      title: json["title"],
      year: json["year"],
      imdbid: json["imdbid"],
      type: json["type"],
      poster: json["poster"],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'year': year, 'imdbid': imdbid, 'type': type, 'poster': poster};
  }
}