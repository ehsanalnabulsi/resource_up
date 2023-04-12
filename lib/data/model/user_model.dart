class UserModel {
  bool? status;
  dynamic message;
  User? data;

  // UserModel({this.status, this.message, this.data}) {}

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }
}

class User {
  int? id;
  bool? isHr;
  String? fullName;
  String? password;
  String? address;
  String? phoneNumber;
  String? email;
  String? refresh;
  String? access;
  String? username;
  String? avatar;
  String? birthDate;
  String? gender;
  String? position;
  String? department;
  List<AttendanceModel>? attendance;
  Payroll? payroll;

  User({
    this.id,
    this.isHr,
    this.fullName,
    this.address,
    this.phoneNumber,
    this.password,
    this.email,
    this.refresh,
    this.access,
    this.username,
    this.avatar,
    this.birthDate,
    this.gender,
    this.position,
    this.department,
    this.attendance,
    this.payroll,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isHr = json['isHr'];
    fullName = json['fullName'];
    password = json['password'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    refresh = json['refresh'];
    access = json['access'];
    username = json['username'];
    avatar = json['avatar'];
    birthDate = json['birthDate'];
    gender = json['gender'];
    position = json['position'];
    department = json['department'];
    attendance = json['attendance'];
    payroll = json['payroll'];
  }
}

class AttendanceModel {
  String? status;
  DateTime? date;
  DateTime? clockInTime;
  DateTime? clockOutTime;

  AttendanceModel({
    this.status,
    this.date,
    this.clockInTime,
    this.clockOutTime,
  });
}

class Payroll {
  double? baseSalary;
  double? deductions;
  double? bonuses;

  Payroll({
    this.baseSalary,
    this.deductions,
    this.bonuses,
  });
}
