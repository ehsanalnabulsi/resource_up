import 'package:get/utils.dart';

validInput(String value, int min, int max, String type) {
  if (value.isEmpty) {
    return 'Must be not empty';
  } else if (type == 'username') {
    if (!GetUtils.isUsername(value)) {
      return 'not valid';
    }
  }
  if (type == 'date') {
    if (!GetUtils.isDateTime(value)) {
      return 'not valid';
    }
  }
  if (type == 'email') {
    if (!GetUtils.isEmail(value)) {
      return 'not valid';
    }
  }
  if (type == 'phonenumber') {
    if (!GetUtils.isPhoneNumber(value)) {
      return 'not valid';
    }
  }

  if (value.length < min) {
    return 'Value cant be less than $min';
  }
  if (value.length > max) {
    return 'Value cant be larger than $max';
  }
}
