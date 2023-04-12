import 'package:resource_up/data/model/company_model.dart';
import 'package:resource_up/data/model/user_model.dart';

abstract class AdminMainStates {}

class MainInitialState extends AdminMainStates {}

class MainChangeBottomNavState extends AdminMainStates {}

class GetEmployeeNumberSuccessState extends AdminMainStates {}

class GetEmployeeNumberErrorState extends AdminMainStates {}

class GetCompanyInformationLoadingState extends AdminMainStates {}

class GetCompanyInformationSuccessState extends AdminMainStates {
  final CompanyModel companyModel;
  GetCompanyInformationSuccessState(this.companyModel);
}

class GetCompanyInformationrErrorState extends AdminMainStates {
  final String error;
  GetCompanyInformationrErrorState(this.error);
}

class GetUserInformationLoadingState extends AdminMainStates {}

class GetUserInformationSuccessState extends AdminMainStates {
  final UserModel userModel;

  GetUserInformationSuccessState(this.userModel);
}

class GetUserInformationErrorState extends AdminMainStates {
  final dynamic error;

  GetUserInformationErrorState(this.error);
}

class GetDepartmentsListLoadingState extends AdminMainStates {}

class GetDepartmentsListSuccessState extends AdminMainStates {}

class GetDepartmentsListErrorState extends AdminMainStates {}

class GetPositionsListLoadingState extends AdminMainStates {}

class GetPositionsListSuccessState extends AdminMainStates {}

class GetPositionsListErrorState extends AdminMainStates {}

class GetDepartmentEmployeesListInitialState extends AdminMainStates {}

class GetDepartmentEmployeesListLoadingState extends AdminMainStates {}

class GetDepartmentEmployeesListSuccessState extends AdminMainStates {}

class GetDepartmentEmployeesListErrorState extends AdminMainStates {
  late String error;

  GetDepartmentEmployeesListErrorState(String string);
}

class GetPositionsEmployeesListInitialState extends AdminMainStates {}

class GetPositionsEmployeesListLoadingState extends AdminMainStates {}

class GetPositionsEmployeesListSuccessState extends AdminMainStates {}

class GetPositionsEmployeesListErrorState extends AdminMainStates {
  late String error;

  GetPositionsEmployeesListErrorState(String string);
}
