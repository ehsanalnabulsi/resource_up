abstract class PayrollsStates {}

class GetPayrollsListInitialState extends PayrollsStates {}

class GetLeavesListLoadingState extends PayrollsStates {}

class GetLeavesListSuccessState extends PayrollsStates {
  //   final List<Request> requests;

  // GetRequestsListSuccessState(this.requests);
}
