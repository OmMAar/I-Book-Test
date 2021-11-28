import 'package:faker/faker.dart';
import 'package:my_structure/data/local/datasources/home/home_datasource.dart';
import 'package:my_structure/data/network/apis/home/home_api.dart';
import 'package:my_structure/data/sharedpref/shared_preference_helper.dart';
import 'package:my_structure/models/map/mark_location_model.dart';

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

  List<AddressInfo> _getLocationAddress() {
    return [
      AddressInfo(34.28, 69.11),
      AddressInfo(41.18, 19.49),
      AddressInfo(36.42, 03.08),

      AddressInfo(42.31, 01.32),
      AddressInfo(08.50, 13.15),
      AddressInfo(17.20, 61.48),
      AddressInfo(36.30, 60.00),
      AddressInfo(40.10, 44.31),
      AddressInfo(12.32, 70.02),
      AddressInfo(48.12, 16.22),
      AddressInfo(40.29, 49.56),
      AddressInfo(25.05, 77.20),
      AddressInfo(26.10, 50.30),

      AddressInfo(13.05, 59.30),
      AddressInfo(53.52, 27.30),
      AddressInfo(50.51, 04.21),
      AddressInfo(17.18, 88.30),
      AddressInfo(06.23, 02.42),

      AddressInfo(16.20, 68.10),
      AddressInfo(43.52, 18.26),
      AddressInfo(24.45, 25.57),
      AddressInfo(15.47, 47.55),
      AddressInfo(18.27, 64.37),

      AddressInfo(42.45, 23.20),
      AddressInfo(12.15, 01.30),
      AddressInfo(03.16, 29.18),

      AddressInfo(03.50, 11.35),
      AddressInfo(45.27, 75.42),
      AddressInfo(15.02, 23.34),
      AddressInfo(19.20, 81.24),
      AddressInfo(04.23, 18.35),
      AddressInfo(12.10, 14.59),
      AddressInfo(33.24, 70.40),

      AddressInfo(04.34, 74.00),
      AddressInfo(11.40, 43.16),
      AddressInfo(04.09, 15.12),
      AddressInfo(09.55, 84.02),
      AddressInfo(06.49, 05.17),
      AddressInfo(45.50, 15.58),
      AddressInfo(23.08, 82.22),
      AddressInfo(35.10, 33.25),
      AddressInfo(50.05, 14.22),
      AddressInfo(04.20, 15.15),
      AddressInfo(55.41, 12.34),
      AddressInfo(11.08, 42.20),
      AddressInfo(15.20, 61.24),
      AddressInfo(18.30, 69.59),

      AddressInfo(00.15, 78.35),
      AddressInfo(30.01, 31.14),

      AddressInfo(03.45, 08.50),
      AddressInfo(15.19, 38.55),
      AddressInfo(59.22, 24.48),
      AddressInfo(09.02, 38.42),
      AddressInfo(51.40, 59.51),
      AddressInfo(62.05, 06.56),

      AddressInfo(60.15, 25.03),
      AddressInfo(48.50, 02.20),
      AddressInfo(05.05, 52.18),

      AddressInfo(00.25, 09.26),
      AddressInfo(13.28, 16.40),
      AddressInfo(41.43, 44.50),
      AddressInfo(52.30, 13.25),
      AddressInfo(05.35, 00.06),
      AddressInfo(37.58, 23.46),
      AddressInfo(64.10, 51.35),
      AddressInfo(16.00, 61.44),

      AddressInfo(49.26, 02.33),
      AddressInfo(09.29, 13.49),
      AddressInfo(11.45, 15.45),
      AddressInfo(06.50, 58.12),
      AddressInfo(18.40, 72.20),
      AddressInfo(53.00, 74.00),
      AddressInfo(14.05, 87.14),
      AddressInfo(47.29, 19.05),
      AddressInfo(64.10, 21.57),
      AddressInfo(28.37, 77.13),

      AddressInfo(35.44, 51.30),
      AddressInfo(33.20, 44.30),
      AddressInfo(53.21, 06.15),
      AddressInfo(31.71, 35.10),
      AddressInfo(41.54, 12.29),
      AddressInfo(18.00, 76.50),
      AddressInfo(31.57, 35.52),
      AddressInfo(51.10, 71.30),
      AddressInfo(01.17, 36.48),

      AddressInfo(29.30, 48.00),
      AddressInfo(42.54, 74.46),

      AddressInfo(56.53, 24.08),
      AddressInfo(33.53, 35.31),
      AddressInfo(29.18, 27.30),
      AddressInfo(06.18, 10.47),
      AddressInfo(32.49, 13.07),
      AddressInfo(47.08, 09.31),
      AddressInfo(54.38, 25.19),
      AddressInfo(49.37, 06.09),

      AddressInfo(18.55, 47.31),
      AddressInfo(42.01, 21.26),
      AddressInfo(14.00, 33.48),

      AddressInfo(04.00, 73.28),
      AddressInfo(12.34, 07.55),
      AddressInfo(35.54, 14.31),
      AddressInfo(14.36, 61.02),
      AddressInfo(20.10, 57.30),
      AddressInfo(12.48, 45.14),

      AddressInfo(47.02, 28.50),
      AddressInfo(25.58, 32.32),

      AddressInfo(22.35, 17.04),
      AddressInfo(52.23, 04.54),
      AddressInfo(12.05, 69.00),

      AddressInfo(12.06, 86.20),
      AddressInfo(13.27, 02.06),
      AddressInfo(09.05, 07.32),

      AddressInfo(33.30, 36.18),
    ];
  }

  List<MarkLocationMockModel> mockPostData({int index = 0}) {
    // final String imageId = faker.randomGenerator.element(imageIds);
    // final String createdAt = DateTime.now().subtract(Duration(days: index)).toIso8601String();

    List<MarkLocationMockModel> items = [];

    List<AddressInfo> itemsLocations = _getLocationAddress();
    for (int i = 0; i < itemsLocations.length; i++) {
      Faker faker = Faker();
      items.add(MarkLocationMockModel(
          lon: itemsLocations[i].lon,
          lat: itemsLocations[i].lon,
          title: faker.address.city(),
          country: faker.address.country(),
          firstName: faker.person.firstName(),
          address: faker.address.streetName(),
          image: 'https://picsum.photos/id/${i*2}/5616/3744',
          name: faker.person.name()));
    }

    return items;
  }
}
