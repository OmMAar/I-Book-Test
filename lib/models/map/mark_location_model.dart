class MarkLocationMockModel{
  final double lat;
  final double lon;
  final String image;
  final String name;
  final String firstName;
  final String title;
  final String address;
  final String country;

  const MarkLocationMockModel({required this.name,
      required this.image,required this.address,required this.lat,required this.lon,required this.title,required this.firstName,required this.country});
}

class AddressInfo{
  final double lat;
  final double lon;
  const AddressInfo(this.lat,this.lon);
}