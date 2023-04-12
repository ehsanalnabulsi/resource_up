import 'dart:io';

import 'package:resource_up/data/model/add_employee_model.dart';

abstract class AddEmployeeStates {}

class AddEmployeeInitialState extends AddEmployeeStates {}

class AddEmployeeLoadingState extends AddEmployeeStates {}

class AddEmployeeSuccessState extends AddEmployeeStates {
  final AddEmployeeModel addEmployeeModel;
  AddEmployeeSuccessState(this.addEmployeeModel);
}

class AddEmployeeErrorState extends AddEmployeeStates {
  final String error;

  AddEmployeeErrorState(this.error);
}

class ImagePickerInitialState extends AddEmployeeStates {}

class ImagePickerLoadingState extends AddEmployeeStates {}

class ImagePickerLoadedState extends AddEmployeeStates {
  final File? imageFile;

  ImagePickerLoadedState(this.imageFile);
}

class GetDepartmentsListLoadingState extends AddEmployeeStates {}

class GetDepartmentsListSuccessState extends AddEmployeeStates {}

class GetDepartmentsListErrorState extends AddEmployeeStates {}

class GetPositionsListLoadingState extends AddEmployeeStates {}

class GetPositionsListSuccessState extends AddEmployeeStates {}

class GetPositionsListErrorState extends AddEmployeeStates {}
