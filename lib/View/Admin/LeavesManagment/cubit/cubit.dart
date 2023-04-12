import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resource_up/View/Admin/LeavesManagment/cubit/states.dart';
import 'package:resource_up/data/datasource/static/static.dart';

import '../../../../data/model/leaves_model.dart';

class LeavesCubit extends Cubit<LeavesStates> {
  LeavesCubit() : super(GetLeavesListInitialState());
  static LeavesCubit get(context) => BlocProvider.of(context);

  List<Leave> leavesList = fakeLeaves;
  List<Leave> pendingLeavesList = [];
  List<Leave> approvedLeavesList = [];
  List<Leave> rejectedLeavesList = [];
  List<Tab> tabs = const [
    Tab(text: 'Pending '),
    Tab(text: 'Approved'),
    Tab(text: 'Rejected'),
  ];
  void filterLeaves() {
    pendingLeavesList = [];
    approvedLeavesList = [];
    rejectedLeavesList = [];
    emit(GetLeavesListLoadingState());
    for (var element in fakeLeaves) {
      if (element.status == Status.approved) {
        approvedLeavesList.add(element);
      } else if (element.status == Status.rejected) {
        rejectedLeavesList.add(element);
      } else {
        pendingLeavesList.add(element);
      }
    }
    emit(GetLeavesListSuccessState());
  }

  // void getLeavesList() {
  //   emit(GetLeavesListLoadingState());
  //   DioHelper.getHttp(url: 'users?page=2', query: {}).then((value) {
  //     //leavesList = value.data['data'];

  //     emit(GetLeavesListSuccessState());
  //   }).catchError((error) {
  //     print(error);

  //     //  emit(GetLeavesListErrorState(error.toString()));
  //   });
  // }

  void approveLeave(var id) {
    emit(ApproveLeaveLoadingState());
    for (var element in fakeLeaves) {
      if (element.id == id) {
        element.status = Status.approved;
      }
      filterLeaves();
      emit(ApproveLeaveSuccessState());
    }
  }

  void rejectLeave(var id) {
    emit(RejectLeaveLoadingState());
    for (var element in fakeLeaves) {
      if (element.id == id) {
        element.status = Status.rejected;
      }
      filterLeaves();
      emit(RejectLeaveSuccessState());
    }
  }
}
