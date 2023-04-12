// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/constant/end_point.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/services/remote/dio_helper.dart';
import '../../../../data/model/company_model.dart';
import '../../../../data/model/user_model.dart';
import '../admin_company_page.dart';
import '../admin_home_page.dart';
import '../admin_profile_page.dart';
import 'states.dart';

class AdminMainCubit extends Cubit<AdminMainStates> {
  AdminMainCubit() : super(MainInitialState());
  static AdminMainCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  late UserModel userModel;
  late CompanyModel companyModel;
  List positionsList = [];
  List departmentsList = [];
  List<Widget> bottomPages = [
    const AdminHomePage(),
    const AdminCompanyPage(),
    const AdminProfilePage(),
  ];
  List<String> titles = [
    'Home',
    'Company',
    /* 'Inbox',  */ 'Profile & Settings'
  ];
  List<String> filter = ['Monthly', 'Daily'];
  void changeIndex(int index) {
    currentIndex = index;
    emit(MainChangeBottomNavState());
  }

  void getUserInformation() {
    emit(GetUserInformationLoadingState());
    DioHelper.getHttp(
      url: userInforamtion,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel.data!.fullName);
      emit(GetUserInformationSuccessState(userModel));
    }).catchError((error) {
      print(error);
      emit(GetUserInformationErrorState(error));
    });
  }

  Future<void> getCompanyInformation() async {
    emit(GetCompanyInformationLoadingState());
    await DioHelper.getHttp(url: companyInformation).then((value) async {
      companyModel = await CompanyModel.fromJson(value.data);
      Future.delayed(Duration(seconds: 2));
      emit(GetCompanyInformationSuccessState(companyModel));
    }).catchError((error) {
      print(error.toString());
      emit(GetCompanyInformationrErrorState(error));
    });
  }

  void getDepartments() {
    emit(GetDepartmentsListLoadingState());
    DioHelper.getHttp(
      url: departments,
    ).then((value) async {
      departmentsList = await value.data;
      Future.delayed(Duration(seconds: 2));
      emit(GetDepartmentsListSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDepartmentsListErrorState());
    });
  }

  Future<void> getPositions() async {
    emit(GetPositionsListLoadingState());
    DioHelper.getHttp(
      url: positions,
    ).then((value) {
      positionsList = value.data;
      print(positionsList);

      emit(GetPositionsListSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPositionsListErrorState());
    });
  }

  List<dynamic> departmentEmployeesList = [];
  List<dynamic> positionEmployeesList = [];
  void getDepartmentEmployeeList(int id) {
    emit(GetDepartmentEmployeesListLoadingState());
    DioHelper.getHttp(url: departmentEmployees, query: {'departments_id': id})
        .then((value) {
      departmentEmployeesList = [];
      departmentEmployeesList = value.data['data'];
      // print(employeeList);
      print(departmentEmployeesList);

      emit(GetDepartmentEmployeesListSuccessState());
      Future.delayed(Duration(seconds: 2)).then((value) => Get.toNamed(
          AppRoute.departmentEmployees,
          arguments: departmentEmployeesList));
    }).catchError((error) {
      print(error.toString());
      emit(GetDepartmentEmployeesListErrorState(error.toString()));
    });
  }

  void getPositionEmployeeList(int id) {
    emit(GetPositionsEmployeesListLoadingState());
    DioHelper.getHttp(url: positionEmployees, query: {'positions_id': id})
        .then((value) {
      positionEmployeesList = value.data['data'];
      // print(employeeList);
      print(positionEmployeesList);
      emit(GetPositionsEmployeesListSuccessState());
      Get.toNamed(AppRoute.departmentEmployees,
          arguments: positionEmployeesList);
    }).catchError((error) {
      print(error.toString());
      emit(GetPositionsEmployeesListErrorState(error.toString()));
    });
  }

  void fetchEmployeeDetails(int id) {
    emit(GetDepartmentEmployeesListLoadingState());
    DioHelper.getHttp(url: profile, query: {
      'user_id': id,
    }).then((value) {
      positionEmployeesList = value.data;
      print(value.data);
      emit(GetDepartmentEmployeesListSuccessState());

      Get.toNamed(AppRoute.employeePage, arguments: positionEmployeesList);
    }).catchError((error) {
      emit(GetDepartmentEmployeesListErrorState(error));
    });
  }
}
