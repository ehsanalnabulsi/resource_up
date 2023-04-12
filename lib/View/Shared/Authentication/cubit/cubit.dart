import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constant/end_point.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/services/local/cache_helper.dart';
import '../../../../core/services/remote/dio_helper.dart';
import '../../../../data/datasource/static/static.dart';
import '../../../../data/model/authintication_model.dart';
import 'states.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates> {
  AuthenticationCubit() : super(AuthenticationInitialState());
  static AuthenticationCubit get(context) => BlocProvider.of(context);
  late LoginModel loginModel;
  late RegisterCompanyModel registerCompanyModel;
  late RegisterModel registerModel;
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AuthenticationPasswordVisibilityState());
  }

  void userLogin({
    required String username,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postHttp(url: login, data: {
      'username': username,
      'password': password,
    }).then((value) async {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.data!.access);
      await CacheHelper.setData(key: 'token', value: loginModel.data!.access);
      emit(LoginSuccessState(loginModel));
      Get.offAllNamed(AppRoute.registerCompany);
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  void userRegister({
    required String fullName,
    required String email,
    required String username,
    required String password,
    required String gender,
    required String birthDate,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postHttp(url: register, data: {
      'fullName': fullName,
      'username': username,
      'password': password,
      'email': email,
      'birthDate': birthDate,
      'gender': gender,
      'is_hr': true,
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel));
    }).catchError((e) {
      emit(RegisterErrorState(e.toString()));
    });
  }

  List<String> workingDays = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];
  late var industrySelected = industries[0];

  void changeIndustrySelectedValue({required String selectedValue}) {
    industrySelected = selectedValue;
    emit(SelectedIndustrySuccessState());
  }

// stepper for company register
  int currentStep = 0;
  void stepContinue() {
    if (currentStep == 1) {
      Get.offAllNamed(AppRoute.adminMainPage);
      emit(ContinueStepSuccessState());
      return;
    }
    currentStep++;
    emit(ContinueStepSuccessState());
    return;
  }

  void nextStep(step) {
    currentStep = step;

    emit(NextStepSuccessState());
  }

  void previewsStep() {
    currentStep == 0 ? null : currentStep--;
    emit(PreviewsStepSuccessState());
  }

  File? imageFile;
  Future<void> pickImage() async {
    emit(ImagePickerLoadingState());
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = basename(pickedFile.path);
      final savedImage = await imageFile.copy('${appDir.path}/$fileName');
      this.imageFile = savedImage;
      emit(ImagePickerLoadedState(savedImage));
    }
  }

  void registerCompany({
    required String companyName,
    required String website,
    required String address,
    required String establishedDate,
    required String email,
    required String phoneNumber,
    required String typeOfIndustry,
    required List<String> departments,
    required List<String> positions,
    required String startTime,
    required String endTime,
  }) {
    emit(RegisterCompanyLoadingState());
    DioHelper.postHttp(url: registercompany, data: {
      'companyName': companyName,
      'address': address,
      'phone': phoneNumber,
      'email': email,
      'industryType': typeOfIndustry,
      'establishedDate': establishedDate,
      'website': website,
      'startTime': startTime,
      'endTime': endTime,
      'departments': departments,
      'positions': positions,
      'late_time': startTime,
    }).then((value) {
      registerCompanyModel = RegisterCompanyModel.fromJson(value.data);
      emit(RegisterCompanySuccessState(registerCompanyModel));
    }).catchError((e) {
      emit(RegisterCompanyErrorState(e.toString()));
    });
  }
}
