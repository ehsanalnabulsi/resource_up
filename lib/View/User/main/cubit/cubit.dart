import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resource_up/View/User/main/cubit/states.dart';
import 'package:resource_up/View/User/main/user_home_page.dart';
import 'package:resource_up/View/User/main/user_profile_page.dart';
import 'package:resource_up/View/User/main/user_request_page.dart';

import '../../../../core/constant/end_point.dart';
import '../../../../core/services/remote/dio_helper.dart';
import '../../../../data/datasource/static/static.dart';
import '../../../../data/model/leaves_model.dart';
import '../../../../data/model/user_model.dart';

class UserMainCubit extends Cubit<UserMainStates> {
  UserMainCubit() : super(UserMainInitialState());
  static UserMainCubit get(context) => BlocProvider.of(context);
  late UserModel userModel;
  int currentIndex = 0;

  List<Widget> bottomPages = const [
    UserHomePage(),
    UserRequestsPage(),
    UserProfilePage(),
  ];
  List<String> titles = [
    'Home Page',
    'Apply',
    /* 'Inbox',  */ 'Profile & Settings'
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(UserMainChangeBottomNavState());
  }

  List<Leave> leavesList = fakeLeaves;

  void getUserInformation() {
    emit(GetUserInformationLoadingState());
    DioHelper.getHttp(
      url: userInforamtion,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      Future.delayed(
        const Duration(seconds: 2),
      );
      emit(GetUserInformationSuccessState(userModel));
    }).catchError((error) {
      print(error);
      emit(GetUserInformationErrorState(error));
    });
  }

  late Map<String, dynamic> employeeDetails;
  void fetchEmployeeDetails() {
    emit(GetUserInformationLoadingState());
    DioHelper.getHttp(url: profile).then((value) {
      employeeDetails = value.data;
      print(value.data);
      emit(GetUserInformationSuccessState(userModel));
      Future.delayed(
        const Duration(seconds: 2),
      );
    }).catchError((error) {
      print(error.toString());
      emit(GetUserInformationErrorState(error));
    });
  }
}
