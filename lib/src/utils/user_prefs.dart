import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static final UserPrefs _instancia = new UserPrefs._internal();

  factory UserPrefs() {
    return _instancia;
  }

  UserPrefs._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET de la última página
  get lastPage {
    return _prefs.getString('lastPage') ?? '/';
  }

  set lastPage(String value) {
    _prefs.setString('lastPage', value);
  }
}
