import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resource_up/View/Shared/Widgets/buttons.dart';

import '../constant/app_color.dart';

Future<bool> exitAppAlert() {
  Get.defaultDialog(
    title: 'Warning',
    radius: 5,
    titlePadding: const EdgeInsets.all(20.0),
    contentPadding: const EdgeInsets.all(20.0),
    buttonColor: AppColor.primaryColor,
    titleStyle: const TextStyle(fontSize: 24.0, color: AppColor.primaryColor),
    middleText: 'Are you sure you want\nto close the app?',
    middleTextStyle:
        const TextStyle(fontSize: 16.0, color: AppColor.primaryColor),
    cancelTextColor: AppColor.primaryColor,
    confirmTextColor: AppColor.whiteColor,
    cancel: secondaryButton(onPressed: () => Get.back(), text: 'Cancel'),
    confirm: primaryButton(onPressed: () => exit(0), text: 'Exit App'),
  );
  return Future.value(true);
}

Future<bool> warning() {
  Get.defaultDialog(
    title: 'Warning',
    radius: 15,
    buttonColor: AppColor.primaryColor,
    titleStyle: const TextStyle(fontSize: 24.0, color: AppColor.primaryColor),
    middleText: 'Are you sure you want\nto close the app?',
    middleTextStyle:
        const TextStyle(fontSize: 16.0, color: AppColor.primaryColor),
    onConfirm: () => exit(0),
    onCancel: () => Get.back(),
    cancelTextColor: AppColor.primaryColor,
    confirmTextColor: AppColor.whiteColor,
  );
  return Future.value(true);
}
