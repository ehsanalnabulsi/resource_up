import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';

Widget primaryButton({
  String text = 'Type Text',
  double width = 300.0,
  double height = 40.0,
  double fontSize = 16.0,
  FontWeight fontWeight = FontWeight.bold,
  double elevation = 0.0,
  double radius = 15,
  Color primaryColor = AppColor.primaryColor,
  required void Function()? onPressed,
  Color textColor = Colors.white,
}) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        minimumSize: Size(width, height),
        backgroundColor: primaryColor,
        elevation: elevation,
        textStyle: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
Widget secondaryButton({
  String text = 'Type Text',
  double width = 300.0,
  double height = 40.0,
  double fontSize = 16.0,
  FontWeight fontWeight = FontWeight.bold,
  double elevation = 6.0,
  Color primaryColor = AppColor.primaryColor,
  double radius = 25,
  required void Function()? onPressed,
  // Color textColor = Colors.white,
}) =>
    OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(width, height),
        foregroundColor: primaryColor,
        //elevation: elevation,
        textStyle: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
