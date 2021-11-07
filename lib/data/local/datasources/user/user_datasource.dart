import 'package:my_structure/data/local/constants/db_constants.dart';
import 'package:sembast/sembast.dart';

class UserDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _momStore = intMapStoreFactory.store(DBConstants.USER_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final Database _db;

  // Constructor
  UserDataSource(this._db);


}
