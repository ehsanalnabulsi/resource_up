abstract class LeavesStates {}

class GetLeavesListInitialState extends LeavesStates {}

class GetLeavesListLoadingState extends LeavesStates {}

class GetLeavesListSuccessState extends LeavesStates {
  //   final List<Request> requests;

  // GetRequestsListSuccessState(this.requests);
}

class ApproveLeaveLoadingState extends LeavesStates {}

class ApproveLeaveSuccessState extends LeavesStates {
  //   final List<Request> requests;

  // GetRequestsListSuccessState(this.requests);
}

class RejectLeaveLoadingState extends LeavesStates {}

class RejectLeaveSuccessState extends LeavesStates {
  //   final List<Request> requests;

  // GetRequestsListSuccessState(this.requests);
}
