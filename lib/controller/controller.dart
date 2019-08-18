import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:videnovox_mvc/model/model.dart';
import 'package:videnovox_mvc/model/apimovies/itemdetail.dart';
import 'package:videnovox_mvc/model/database/movie.dart';

class Controller extends ControllerMVC {

  static Future<dynamic> retrieveDataApi(String searchtext) => Model.retrieveDataApi(searchtext);

  static ItemDetail retrieveDetailApiFromJSON(Map<String, dynamic> movieInfo) => Model.retrieveDetailApiFromJSON(movieInfo);

  static ItemDetail retrieveDetailApiFromDBJSON(Movie movieInfo) => Model.retrieveDetailApiFromDBJSON(movieInfo);

  static Future<dynamic> retrieveDetailApi(String idmovie) => Model.retrieveDetailApi(idmovie);

  static Future<void> insertFavorite({Movie movie}) async =>  Model.insertFavorite(movie);

  static Future<List<Movie>> selectFavoriteMovies() async => Model.selectFavoriteMovies();

  static Future<void> updateFavorite(Movie movie) async => Model.updateFavorite(movie);

  static Future<void> deleteFavorite(int id) async => Model.deleteFavorite(id);

  static Future<void> deleteFavoriteByIMDBID(String imdbid) async => Model.deleteFavoriteByIMDBID(imdbid);

}