import 'package:my_structure/data/local/datasources/home/home_datasource.dart';
import 'package:my_structure/data/network/apis/home/home_api.dart';
import 'package:my_structure/data/sharedpref/shared_preference_helper.dart';


class HomeRepository {
  // data source object
  final HomeDataSource _homeDataSource;

  // api objects
  final HomeApi _homeApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  HomeRepository(this._homeApi, this._sharedPrefsHelper, this._homeDataSource);

  /// home EndPoints: ---------------------------------------------------------------------


}
