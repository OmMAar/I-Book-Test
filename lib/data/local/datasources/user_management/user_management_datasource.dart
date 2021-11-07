import 'package:my_structure/data/local/constants/db_constants.dart';
import 'package:sembast/sembast.dart';

class UserManagementDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _userStore = intMapStoreFactory.store(DBConstants.LOGIN_INFO);


  // database instance
  final Database _db;

  // Constructor
  UserManagementDataSource(this._db);



}
