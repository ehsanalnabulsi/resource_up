import '../../../../data/model/user_model.dart';

abstract class UserMainStates {}

class UserMainInitialState extends UserMainStates {}

class UserMainChangeBottomNavState extends UserMainStates {}

class GetUserInformationLoadingState extends UserMainStates {}

class GetUserInformationSuccessState extends UserMainStates {
  final UserModel userModel;

  GetUserInformationSuccessState(this.userModel);
}

class GetUserInformationErrorState extends UserMainStates {
  final dynamic error;

  GetUserInformationErrorState(this.error);
}