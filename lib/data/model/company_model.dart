class CompanyModel {
  bool? status;
  String? message;
  Company? data;

  CompanyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Company.fromJson(json['data']) : null;
  }
}

class Company {
  String? companyName;
  int? companyID;
  String? address;
  String? phone;
  String? email;
  String? industryType;
  String? companyLogo;
  String? establishedDate;
  String? website;
  String? startTime;
  String? endTime;
  int? departmentCount;
  int? positionCount;
  int? employeeCount;

  Company({
    this.companyName,
    this.companyID,
    this.address,
    this.phone,
    this.email,
    this.industryType,
    this.companyLogo,
    this.establishedDate,
    this.website,
  });

  Company.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    companyID = json['id'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    industryType = json['industryType'];
    companyLogo = json['companyLogo'];
    establishedDate = json['establishedDate'];
    website = json['website'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    departmentCount = json['departmentCount'];
    positionCount = json['positionCount'];
    employeeCount = json['employeeCount'];
  }
}
