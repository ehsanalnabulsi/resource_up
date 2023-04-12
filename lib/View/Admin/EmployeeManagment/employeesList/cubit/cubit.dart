import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:resource_up/View/Admin/EmployeeManagment/employeesList/cubit/states.dart';
import 'package:resource_up/core/constant/routes.dart';
import 'package:resource_up/core/services/remote/dio_helper.dart';
import '../../../../../core/constant/end_point.dart';

class EmployeesCubit extends Cubit<EmployeesStates> {
  EmployeesCubit() : super(GetEmployeesListInitialState());
  static EmployeesCubit get(context) => BlocProvider.of(context);

  List<dynamic> employeeList = [];
  List<dynamic> departmentEmployeesList = [];
  List<dynamic> positionEmployeesList = [];
  late Map<String, dynamic> employeeDetails;
  void getEmployeeList() {
    emit(GetEmployeesListLoadingState());
    DioHelper.getHttp(url: employees, query: {}).then((value) {
      // employeeList = value.data;
      employeeList = value.data['data'];
      print(employeeList);

      emit(GetEmployeesListSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetEmployeesListErrorState(error.toString()));
    });
  }

  void fetchEmployeeDetails(int id) {
    emit(GetEmployeeDetailsLoadingState());
    DioHelper.getHttp(url: profile, query: {
      'user_id': id,
    }).then((value) {
      employeeDetails = value.data;
      print(value.data);
      emit(GetEmployeeDetailsSuccessState());

      Get.toNamed(AppRoute.employeePage, arguments: employeeDetails);
    });
  }

  late Map removeEmployeeResoponse;
  void removeEmployee(int id) {
    DioHelper.deleteHttp(
      url: deleteEmployees,
      query: {'id': id},
    ).then((value) {
      removeEmployeeResoponse = value.data;
      employeeList.removeWhere((element) => element['user_id_id'] == id);
    }).catchError((error) {
      print(error.toString());
    });
  }

  // List<dynamic> search = [];
  // void getSearch(String value) {
  //   emit(SearchLoadingState());
  //   DioHelper.getHttp(url: '/users?page=2', query: {
  //     'q': value,
  //   }).then((value) {
  //employeeList = value.data;
  //     search = value.data['data'];

  //     emit(GetSearchListSuccessState());
  //   }).catchError((error) {

  //     emit(GetSearchListErrorState(error.toString()));
  //   });
  // }
}
