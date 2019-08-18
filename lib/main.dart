import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:videnovox_mvc/controller/controller.dart';
import 'package:videnovox_mvc/view/detail.dart';
import 'package:videnovox_mvc/view/list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  /*
   * Projeto de disciplina - Faculdade Ibratec
   * Aluno: Felipe Janser
   * Matrícula: 2016206772
   */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends StateMVC<MyHomePage> {
  _MyHomePageState() : super(Controller());

  TextEditingController _textEditingController = TextEditingController(text: "");
  Future<dynamic> items;

  void _retrieveData() {
    setState(() {
      items = Controller.retrieveDataApi("${_textEditingController.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ViDeNovo X"),
        ),
        body: _buildScreen(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.movie),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListPage(),
              ),
            );
          },
        )
    );
  }

  Widget _buildScreen() {
    return Column(
      children: <Widget>[
        _buildSearchBar(),
        _buildMoviesList(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              labelText: "Search",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4),),
              ),
            ),
          ),
        ),
        RaisedButton(
          onPressed: () {
            if(_textEditingController.text.isEmpty) {
              print("Não pesquisou.");
            } else {
              _retrieveData();
            }
          },
          child: const Text(
              'Search',
              style: TextStyle(fontSize: 12)
          ),
        ),
      ],
    );
  }

  Widget _buildMoviesList() {
    return Expanded(
        child: FutureBuilder(
          future: items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data["Response"] == "True") {
                return ListView.builder(
                  itemCount: snapshot.data["Search"]?.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage("${snapshot.data["Search"][index]["Poster"]}"),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  item: Controller.retrieveDetailApiFromJSON(snapshot.data["Search"][index]),
                                ),
                              ),
                            );
                          },
                          title: Text("${snapshot.data["Search"][index]["Title"]}"),
                          subtitle: Text("${snapshot.data["Search"][index]["Type"]}"),
                          trailing: Text("${snapshot.data["Search"][index]["Year"]}"),
                        ),
                        Divider(
                          height: 2,
                        ),
                      ],
                    );
                  },
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
  }
}