import 'package:flutter_rick_and_morty/helpers/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveProvider {
  Future<void> saveUserSession(String user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefKeys.user, user);
  }

  Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? user = await prefs.getString(PrefKeys.user);
    return user;
  }
}
