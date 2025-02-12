import 'dart:convert';

import 'package:flutter_rick_and_morty/bloc_character/rick_and_morty_bloc.dart';
import 'package:flutter_rick_and_morty/helpers/api_requester.dart';
import 'package:flutter_rick_and_morty/models/character_model.dart';
import 'package:flutter_rick_and_morty/models/episode_model.dart';
import 'package:flutter_rick_and_morty/models/location_model.dart';

class Repository {
  ApiRequester apiRequester = ApiRequester();

  Future<List<Result>> getAllCharacter(int page) async {
    final response =
        await apiRequester.getCharacter('/character', {'page': '$page'});
    final data = jsonDecode(response.body);

    if (data == null || data['results'] == null) {
      throw Exception("Ошибка: API вернул пустые данные");
    }

    return List<Result>.from(
        data['results'].map((elem) => Result.fromJson(elem)));
  }

  Future<List<Result>> getCharacterByName(String name) async {
    final response =
        await apiRequester.getCharacter('/character', {'name': name});
    final data = jsonDecode(response.body);

    if (data == null || data['results'] == null) {
      throw Exception("Ошибка: API вернул пустые данные");
    }

    return List<Result>.from(
        data['results'].map((elem) => Result.fromJson(elem)));
  }

  Future<List<Results>> getEpisodes(List<String> episodeUrls) async {
    List<Results> episodes = [];

    for (String url in episodeUrls) {
      Uri uri = Uri.parse(url);
      final response = await apiRequester.getEpisode(uri.path, {});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        episodes.add(Results.fromJson(data));
      } else {
        throw Exception("Ошибка загрузки эпизода: ${response.statusCode}");
      }
    }

    return episodes;
  }

  Future<List<Result>> getCharactersInEpisode(List<String> url) async {
    List<Result> charactersInEpisode = [];

    for (var element in url) {
      Uri uri = Uri.parse(element);

      final response = await apiRequester.getCharacterInEpisode(uri.path, {});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        charactersInEpisode.add(Result.fromJson(data));
      }else{
        throw Exception('Ошибка загрузки Резидентов локации');
      }
    }
    return charactersInEpisode;
  }

  Future<Map<String, List<Results>>> getAllEpisodes() async {
    String? nextPage = '1';
    Map<String, List<Results>> groupedEpisodes = {};

    while (nextPage != null) {
      final response =
          await apiRequester.getEpisodePage('/episode', {'page': nextPage});
      final data = jsonDecode(response.body);

      if (data == null || data['results'] == null) {
        throw Exception("Ошибка: API вернул пустые данные");
      }

      for (var elem in data['results']) {
        Results episode = Results.fromJson(elem);
        final String season = episode.episode!.substring(0, 3);

        if (!groupedEpisodes.containsKey(season)) {
          groupedEpisodes[season] = [];
        }

        groupedEpisodes[season]!.add(episode);
      }

      nextPage = data['info']['next']
          ?.replaceFirst('https://rickandmortyapi.com/api/episode?page=', '');
    }

    return groupedEpisodes;
  }

  Future<List<ResultLocation>?> getAllLocation(int page) async {
    final response =
        await apiRequester.getLocation('/location', {'page': "$page"});
    final data = jsonDecode(response.body);

    if (data == null || data['results'] == null) {
      return null;
    }

    return List<ResultLocation>.from(
        data['results'].map((elem) => ResultLocation.fromJson(elem)));
  }

  Future<List<Result>> getResidentLocation(List<String> url) async {
    List<Result> residents = [];

    for (var element in url) {
      Uri uri = Uri.parse(element);

      final response = await apiRequester.getResindentLocation(uri.path, {});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        residents.add(Result.fromJson(data));
      }else{
        throw Exception('Ошибка загрузки Резидентов локации');
      }
    }
    return residents;
  }
}
