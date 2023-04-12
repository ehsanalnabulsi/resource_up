import 'package:flutter/material.dart';

import '../../View/Shared/Attendance/cubit/cubit.dart';

String greeting() {
  var hour = DateTime.now().hour;
  String greeting;
  if (hour < 12) {
    greeting = 'Good Morning';
  } else if (hour < 18) {
    greeting = 'Good Afternoon';
  } else {
    greeting = 'Good Evening';
  }

  return greeting;
}

// String isCheckedIn(BuildContext context) {
//   bool isCheckIn = AttendanceCubit.get(context).isCheckIn;
//   var message = 'You haven\'t Check in yet';
//   if (isCheckIn) message = 'Check Out Before Leave';
//   return message;
// }
