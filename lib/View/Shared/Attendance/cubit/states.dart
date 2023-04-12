abstract class AttendanceStates {}

class AttendanceInitialState extends AttendanceStates {}

class AttendanceLoadingState extends AttendanceStates {}

class AttendanceSuccessState extends AttendanceStates {}

class AttendanceErrorState extends AttendanceStates {}

class BarcodeScanSuccessState extends AttendanceStates {
  final String barcode;

  BarcodeScanSuccessState(this.barcode);
}

class BarcodeScanErrorState extends AttendanceStates {}
