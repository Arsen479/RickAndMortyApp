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
}