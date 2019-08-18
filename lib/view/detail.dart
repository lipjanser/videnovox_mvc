import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:videnovox_mvc/controller/controller.dart';
import 'package:videnovox_mvc/model/apimovies/itemdetail.dart';
import 'package:videnovox_mvc/model/database/movie.dart';

class DetailPage extends StatefulWidget {
  final ItemDetail item;

  const DetailPage({this.item});

  @override
  _DetailPageState createState() => _DetailPageState(item);
}

class _DetailPageState extends StateMVC<DetailPage> {
  _DetailPageState(this.item) : super(Controller());
  final ItemDetail item;

  /*
   * Projeto de disciplina - Faculdade Ibratec
   * Aluno: Felipe Janser
   * Matrícula: 2016206772
   */

  @override
  Widget build(BuildContext context) {
    print("${this.item.toString()}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Details"),
      ),
      body: Column(
          children: <Widget>[
            Container(
              child: FutureBuilder(
                future: Controller.retrieveDetailApi("${item.imdbID}"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column (
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints.expand(height: 200),
                            alignment: Alignment.center,
                            child: Image.network("${snapshot.data["Poster"]}"),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Title:")),
                              Text("${snapshot.data["Title"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Year:")),
                              Text("${snapshot.data["Year"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Director:")),
                              Text("${snapshot.data["Director"]}"),
                            ],
                          ),
                          Text("Actors: ${snapshot.data["Actors"]}"),
                          Text("Plot: ${snapshot.data["Plot"]}"),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("IMDB Rating:")),
                              Text("${snapshot.data["imdbRating"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("IMDB Votes:")),
                              Text("${snapshot.data["imdbVotes"]}"),
                            ],
                          ),
                          FloatingActionButton(
                              onPressed: (){
                                Controller.insertFavorite(movie: Movie(title: "${snapshot.data["Title"]}", year:"${snapshot.data["Year"]}", imdbid: "${snapshot.data["imdbID"]}",
                                                                       type: "${snapshot.data["Type"]}", poster: "${snapshot.data["Poster"]}"));
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("New Favorite Added"),
                                  ),
                                );
                              },
                              child: Icon(Icons.star),
                          ),
                        ]
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
      ),
    );
  }
}