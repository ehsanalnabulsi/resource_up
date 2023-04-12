import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

import '../../../core/constant/app_color.dart';

Widget digitalClock() => DigitalClock(
      showSecondsDigit: false,
      digitAnimationStyle: Curves.easeIn,
      colon: const Text(
        ':',
        style: TextStyle(fontSize: 18.0),
      ),
      secondDigitTextStyle: const TextStyle(fontSize: 18.0),
      is24HourTimeFormat: false,
      areaDecoration: const BoxDecoration(color: Colors.transparent),
      hourMinuteDigitTextStyle:
          const TextStyle(color: AppColor.blackColor, fontSize: 48),
      amPmDigitTextStyle: const TextStyle(
          fontSize: 24,
          color: AppColor.blackColor,
          fontWeight: FontWeight.bold),
    );
