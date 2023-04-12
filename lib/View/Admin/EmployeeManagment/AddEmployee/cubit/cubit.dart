import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resource_up/core/constant/routes.dart';
import '../../../../../core/constant/end_point.dart';
import '../../../../../core/services/remote/dio_helper.dart';
import '../../../../../data/model/add_employee_model.dart';
import 'states.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeStates> {
  AddEmployeeCubit() : super(AddEmployeeInitialState());
  static AddEmployeeCubit get(context) => BlocProvider.of(context);
  late AddEmployeeModel addEmployeeModel;
  late Map addedEmployeeDetails;

  List<String> workingDays = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

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
      this.imageFile = savedImage; // set the value of imageFile property
      emit(ImagePickerLoadedState(savedImage));
    }
  }

  List positionsList = [];
  late Map finalPositions;
  late List<String> positionsNameList = [];
  late List positionsIdList = [];
  void getPositions() {
    emit(GetPositionsListLoadingState());
    DioHelper.getHttp(
      url: positions,
    ).then((value) {
      positionsList = value.data;
      positionsNameList = positionsList
          .map((element) => element['positionName'].toString())
          .toList();
      positionsIdList = positionsList.map((element) => element['id']).toList();
      finalPositions = Map.fromIterables(positionsNameList, positionsIdList);
      print(finalPositions);
      emit(GetPositionsListSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPositionsListErrorState());
    });
  }

  List departmentList = [];
  late Map finalDepartments;
  late List<String> departmentsNameList = [];
  late List departmentsIdList = [];
  void getDepartments() {
    emit(GetDepartmentsListLoadingState());
    DioHelper.getHttp(
      url: departments,
    ).then((value) {
      departmentList = value.data;
      departmentsNameList = departmentList
          .map((element) => element['departmentName'].toString())
          .toList();
      departmentsIdList =
          departmentList.map((element) => element['id']).toList();
      finalDepartments =
          Map.fromIterables(departmentsNameList, departmentsIdList);
      print(finalDepartments);
      emit(GetDepartmentsListSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDepartmentsListErrorState());
    });
  }

  void addEmployee({
    int? id,
    required String fullName,
    required String phoneNumber,
    required String birthDate,
    required String department,
    required String position,
    required List wokringDays,
    required String gender,
    required workingDays,
    required imageFile,
    required var salary,
  }) {
    emit(AddEmployeeLoadingState());
    DioHelper.postHttp(
      url: employeeAdd,
      data: {
        'user': {
          'fullName': fullName,
          'birthDate': birthDate,
          'gender': gender,
          'salary': salary,
        },
        //     'avatar': imageFile,
        'employee': {
          'phoneNumber': phoneNumber,
          'workdays': wokringDays,
          'department': finalDepartments['$department'],
          'positions': finalPositions['$position'],
        }
      },
    ).then((value) {
      addEmployeeModel = AddEmployeeModel.fromJson(value.data);
      addedEmployeeDetails = value.data;
      print(value.data);
      print(addedEmployeeDetails);
      print(addedEmployeeDetails['data']);
      emit(AddEmployeeSuccessState(addEmployeeModel));

      Get.offAllNamed(AppRoute.employeeAddedSuccessfully,
          arguments: addedEmployeeDetails);
    }).catchError((error) {
      emit(AddEmployeeErrorState(error));
    });
  }
}
