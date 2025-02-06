import 'dart:convert';

import 'package:flutter_rick_and_morty/helpers/api_requester.dart';
import 'package:flutter_rick_and_morty/models/character_model.dart';
import 'package:flutter_rick_and_morty/models/episode_model.dart';

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
}
