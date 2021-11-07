import 'package:my_structure/data/network/dio_client.dart';
import 'package:my_structure/data/network/rest_client.dart';


class HomeApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  HomeApi(this._dioClient, this._restClient);


}
