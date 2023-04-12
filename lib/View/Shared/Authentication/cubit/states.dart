import 'dart:io';

import 'package:resource_up/data/model/authintication_model.dart';

abstract class AuthenticationStates {}

class AuthenticationInitialState extends AuthenticationStates {}

class LoginLoadingState extends AuthenticationStates {}

class LoginSuccessState extends AuthenticationStates {
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends AuthenticationStates {
  final String error;

  LoginErrorState(this.error);
}

class AuthenticationPasswordVisibilityState extends AuthenticationStates {}

class RegisterLoadingState extends AuthenticationStates {}

class RegisterSuccessState extends AuthenticationStates {
  final RegisterModel registerModel;
  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends AuthenticationStates {
  final String error;

  RegisterErrorState(this.error);
}

class NextStepSuccessState extends AuthenticationStates {}

class ContinueStepSuccessState extends AuthenticationStates {}

class PreviewsStepSuccessState extends AuthenticationStates {}

class SelectedIndustrySuccessState extends AuthenticationStates {}

class ImagePickerInitialState extends AuthenticationStates {}

class ImagePickerLoadingState extends AuthenticationStates {}

class ImagePickerLoadedState extends AuthenticationStates {
  final File? imageFile;

  ImagePickerLoadedState(this.imageFile);
}

class RegisterCompanyLoadingState extends AuthenticationStates {}

class RegisterCompanySuccessState extends AuthenticationStates {
  final RegisterCompanyModel registeCompanyrModel;
  RegisterCompanySuccessState(this.registeCompanyrModel);
}

class RegisterCompanyErrorState extends AuthenticationStates {
  final String error;

  RegisterCompanyErrorState(this.error);
}
