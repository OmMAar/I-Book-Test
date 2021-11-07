import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_structure/data/local/datasources/app/app_datasource.dart';
import 'package:my_structure/data/local/datasources/home/home_datasource.dart';
import 'package:my_structure/data/local/datasources/user/user_datasource.dart';
import 'package:my_structure/data/local/datasources/user_management/user_management_datasource.dart';
import 'package:my_structure/data/network/apis/app/app_api.dart';
import 'package:my_structure/data/network/apis/home/home_api.dart';
import 'package:my_structure/data/network/apis/user/user_api.dart';
import 'package:my_structure/data/network/apis/user_management/user_management_api.dart';
import 'package:my_structure/data/network/dio_client.dart';
import 'package:my_structure/data/network/rest_client.dart';
import 'package:my_structure/data/repo/home_repository.dart';
import 'package:my_structure/data/repo/repository.dart';
import 'package:my_structure/data/repo/user_management_repository.dart';
import 'package:my_structure/data/repo/user_repository.dart';
import 'package:my_structure/data/sharedpref/shared_preference_helper.dart';
import 'package:my_structure/di/module/local_module.dart';
import 'package:my_structure/di/module/network_module.dart';
import 'package:my_structure/stores/error/error_store.dart';
import 'package:my_structure/stores/form/form_store.dart';
import 'package:my_structure/stores/language/language_store.dart';
import 'package:my_structure/stores/theme/theme_store.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());
  getIt.registerFactory(() => FormStore());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(
      () => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(AppApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(HomeApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(UserManagementApi(getIt<DioClient>()));
  getIt.registerSingleton(UserApi(getIt<DioClient>()));


  // data sources
  getIt.registerSingleton(AppDataSource(await getIt.getAsync<Database>()));
  getIt.registerSingleton(HomeDataSource(await getIt.getAsync<Database>()));
  getIt.registerSingleton(UserManagementDataSource(await getIt.getAsync<Database>()));
  getIt.registerSingleton(UserDataSource(await getIt.getAsync<Database>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    getIt<AppApi>(),
    getIt<SharedPreferenceHelper>(),
    getIt<AppDataSource>(),
  ));

  getIt.registerSingleton(UserManagementRepository(
    getIt<UserManagementApi>(),
    getIt<SharedPreferenceHelper>(),
    getIt<UserManagementDataSource>(),
  ));


  getIt.registerSingleton(UserRepository(
    getIt<UserApi>(),
    getIt<SharedPreferenceHelper>(),
    getIt<UserDataSource>(),
  ));

  getIt.registerSingleton(HomeRepository(
    getIt<HomeApi>(),
    getIt<SharedPreferenceHelper>(),
    getIt<HomeDataSource>(),
  ));


  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
}
