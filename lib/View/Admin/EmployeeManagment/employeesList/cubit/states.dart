abstract class EmployeesStates {}

class GetEmployeesListInitialState extends EmployeesStates {}

class GetEmployeesListLoadingState extends EmployeesStates {}

class GetEmployeesListSuccessState extends EmployeesStates {
  
}

class GetEmployeesListErrorState extends EmployeesStates {
  late String error;

  GetEmployeesListErrorState(String string);
}



class GetEmployeeDetailsLoadingState extends EmployeesStates {}

class GetEmployeeDetailsSuccessState extends EmployeesStates {}

class GetEmployeeDetailsErrorState extends EmployeesStates {
  late String error;

  GetEmployeeDetailsErrorState(String string);
}

class SearchInitialState extends EmployeesStates {}

class SearchLoadingState extends EmployeesStates {}

class GetSearchListSuccessState extends EmployeesStates {}

class GetSearchListErrorState extends EmployeesStates {
  late String error;

  GetSearchListErrorState(String string);
}
