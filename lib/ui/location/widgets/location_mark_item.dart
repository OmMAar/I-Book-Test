import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_structure/common/widgets/horizontal_padding.dart';
import 'package:my_structure/common/widgets/vertical_padding.dart';
import 'package:my_structure/constants/app_constants.dart';
import 'package:my_structure/models/map/mark_location_model.dart';
import 'package:my_structure/widgets/image/image_network_circle.dart';

class LocationMarkItem extends StatefulWidget {
  final double width;
  final double height;
  final MarkLocationMockModel locationAddress;

  const LocationMarkItem(
      {required this.locationAddress,
      required this.height,
      required this.width});

  @override
  _LocationMarkItemState createState() => _LocationMarkItemState();
}

class _LocationMarkItemState extends State<LocationMarkItem> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    double widthC = widget.width;
    double heightC = widget.height;
    return GestureDetector(
      onTap: () {
        if (mounted)
          setState(() {
            isOpen = !isOpen;
          });
      },
      child: Container(
        width: widthC,
        height: heightC,
        decoration: BoxDecoration(
          color: isOpen? AppColors.mainGray : AppColors.transparent,
          shape: BoxShape.circle
        ),
        padding: const EdgeInsets.all(AppDimens.space8),
        child: Container(
          child: FittedBox(
            child: Row(
              children: [
                ImageNetworkCircleWidget(
                  imageUrl: widget.locationAddress.image,
                  boxFit: BoxFit.fill,
                  imageWidth: widthC * .5,
                  imageHeight: widthC * .5,
                  imageBorderRadius: 12.0,
                ),
                isOpen
                    ? SlideInDown(
                  duration: Duration(milliseconds: 750),
                        child: Row(
                        children: [
                          HorizontalPadding(
                            percentage: 0.01,
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    widget.locationAddress.name,
                                    style: appTextStyle.middleTSBasic
                                        .copyWith(color: AppColors.white,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                VerticalPadding(
                                  percentage: 0.02,
                                ),
                                Container(
                                  child: Text(
                                    widget.locationAddress.address,
                                    style: appTextStyle.smallTSBasic
                                        .copyWith(color: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
