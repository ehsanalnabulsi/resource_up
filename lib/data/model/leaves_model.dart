import 'user_model.dart';

class Leave {
  int id;
  DateTime startDate;
  DateTime endDate;
  String type;
  Status status;
  String notes;
  User employee;

  Leave({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.status,
    this.notes = '',
    required this.employee,
  });
}

enum Status { approved, rejected, pending }

enum LeaveType {
  annual,
  sick,
  maternity,
  paternity,
  bereavement,
  personal,
}
