import 'package:my_structure/data/local/datasources/user_management/user_management_datasource.dart';
import 'package:my_structure/data/network/apis/user_management/user_management_api.dart';
import 'package:my_structure/data/sharedpref/shared_preference_helper.dart';


class UserManagementRepository {
  // data source object
  final UserManagementDataSource _managementDataSource;

  // api objects
  final UserManagementApi _managementApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  UserManagementRepository(
      this._managementApi, this._sharedPrefsHelper, this._managementDataSource);


}
