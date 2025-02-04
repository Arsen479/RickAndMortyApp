import 'dart:convert';

import 'package:flutter_rick_and_morty/helpers/api_requester.dart';
import 'package:flutter_rick_and_morty/models/character_model.dart';

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

  Future<Location> getLocation(int page) async {
    final response =
        await apiRequester.getLocation('/location', {'page': '$page'});
    final data = jsonDecode(response.body);

    if (data == null || data['results'] == null) {
      throw Exception("Ошибка: API вернул пустые данные");
    }

    return Location.fromJson(data);
  }
}
