import 'package:videnovox_mvc/model/apimovies/item.dart';
import 'package:videnovox_mvc/model/apimovies/itemdetail.dart';
import 'package:videnovox_mvc/model/database/movie.dart';
import 'package:videnovox_mvc/model/database/movieDAO.dart';

class Model {

  static Future<dynamic> retrieveDataApi(String searchtext) async => Item.retrieveDataApi(searchtext);

  static ItemDetail retrieveDetailApiFromJSON(Map<String, dynamic> movieInfo) => ItemDetail.fromJson(movieInfo);

  static ItemDetail retrieveDetailApiFromDBJSON(Movie movieInfo) => ItemDetail.fromDBJson(movieInfo);

  static Future<dynamic> retrieveDetailApi(String idmovie) => ItemDetail.retrieveData(idmovie);

  static Future<void> insertFavorite(Movie movie) async =>  MovieDAO().insert(movie: Movie(title: movie.title, year :movie.year, imdbid: movie.imdbid, type: movie.type, poster: movie.poster));

  static Future<List<Movie>> selectFavoriteMovies() async => MovieDAO().get();

  static Future<void> updateFavorite(Movie movie) async => MovieDAO().update(movie);

  static Future<void> deleteFavorite(int id) async => MovieDAO().delete(id);

  static Future<void> deleteFavoriteByIMDBID(String imdbid) async => MovieDAO().deleteByIMDBID(imdbid);

}