import 'package:flutter/cupertino.dart';

import '../../../core/constant/app_color.dart';

Widget radiusContainer({
  Widget? child,
  Color? color = AppColor.greyColor1,
  double radius = 50,
}) =>
    Container(
      color: AppColor.primaryColor,
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(radius),
              topLeft: Radius.circular(radius),
            )),
        child: child,
      ),
    );
Widget marginContainer({
  Widget? child,
  double horizontalMargin = 12.0,
  double verticalMargin = 12.0,
}) =>
    Container(
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin, vertical: verticalMargin),
      child: child,
    );

Widget heightSizedBox() => const SizedBox(
      height: 16.0,
    );
