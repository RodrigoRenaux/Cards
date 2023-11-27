import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  // Obtain shared preferences.
  late final SharedPreferences prefs;

  Future<void> initializeSharedPreferences() async =>
      prefs = await SharedPreferences.getInstance();

  void updateCache(String key, dynamic value) =>
      prefs.setStringList('cards', value);
}
