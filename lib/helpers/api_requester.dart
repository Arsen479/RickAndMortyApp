import 'package:flutter_rick_and_morty/bloc_character/bloc_character_episode/character_episode_bloc.dart';
import 'package:http/http.dart' as http;

class ApiRequester {
  static String url = 'rickandmortyapi.com';

  getCharacter(String path, Map<String, dynamic> quaryParameters) async{
    Uri uri = Uri.https(url, '/api' + path, quaryParameters);
    return await http.get(uri);
  }

  getLocation(String path, Map<String, dynamic> quaryParameters) async{
    Uri uri = Uri.https(url, '/api' + path, quaryParameters);
    return await http.get(uri);
  }
  
  getCharacterInEpisode(String path, Map<String, dynamic> quaryParameters) async{
    Uri uri = Uri.https(url, path, quaryParameters);
    return await http.get(uri);
  }

  getResindentLocation(String path, Map<String, dynamic> quaryParameters) async{
    Uri uri = Uri.https(url, path, quaryParameters);
    return await http.get(uri);
  }

  getEpisode(String path, Map<String, dynamic> quaryParameters) async{
    Uri uri = Uri.https(url, path, quaryParameters);
    return await http.get(uri);
  }

  getEpisodePage(String path, Map<String, dynamic> quaryParameters) async{
    Uri uri = Uri.https(url,'/api'+ path, quaryParameters);
    return await http.get(uri);
  }
}