import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resource_up/core/services/local/cache_helper.dart';
import 'package:resource_up/data/model/grid_view_model.dart';
import 'package:resource_up/data/model/list_view_model.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/routes.dart';
import '../../model/leaves_model.dart';
import '../../model/onboarding_model.dart';
import '../../model/salary_model.dart';
import '../../model/user_model.dart';

List<OnBoardingModel> onBoardingList = [
  // 1
  OnBoardingModel(
      title: "Transform Your HR",
      body: "A new way to manage human re-\nsources and streamline processes.",
      image: ImageAsset.onboarding1),
  // 2
  OnBoardingModel(
      title: "Features Overview",
      body:
          "Discover the features thatmake\nResource UP a powerful solution\nfor your organization.",
      image: ImageAsset.onboarding2),
  // 3
  OnBoardingModel(
      title: "Let's Get Started",
      body:
          "Join the thousands of companies\nwho are already using HRMS\nto improve employee experiences.",
      image: ImageAsset.onboarding3),
];
List userHomePageCard = [
  HomePageGridView(
      title: 'Working', number: 15, color: AppColor.dashboardColor6),
  HomePageGridView(title: 'Absent', number: 4, color: AppColor.dashboardColor3),
  HomePageGridView(title: 'Late', number: 2, color: AppColor.dashboardColor4),
];

List<ListViewModel> profileListView = [
  ListViewModel(
    title: 'Remaining Vacations',
    subtitle: 'Track your vacations',
    leading: const Icon(Icons.umbrella_outlined),
    color: AppColor.dashboardColor6,
    route: AppRoute.addEmployee,
  ),
  ListViewModel(
    title: 'Notifications',
    subtitle: 'Control app notifications',
    leading: const Icon(Icons.notifications_none_outlined),
    color: AppColor.dashboardColor4,
    route: AppRoute.addEmployee,
  ),
  ListViewModel(
    title: 'Security Settings',
    subtitle: 'Change account Password',
    leading: const Icon(Icons.security_outlined),
    color: AppColor.dashboardColor2,
    route: AppRoute.addEmployee,
  ),
  ListViewModel(
      title: 'Sign Out',
      subtitle: '',
      leading: const Icon(Icons.logout_outlined),
      color: AppColor.greyColor3,
      route: AppRoute.login,
      onTap: () {
        // DioHelper.postHttp(url: logout, data: {}).then((value) {
        CacheHelper.deleteData(key: 'isHr');
        CacheHelper.deleteData(key: 'token');
        Get.toNamed(AppRoute.login);
      }
      //   ).catchError((error) => print(error.toString()));
      // },
      ),
  ListViewModel(
    title: 'App Language',
    subtitle: '',
    leading: const Icon(Icons.language_outlined),
    color: AppColor.dashboardColor3,
    route: AppRoute.login,
  ),
];
List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];
List<String> industries = [
  'Agriculture',
  'Automotive',
  'Banking and Finance',
  'Construction',
  'Consumer Goods',
  'Education',
  'Energy',
  'Healthcare',
  'Information Technology',
  'Manufacturing',
  'Media and Entertainment',
  'Retail',
  'Telecommunications',
  'Transportation and Logistics',
  'Travel and Tourism',
  'Real Estate',
  'Pharmaceuticals',
  'Food and Beverage',
  'Insurance',
  'E-commerce',
  'Other'
];

List<ListTile> employeeManagmentTiles = [
  ListTile(
      leading: const Icon(Icons.add, size: 36.0, color: AppColor.greyColor3),
      title: const Text('Add New Employee'),
      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 16.0),
      onTap: () => Get.toNamed(AppRoute.addEmployee)),
  ListTile(
      leading: const Icon(Icons.list_outlined,
          size: 36.0, color: AppColor.greyColor3),
      title: const Text('Employees List'),
      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 16.0),
      onTap: () => Get.toNamed(AppRoute.employees)),
  ListTile(
      leading: const Icon(Icons.timer_outlined,
          size: 36.0, color: AppColor.greyColor3),
      title: const Text('Employees Attendance'),
      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 16.0),
      onTap: () => Get.toNamed(AppRoute.employeesAttendance)),
];
List<ListTile> payrollsManagmentTiles = [
  ListTile(
      leading: const Icon(Icons.table_chart_outlined,
          size: 36.0, color: AppColor.greyColor3),
      title: const Text('Salary Sheet'),
      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 16.0),
      onTap: () => Get.toNamed(AppRoute.salarySheet)),
];
List<ListTile> requeststManagmentTiles = [
  ListTile(
      leading: const Icon(Icons.timer, size: 36.0, color: AppColor.greyColor3),
      title: const Text('Leave Request'),
      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 16.0),
      onTap: () => Get.toNamed(AppRoute.leavesList)),
  ListTile(
      leading: const Icon(Icons.payment_outlined,
          size: 36.0, color: AppColor.greyColor3),
      title: const Text('Prepayement Request'),
      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 16.0),
      onTap: () => Get.toNamed(AppRoute.employees)),
];
List<ListTile> recruitmentManagmentTiles = [
  ListTile(
      leading: const Icon(Icons.vaccines_outlined,
          size: 36.0, color: AppColor.greyColor3),
      title: const Text('Add Vacancie'),
      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 16.0),
      onTap: () => Get.toNamed(AppRoute.employees)),
  ListTile(
      leading: const Icon(
        Icons.list_outlined,
        size: 36.0,
        color: AppColor.greyColor3,
      ),
      title: const Text(
        'Employees List',
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_outlined,
        size: 16.0,
      ),
      onTap: () => Get.toNamed(AppRoute.employees)),
];
List<ListTile> filesManagmentTiles = [
  ListTile(
      leading: const Icon(
        Icons.group_outlined,
        size: 36.0,
        color: AppColor.greyColor3,
      ),
      title: const Text(
        'Add New Employee',
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_outlined,
        size: 16.0,
      ),
      onTap: () => Get.toNamed(AppRoute.employees)),
  ListTile(
      leading: const Icon(
        Icons.list_outlined,
        size: 36.0,
        color: AppColor.greyColor3,
      ),
      title: const Text(
        'Employees List',
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_outlined,
        size: 16.0,
      ),
      onTap: () => Get.toNamed(AppRoute.employees)),
  ListTile(
      leading: const Icon(
        Icons.timer_outlined,
        size: 36.0,
        color: AppColor.greyColor3,
      ),
      title: const Text(
        'Employees Attendance',
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_outlined,
        size: 16.0,
      ),
      onTap: () => Get.toNamed(AppRoute.employees)),
];
List<User> fakeUsers = [
  User(
    id: 1,
    fullName: 'John Smith',
    address: '123 Main St, Anytown USA',
    phoneNumber: '555-1234',
    email: 'john.smith@example.com',
    access: 'abc123',
    username: 'jsmith',
    avatar: 'https://picsum.photos/200',
    birthDate: '01/01/1990',
    gender: 'Male',
    position: 'Manager',
    department: 'Sales',
    attendance: [
      AttendanceModel(
        status: 'Present',
        date: DateTime.parse('2022-02-01'),
        clockInTime: DateTime.parse('2022-02-01 08:00:00'),
        clockOutTime: DateTime.parse('2022-02-01 17:00:00'),
      ),
      AttendanceModel(
        status: 'Present',
        date: DateTime.parse('2022-02-02'),
        clockInTime: DateTime.parse('2022-02-02 08:00:00'),
        clockOutTime: DateTime.parse('2022-02-02 17:00:00'),
      ),
    ],
    payroll: Payroll(
      baseSalary: 5000.0,
      deductions: 1000.0,
      bonuses: 1500.0,
    ),
  ),
  User(
    id: 2,
    fullName: 'Jane Doe',
    address: '456 High St, Anytown USA',
    phoneNumber: '555-5678',
    email: 'jane.doe@example.com',
    access: 'def456',
    username: 'jdoe',
    avatar: 'https://picsum.photos/200',
    birthDate: '02/14/1995',
    gender: 'Female',
    position: 'Engineer',
    department: 'Engineering',
    attendance: [
      AttendanceModel(
        status: 'Present',
        date: DateTime.parse('2022-02-01'),
        clockInTime: DateTime.parse('2022-02-01 09:00:00'),
        clockOutTime: DateTime.parse('2022-02-01 18:00:00'),
      ),
      AttendanceModel(
        status: 'Present',
        date: DateTime.parse('2022-02-02'),
        clockInTime: DateTime.parse('2022-02-02 09:00:00'),
        clockOutTime: DateTime.parse('2022-02-02 18:00:00'),
      ),
    ],
    payroll: Payroll(
      baseSalary: 6000.0,
      deductions: 1200.0,
      bonuses: 2000.0,
    ),
  ),
  // add more fake user data here
];

List<Leave> fakeLeaves = [
  Leave(
    id: 1,
    startDate: DateTime(2022, 3, 1),
    endDate: DateTime(2022, 3, 3),
    type: LeaveType.sick.name,
    status: Status.pending,
    notes: 'Sick leave due to flu',
    employee: User(
      id: 1,
      fullName: 'John Smith',
      address: '123 Main St, Anytown USA',
      phoneNumber: '555-555-1234',
      email: 'john.smith@example.com',
      access: '',
      username: 'johnsmith',
      avatar: '',
      birthDate: '1990-01-01',
      gender: 'Male',
      position: 'Software Engineer',
      department: 'Engineering',
      attendance: [],
      payroll: Payroll(
        baseSalary: 80000,
        deductions: 2000,
        bonuses: 5000,
      ),
    ),
  ),
  Leave(
    id: 2,
    startDate: DateTime(2022, 4, 15),
    endDate: DateTime(2022, 4, 19),
    type: LeaveType.annual.name,
    status: Status.pending,
    notes: 'Vacation time with family',
    employee: User(
      id: 2,
      fullName: 'Jane Doe',
      address: '456 Oak St, Anytown USA',
      phoneNumber: '555-555-5678',
      email: 'jane.doe@example.com',
      access: '',
      username: 'janedoe',
      avatar: '',
      birthDate: '1995-05-01',
      gender: 'Female',
      position: 'Marketing Manager',
      department: 'Marketing',
      attendance: [],
      payroll: Payroll(
        baseSalary: 90000,
        deductions: 2500,
        bonuses: 7500,
      ),
    ),
  ),
  Leave(
    id: 3,
    startDate: DateTime(2022, 6, 7),
    endDate: DateTime(2022, 6, 7),
    type: LeaveType.personal.name,
    status: Status.pending,
    notes: 'Personal day off',
    employee: User(
      id: 3,
      fullName: 'Bob Johnson',
      address: '789 Elm St, Anytown USA',
      phoneNumber: '555-555-9012',
      email: 'bob.johnson@example.com',
      access: '',
      username: 'bobjohnson',
      avatar: '',
      birthDate: '1985-09-15',
      gender: 'Male',
      position: 'Human Resources Specialist',
      department: 'Human Resources',
      attendance: [],
      payroll: Payroll(
        baseSalary: 70000,
        deductions: 1500,
        bonuses: 4000,
      ),
    ),
  ),
];

final List<SalaryModel> salarySheetData = [
  SalaryModel(
    employeeName: 'John Doe',
    baseSalary: 5000,
    bonuses: 1000,
    deductions: 500,
    totalSalary: 5500,
  ),
  SalaryModel(
    employeeName: 'Jane Smith',
    baseSalary: 4000,
    bonuses: 500,
    deductions: 200,
    totalSalary: 4300,
  ),
  SalaryModel(
    employeeName: 'Bob Johnson',
    baseSalary: 6000,
    bonuses: 2000,
    deductions: 1000,
    totalSalary: 7000,
  ),
  SalaryModel(
    employeeName: 'Alice Lee',
    baseSalary: 4500,
    bonuses: 1500,
    deductions: 500,
    totalSalary: 5500,
  ),
  SalaryModel(
    employeeName: 'Mike Chen',
    baseSalary: 5500,
    bonuses: 1000,
    deductions: 1000,
    totalSalary: 5500,
  ),
];
