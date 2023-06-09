
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences{
  static const String GCP_API_KEY = 'GCP_API_KEY';

  static Future<String> getGcpApiKey() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(GCP_API_KEY) ?? '';
  }

  static Future<void> setGcpApiKey(String value) async{
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(GCP_API_KEY, value);
  }

}
