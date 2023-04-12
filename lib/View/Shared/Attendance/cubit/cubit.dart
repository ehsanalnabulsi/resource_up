// ignore_for_file: avoid_print

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resource_up/View/Shared/Attendance/cubit/states.dart';

import '../../../../core/constant/end_point.dart';
import '../../../../core/services/remote/dio_helper.dart';

class AttendanceCubit extends Cubit<AttendanceStates> {
  AttendanceCubit() : super(AttendanceInitialState());
  static AttendanceCubit get(context) => BlocProvider.of(context);
  // late AttendanceModel attendanceModel;
  late Map attendanceUser;
  void getAttendanceInfo() {
    emit(AttendanceLoadingState());
    DioHelper.getHttp(url: getAttendance).then((value) {
      print(value.data);
      attendanceUser = value.data['data'][0];
      print(attendanceUser);
      print(attendanceUser['dayEnd']);
      Future.delayed(Duration(seconds: 2));
      emit(AttendanceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AttendanceErrorState());
    });
  }

  Future<void> scanBarcode() async {
    var barcode = await FlutterBarcodeScanner.scanBarcode(
        "#172d4f", "Cancel", true, ScanMode.QR);
    if (barcode.isNotEmpty) {
      print(barcode);
      DioHelper.postHttp(url: scanQr, data: {'barcode': barcode});
      emit(BarcodeScanSuccessState(barcode));
    } else {
      emit(BarcodeScanErrorState());
    }
  }
}
