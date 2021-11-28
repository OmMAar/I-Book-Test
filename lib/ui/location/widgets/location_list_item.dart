import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_structure/common/widgets/horizontal_padding.dart';
import 'package:my_structure/common/widgets/vertical_padding.dart';
import 'package:my_structure/constants/app_constants.dart';
import 'package:my_structure/models/map/mark_location_model.dart';
import 'package:my_structure/utils/device/device_utils.dart';
import 'package:my_structure/widgets/image/image_network_circle.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
class LocationListItem extends StatefulWidget {
  final MarkLocationMockModel locationAddress;
  final Function(double latitude,double longitude, double destZoom) animatedMapMove;

  const LocationListItem({required this.locationAddress,required this.animatedMapMove});

  @override
  _LocationListItemState createState() => _LocationListItemState();
}

class _LocationListItemState extends State<LocationListItem> {
  @override
  Widget build(BuildContext context) {
    double widthC = DeviceUtils.getScaledWidth(context, 0.6);
    double heightC = DeviceUtils.getScaledHeight(context, 0.4);
    return GestureDetector(
      onTap: (){
        widget.animatedMapMove(widget.locationAddress.lat,widget.locationAddress.lon,7.0);
      },
      child: SlideInRight(
        child: Container(
          width: widthC,
          height: heightC,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.radiusDefault)),
            child: Container(
              child: Row(
                children: [
                  ImageNetworkCircleWidget(
                    imageUrl: widget.locationAddress.image,
                    boxFit: BoxFit.fill,
                    imageWidth: widthC * .5,
                    imageHeight: heightC,
                    imageBorderRadius: AppRadius.radiusDefault,
                  ),
                  HorizontalPadding(percentage: 0.01,),
                  Expanded(
                      child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                           "${ widget.locationAddress.firstName} ${ widget.locationAddress.name}",
                            style: appTextStyle.smallTSBasic
                                .copyWith(color: AppColors.mainColor,fontWeight: FontWeight.bold),
                          ),
                        ),
                        VerticalPadding(
                          percentage: 0.02,
                        ),
                        Container(
                          child: Text(
                            widget.locationAddress.address,
                            style: appTextStyle.smallTSBasic
                                .copyWith(color: AppColors.mainColor),
                          ),
                        ),
                        VerticalPadding(
                          percentage: 0.02,
                        ),
                        Container(
                          child: Text(
                            widget.locationAddress.country,
                            style: appTextStyle.smallTSBasic
                                .copyWith(color: AppColors.mainColor),
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
