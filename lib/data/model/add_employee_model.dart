import 'package:resource_up/data/model/user_model.dart';

class AddEmployeeModel {
  bool? status;
  String? message;
  User? data;

  AddEmployeeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }
}
