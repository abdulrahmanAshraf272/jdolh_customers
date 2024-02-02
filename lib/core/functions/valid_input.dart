import 'package:get/get.dart';

validInput(String val, int min, int max, [String type = '']) {
  if (val.isEmpty) {
    return "input can't be empty";
  }
  if (type == 'username') {
    if (!GetUtils.isUsername(val)) {
      return 'not valid username.';
    }
  }
  if (type == 'email') {
    if (!GetUtils.isEmail(val)) {
      return 'not valid email.';
    }
  }

  if (type == 'phone') {
    if (!GetUtils.isPhoneNumber(val)) {
      return 'not valid phone number.';
    }
  }

  if (val.length < min) {
    return "input can't be less than $min";
  }

  if (val.length > max) {
    return "input can't be longer than $max";
  }
}
