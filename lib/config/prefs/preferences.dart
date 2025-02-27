import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instance = Preferences._internal();

  //Esto es el singleton
  factory Preferences() {
    return _instance;
  }
  Preferences._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isdark {
    return _prefs.getBool('isdark') ?? false;
  }

  set isdark(bool value) {
    _prefs.setBool('isdark', value);
  }
}
