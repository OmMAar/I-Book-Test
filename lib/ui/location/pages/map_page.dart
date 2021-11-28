import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_structure/constants/app_constants.dart';
import 'package:my_structure/data/repo/home_repository.dart';
import 'package:my_structure/di/components/service_locator.dart';
import 'package:my_structure/models/map/mark_location_model.dart';
import 'package:my_structure/ui/location/widgets/location_list_item.dart';
import 'package:my_structure/ui/location/widgets/location_mark_item.dart';
import 'package:my_structure/utils/device/device_utils.dart';

const maxMarkersCount = 5000;

/// On this page, [maxMarkersCount] markers are randomly generated
/// across europe, and then you can limit them with a slider
///
/// This way, you can test how map performs under a lot of markers
///
class MapPage extends StatefulWidget {
  static const String route = 'NetworkTileProvider';

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  List<MarkLocationMockModel> addresses = [];
  List<Marker> markers = [];
  late final MapController mapController;

  _initializeInfo() {

    HomeRepository _repository = getIt<HomeRepository>();
    addresses = _repository.mockPostData();

    for (MarkLocationMockModel location in addresses) {
      markers.add(Marker(
          width: 100.0,
          height: 100.0,
          point: LatLng(location.lat, location.lon),
          builder: (ctx) => LocationMarkItem(
              locationAddress: location, height: 100, width: 100)

          //     Container(
          //   color: AppColors.lightGrey.withOpacity(0.5),
          //   padding: const EdgeInsets.symmetric(vertical: AppDimens.space8),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       ImageNetworkCircleWidget(
          //         imageHeight: 50,
          //         imageWidth: 50,
          //         imageBorderRadius: 50,
          //         boxFit: BoxFit.fill,
          //         imageUrl: location.image,
          //       ),
          //       Text(
          //         location.name,
          //         style: appTextStyle.minTSBasic.copyWith(
          //           color: AppColors.black
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeInfo();
    mapController = MapController();
  }

  void _animatedMapMove(double latitude, double longitude, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween =
        Tween<double>(begin: mapController.center.latitude, end: latitude);
    final _lngTween =
        Tween<double>(begin: mapController.center.longitude, end: longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Home"),
      backgroundColor: AppColors.appBarBGColor,
      brightness: Brightness.light,
      elevation: 0,
    );

    double widthC = DeviceUtils.getScaledWidth(context, 1);
    double heightC = DeviceUtils.getScaledHeight(context, 1) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      appBar: appBar,
      // drawer: buildDrawer(context, route),
      body: Container(
        width: widthC,
        height: heightC,
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(

                mapController: mapController,
                options: MapOptions(
                  center: LatLng(addresses.first.lat, addresses.first.lon),
                  zoom: 5.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    // For example purposes. It is recommended to use
                    // TileProvider with a caching and retry strategy, like
                    // NetworkTileProvider or CachedNetworkTileProvider
                    tileProvider: NetworkTileProvider(),
                  ),
                  MarkerLayerOptions(markers: markers)
                ],
              ),
            ),
            Container(
              height: heightC * 0.2,
              color: AppColors.mainGray,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return LocationListItem(
                    locationAddress: addresses[index],
                    animatedMapMove: _animatedMapMove,
                  );
                },
                itemCount: addresses.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDimens.space8),
                physics: AlwaysScrollableScrollPhysics(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
// class MapPage extends StatefulWidget {
//   // static const String route = '/many_markers';
//
//   @override
//   _MapPagePageState createState() => _MapPagePageState();
// }
//
// class _MapPagePageState extends State<MapPage> {
//   double doubleInRange(Random source, num start, num end) =>
//       source.nextDouble() * (end - start) + start;
//   List<Marker> allMarkers = [];
//
//   int _sliderVal = maxMarkersCount ~/ 10;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       var r = Random();
//       for (var x = 0; x < maxMarkersCount; x++) {
//         allMarkers.add(
//           Marker(
//             point: LatLng(
//               doubleInRange(r, 37, 55),
//               doubleInRange(r, -9, 30),
//             ),
//             builder: (context) => const Icon(
//               Icons.circle,
//               color: Colors.red,
//               size: 12.0,
//             ),
//           ),
//         );
//       }
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('A lot of markers')),
//       // drawer: buildDrawer(context, ManyMarkersPage.route),
//       body: Column(
//         children: [
//           Slider(
//             min: 0,
//             max: maxMarkersCount.toDouble(),
//             divisions: maxMarkersCount ~/ 500,
//             label: 'Markers',
//             value: _sliderVal.toDouble(),
//             onChanged: (newVal) {
//               _sliderVal = newVal.toInt();
//               setState(() {});
//             },
//           ),
//           Text('$_sliderVal markers'),
//           Flexible(
//             child: FlutterMap(
//               options: MapOptions(
//                 center: LatLng(50, 20),
//                 zoom: 5.0,
//                 interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
//               ),
//               layers: [
//                 TileLayerOptions(
//                   urlTemplate:
//                   'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   subdomains: ['a', 'b', 'c'],
//                 ),
//                 MarkerLayerOptions(
//                     markers: allMarkers.sublist(
//                         0, min(allMarkers.length, _sliderVal))),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
