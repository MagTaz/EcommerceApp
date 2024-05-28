import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguage {
  static Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("done");
    return prefs.getString('languageCode') ?? 'en';
  }

  static void setLanguage(String languageCode) async {
    print("done set");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('languageCode', languageCode);
  }
}
