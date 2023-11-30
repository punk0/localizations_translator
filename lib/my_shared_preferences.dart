
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences{
  static const String GCP_API_KEY = 'GCP_API_KEY';
  static const String FILTER_LOCALES_KEY = 'FILTER_LOCALES_KEY';

  static Future<String> getGcpApiKey() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(GCP_API_KEY) ?? '';
  }

  static Future<void> setGcpApiKey(String value) async{
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(GCP_API_KEY, value);
  }

  static Future<void> setFilterLocales(bool value) async{
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool(FILTER_LOCALES_KEY, value);
  }

  static Future<bool> getFilterLocales() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(FILTER_LOCALES_KEY) ?? false;
  }

}
