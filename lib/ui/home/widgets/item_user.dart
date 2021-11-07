import 'package:flutter/material.dart';
import 'package:my_structure/common/widgets/vertical_padding.dart';
import 'package:my_structure/constants/app_constants.dart';
import 'package:my_structure/models/user/user_model.dart';
import 'package:my_structure/widgets/image/image_network_circle.dart';

class ItemUser extends StatefulWidget {
  final UserModel user;
  const ItemUser({required this.user});
  @override
  _ItemUserAttendState createState() => _ItemUserAttendState();
}

class _ItemUserAttendState extends State<ItemUser> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(AppRadius.radius8)),
      child: Container(
        width: 120,
        height: 120,
        // margin: const EdgeInsetsDirectional.only(end: AppDimens.space6),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: AppColors.black),
            borderRadius:
            BorderRadius.all(Radius.circular(AppRadius.radius8))),
        child: Container(
          padding: const EdgeInsets.all(AppDimens.space2),
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                VerticalPadding(
                  percentage: 0.015,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.black, width: 0.2),
                      color: AppColors.mainGray.withOpacity(0.5)),
                  // padding: const EdgeInsets.all(AppDimens.space12),
                  child: ImageNetworkCircleWidget(
                    imageUrl: widget.user.avatar??"",
                    imageWidth: 50,
                    imageHeight: 50,
                    imageBorderRadius: 50,

                  ),
                ),
                VerticalPadding(
                  percentage: 0.015,
                ),
                Container(
                  child: Wrap(
                    children: [
                      Text(
                       "${widget.user.firstName ?? ""} ${widget.user.lastName ?? ""}",
                        style: appTextStyle.smallTSBasic.copyWith(
                            color: AppColors.mainGray,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                VerticalPadding(
                  percentage: 0.007,
                ),
                Container(
                  child: Wrap(
                    children: [
                      Text(
                        widget.user.email??"",
                        style: appTextStyle.sub2MinTSBasic.copyWith(
                            color: AppColors.mainGray,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                VerticalPadding(
                  percentage: 0.015,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
