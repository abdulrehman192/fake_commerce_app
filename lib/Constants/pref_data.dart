import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String introAvailable = "isIntroAvailable";
  static String userId = "userId";

  static Future<SharedPreferences> getPrefInstance() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }


  static setIntroAvailable(bool avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setBool(introAvailable, avail);
  }

  static logout() async {
    SharedPreferences preferences = await getPrefInstance();
    await preferences.remove(introAvailable);
    await preferences.remove(userId);
  }

  static Future<bool> isIntroAvailable() async {
    SharedPreferences preferences = await getPrefInstance();
    bool isIntroAvailable = preferences.getBool(introAvailable) ?? true;
    return isIntroAvailable;
  }

  static setUserId(String id) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(userId, id);
  }

  static Future<String> getUserId() async {
    SharedPreferences preferences = await getPrefInstance();
    String id =
        preferences.getString(userId) ?? "";
    return id;
  }



}
