import 'dart:async';
import 'package:my_structure/data/local/datasources/app/app_datasource.dart';
import 'package:my_structure/data/network/apis/app/app_api.dart';
import 'package:my_structure/data/sharedpref/shared_preference_helper.dart';

class Repository {
  // data source object
  final AppDataSource _dashboardDataSource;

  // api objects
  final AppApi _appApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._appApi, this._sharedPrefsHelper, this._dashboardDataSource);


  // Theme: -----------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}