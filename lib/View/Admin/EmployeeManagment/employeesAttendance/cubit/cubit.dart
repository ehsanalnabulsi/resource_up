import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resource_up/core/services/remote/dio_helper.dart';

import '../../../../../core/constant/end_point.dart';
import 'states.dart';

class EmployeesAttendanceCubit extends Cubit<EmployeesAttendanceStates> {
  EmployeesAttendanceCubit() : super(GetEmployeesAttendanceInitialState());
  static EmployeesAttendanceCubit get(context) => BlocProvider.of(context);
  late Map attendanceList;
  Future<void> getEmployeesAttendance() async {
    emit(GetEmployeesAttendanceLoadingState());
    DioHelper.getHttp(url: getAttends).then((value) {
      print(value.data);
      attendanceList = value.data;

      // Future.delayed(Duration(seconds: 2));
      emit(GetEmployeesAttendanceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetEmployeesAttendanceErrorState());
    });
  }
}
