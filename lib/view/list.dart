import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:videnovox_mvc/controller/controller.dart';
import 'package:videnovox_mvc/view/favoritedetail.dart';

class ListPage extends StatefulWidget {
  final String item;

  const ListPage({this.item});

  @override
  _ListState createState() => _ListState(item);
}

class _ListState extends StateMVC<ListPage> {
  _ListState(this.item) : super(Controller());
  final String item;

  //_ListState(this.item);

  /*
   * Projeto de disciplina - Faculdade Ibratec
   * Aluno: Felipe Janser
   * Matrícula: 2016206772
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: FutureBuilder(
        future: Controller.selectFavoriteMovies(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data[index].id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    Controller.deleteFavorite(snapshot.data[index].id);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Favorite Deleted"),
                      ),
                    );
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FavoriteDetailPage(
                            item: Controller.retrieveDetailApiFromDBJSON(snapshot.data[index]),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage("${snapshot.data[index].poster}"),
                          ),
                          title: Text("${snapshot.data[index].title}"),
                          subtitle: Text("${snapshot.data[index].type}"),
                          trailing: Text("${snapshot.data[index].year}"),
                        ),
                        Divider(
                          height: 2,
                        ),
                      ],
                    )
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("No content to display =/"),
            );
          }
        },
      ),
    );
  }
}