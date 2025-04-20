import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/model/genre_model.dart';
import 'package:movie_app/model/movie/movie_details_model.dart';
import 'package:movie_app/model/movie/movie_model.dart';
import 'package:movie_app/model/reviews_model.dart';
import 'package:movie_app/model/trailers_model.dart';
import 'package:movie_app/model/tv/tv_details_model.dart';
import 'package:movie_app/model/tv/tv_model.dart';

class HttpRequest {
  static final String? apiKey = dotenv.env['API_KEY'];
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static final Dio dio = Dio();
  static var getGenreUrl = '$baseUrl/genre';
  static var getDiscoverUrl = '$baseUrl/discover';
  static var getMoviesUrl = '$baseUrl/movie';
  static var getTVUrl = '$baseUrl/tv';

  // get genres
  static Future<GenreModel> getGenres(String shows) async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};

    try {
      Response response = await dio.get(
        '$getGenreUrl/$shows/list',
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        return GenreModel.fromJson(response.data);
      } else {
        return GenreModel.withError("Error: ${response.statusCode}");
      }
    } catch (e) {
      return GenreModel.withError("Error: $e");
    }
  }

  // get reviews
  static Future<ReviewsModel> getReviews(String shows, int id) async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};

    try {
      Response response = await dio.get(
        "$baseUrl/$shows/$id/reviews",
        queryParameters: params,
      );
      print(response.data);
      if (response.statusCode == 200) {
        return ReviewsModel.fromJson(response.data);
      } else {
        return ReviewsModel.withError("Error: ${response.statusCode}");
      }
    } catch (e) {
      return ReviewsModel.withError("Error: $e");
    }
  }

  // get trailers
  static Future<TrailersModel> getTrailers(String shows, int id) async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};

    try {
      Response response = await dio.get(
        "$baseUrl/$shows/$id/videos",
        queryParameters: params,
      );
      print(response.data);
      print("Trailers URL: $getMoviesUrl/$id/videos");
      if (response.statusCode == 200) {
        return TrailersModel.fromJson(response.data);
      } else {
        return TrailersModel.withError("Error: ${response.statusCode}");
      }
    } catch (e) {
      return TrailersModel.withError("Error: $e");
    }
  }

  // get similar movie
  static Future<MovieModel> getSimilarMovie(int id) async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};

    try {
      Response response = await dio.get(
        "$getMoviesUrl/$id/similar",
        queryParameters: params,
      );
      print(response);
      if (response.statusCode == 200) {
        return MovieModel.fromJson(response.data);
      } else {
        return MovieModel.withError("Error: ${response.statusCode}");
      }
    } catch (e) {
      return MovieModel.withError("Error: $e");
    }
  }

  // get similar tv shows
  static Future<TVModel> getSimilarTVShows(int id) async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};

    try {
      Response response = await dio.get(
        "$getTVUrl/$id/similar",
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        return TVModel.fromJson(response.data);
      } else {
        return TVModel.withError("Error: ${response.statusCode}");
      }
    } catch (e) {
      return TVModel.withError("Error: $e");
    }
  }

  // get discover movie
  static Future<MovieModel> getDiscoverMovies(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": 1,
      "with_genres": id,
    };

    try {
      Response response = await dio.get(
        "$getDiscoverUrl/movie",
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        return MovieModel.fromJson(response.data);
      } else {
        return MovieModel.withError("Error: ${response.statusCode}");
      }
    } catch (e) {
      return MovieModel.withError("Error: $e");
    }
  }

  // get discover tv show
  static Future<TVModel> getDiscoverTVShows(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": 1,
      "with_genres": id,
    };

    try {
      Response response = await dio.get(
        "$getDiscoverUrl/tv",
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        return TVModel.fromJson(response.data);
      } else {
        return TVModel.withError("Error: ${response.statusCode}");
      }
    } catch (e) {
      return TVModel.withError("Error: $e");
    }
  }

  // get movie details
  static Future<MovieDetailsModel> getMoviesDetails(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};

    try {
      Response response = await dio.get(
        "$getMoviesUrl/$id",
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        return MovieDetailsModel.fromJson(response.data);
      } else {
        return MovieDetailsModel.withError("Error: ${response.statusCode}");
      }
    } catch (e) {
      return MovieDetailsModel.withError("Error: $e");
    }
  }

  // get tv shows details
  static Future<TvDetailsModel> getTVShowsDetails(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};

    try {
      Response response = await dio.get(
        "$getTVUrl/$id",
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        return TvDetailsModel.fromJson(response.data);
      } else {
        return TvDetailsModel.withError("Error: ${response.statusCode}");
      }
    } catch (e) {
      return TvDetailsModel.withError("Error: $e");
    }
  }

  // get Movies with different requests
  // such as "now_playing", "popular", "top_rated", "upcoming"
  static Future<MovieModel> getMovies(String request) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    print("Starting API request for movies...");
    print("API Key: $apiKey");
    if (apiKey == null) {
      print("API Key is null. Check your .env file or dotenv configuration.");
    }
    print("Request URL: $getMoviesUrl/$request");
    print("Params: $params");

    try {
      Response response = await dio.get(
        "$getMoviesUrl/$request",
        queryParameters: params,
      );
      print("Response: ${response.data}");
      print("Status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return MovieModel.fromJson(response.data);
      } else {
        return MovieModel.withError("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
      return MovieModel.withError("Error: $e");
    }
  }

  // get tv shows with different requests
  // such as "airing_today", "on_the_air", "top_rated", "popular"
  static Future<TVModel> getTVShows(String request) async {
    var params = {"api_key": apiKey, "language": "en-US"};

    try {
      Response response = await dio.get(
        "$getTVUrl/$request",
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        return TVModel.fromJson(response.data);
      } else {
        return TVModel.withError("Error: ${response.statusCode}");
      }
    } catch (e) {
      return TVModel.withError("Error: $e");
    }
  }
}
