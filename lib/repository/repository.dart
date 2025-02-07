import 'dart:convert';

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


  Future<Map<String, List<Results>>> getAllEpisodes() async {
  String? nextPage = '1';
  //Map<String, List<Results>> allEpisodes = {};
  Map<String, List<Results>> groupedEpisodes = {};

  while (nextPage != null) {
    final response = await apiRequester.getEpisodePage('/episode', {'page': nextPage});
    final data = jsonDecode(response.body);

    if (data == null || data['results'] == null) {
      throw Exception("Ошибка: API вернул пустые данные");
    }

    for (var elem in data['results']) {
      Results episode = Results.fromJson(elem);
      final String season = episode.episode!.substring(0, 3); // Пример: "S01"

      if (!groupedEpisodes.containsKey(season)) {
        groupedEpisodes[season] = [];
      }

      groupedEpisodes[season]!.add(episode);
    }

    nextPage = data['info']['next']?.replaceFirst('https://rickandmortyapi.com/api/episode?page=', '');
  }

  return groupedEpisodes;
}


  // Future<Map<String, List<Results>>> getAllEpisodes() async {
  //   final response = await apiRequester.getEpisode('/api/episode', {});
  //   final data = jsonDecode(response.body);

  //   if (data == null || data['results'] == null) {
  //     throw Exception("Ошибка: API вернул пустые данные");
  //   }

  //   //Преобразование Json в список объектов Results
  //   List<Results> episodes = List<Results>.from(
  //     data['results'].map(
  //       (elem) => Results.fromJson(elem),
  //     ),
  //   );

  //   // Группируем по сезонам
  //   Map<String, List<Results>> groupedEpisodes = {};

  //   for (var episode in episodes) {
  //     String season = episode.episode!.substring(0, 3); // "S01E01" → "S01"

  //     if (!groupedEpisodes.containsKey(season)) {
  //       groupedEpisodes[season] = [];
  //     }

  //     groupedEpisodes[season]!.add(episode);
  //   }

  //   return groupedEpisodes;
  // }

  Future<List<ResultLocation>> getAllLocation() async {
    final response = await apiRequester.getLocation('/location', {});
    final data = jsonDecode(response.body);

    if (data == null || data['results'] == null) {
      throw Exception("Ошибка: API вернул пустые данные");
    }

    return List<ResultLocation>.from(data['results'].map((elem) =>
        ResultLocation.fromJson(elem))); //ResultLocation.fromJson(data);
  }
}
