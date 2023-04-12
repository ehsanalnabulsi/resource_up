import 'package:get/get.dart';

import '../../View/Admin/EmployeeManagment/AddEmployee/add_employee.dart';
import '../../View/Admin/EmployeeManagment/AddEmployee/employee_added_successfully.dart';
import '../../View/Admin/EmployeeManagment/employee_page.dart';
import '../../View/Admin/EmployeeManagment/employeesAttendance/employees_attendance.dart';
import '../../View/Admin/EmployeeManagment/employeesList/dep_pos_employees.dart';
import '../../View/Admin/EmployeeManagment/employeesList/employee_page_department.dart';
import '../../View/Admin/EmployeeManagment/employeesList/employees_list.dart';
import '../../View/Admin/LeavesManagment/leaves_list.dart';
import '../../View/Admin/Main/admin_main_page.dart';
import '../../View/Admin/Main/admin_home_page.dart';
import '../../View/Admin/PayrollsManagment/SalarySheet/salary_sheet.dart';
import '../../View/Shared/Attendance/attendance.dart';
import '../../View/Shared/Authentication/login.dart';
import '../../View/Shared/Authentication/register/register.dart';
import '../../View/Shared/Authentication/register/register_company.dart';
import '../../View/Shared/Authentication/register/success_register.dart';
import '../../View/Shared/Authentication/resetPassowrd/reset_password.dart';
import '../../View/Shared/Onboarding/onboarding.dart';
import '../../View/User/main/user_main_page.dart';
import '../../View/User/requests/apply_request.dart';

class AppRoute {
  //            Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String registerCompany = '/register_company';
  static const String successRegister = '/success_register';
  static const String verifyCodeSignUp = '/verifyCodeSignUp';
  static const String forgetPassword = '/forgetPassword';
  static const String verifyCode = '/verifyCode';
  static const String resetPassword = '/resetPassword';
  static const String successResetPassword = '/successResetPassword';
  //            onBoarding
  static const String onBoarding = '/onboarding';
  //            shared
  static const String attendance = '/attendance';
//              Admin Routes
  static const String adminMainPage = '/admin_main_page';
  static const String adminHomePage = '/admin_home_page';
  static const String employeeManagmentPage = '/employeeManagmentPage';
  static const String addEmployee = '/add_employee';
  static const String profilePage = '/profilepage';
  static const String employees = '/employees';
  static const String employeePage = '/employeePage';
  static const String employeeDepartmentPage = '/employee_department_page';
  static const String departments = '/departmentsPage';
  static const String employeeAddedSuccessfully =
      '/employee_added_successfully';
  static const String employeesAttendance = '/employees_attendance';
  static const String leavesList = '/leaves_list';
  static const String salarySheet = '/salary_sheet';
  static const String departmentEmployees = '/dep_pos_employees';
  static const String positionEmployees = '/position_employees';
  //            User Routes
  static const String userMainPage = '/user_main_page';
  static const String applyRequest = '/apply_request';
}

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoute.login, page: () => const LogIn()),
  GetPage(name: AppRoute.register, page: () => const Register()),
  GetPage(name: AppRoute.registerCompany, page: () => const RegisterCompany()),
  GetPage(name: AppRoute.successRegister, page: () => const SuccessRegister()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),
  GetPage(name: AppRoute.adminMainPage, page: () => const AdminMainPage()),
  GetPage(name: AppRoute.adminHomePage, page: () => const AdminHomePage()),
  GetPage(name: AppRoute.attendance, page: () => const Attendance()),
  GetPage(name: AppRoute.salarySheet, page: () => const SalarySheet()),
  GetPage(name: AppRoute.userMainPage, page: () => const UserMainPage()),
  GetPage(name: AppRoute.applyRequest, page: () => const ApplyRequest()),
  GetPage(name: AppRoute.employees, page: () => const Employees()),
  GetPage(
      name: AppRoute.employeeDepartmentPage,
      page: () => const EmployeeDepartmentPage()),
  GetPage(
      name: AppRoute.departmentEmployees,
      page: () => const DepartmentEmployees()),
  //GetPage(name: AppRoute.positionEmployees, page: () => const Employees()),
  GetPage(
      name: AppRoute.employeesAttendance,
      page: () => const EmployeesAttendance()),
  GetPage(name: AppRoute.leavesList, page: () => const LeavesList()),
  GetPage(name: AppRoute.employeePage, page: () => const EmployeePage()),
  GetPage(name: AppRoute.addEmployee, page: () => const AddEmployee()),
  GetPage(
      name: AppRoute.employeeAddedSuccessfully,
      page: () => const EmployeeAddedSuccessfully()),
  GetPage(
      name: AppRoute.employeeAddedSuccessfully,
      page: () => const EmployeeAddedSuccessfully()),
];
