import 'package:resource_up/data/model/user_model.dart';

class LoginModel {
  bool? status;
  dynamic message;
  User? data;

  // LoginModel({this.status, this.message, this.data}) {}

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }
}

class RegisterModel {
  bool? status;
  dynamic message;
  User? data;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }
}

class RegisterCompanyModel {
  bool? status;
  dynamic message;
  User? data;

  RegisterCompanyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }
}
