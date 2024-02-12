import 'package:get/get.dart';

validInput(String val, int min, int max, [String type = '']) {
  if (val.isEmpty) {
    return "الحقل فارغ!";
  }
  if (type == 'username') {
    if (!GetUtils.isUsername(val)) {
      return 'اسم مستخدم غير صالح, مثال":@ahmed.ali44';
    }
  }
  if (type == 'email') {
    if (!GetUtils.isEmail(val)) {
      return 'بريد الكتروني غير صالح';
    }
  }

  if (type == 'phone') {
    if (!GetUtils.isPhoneNumber(val)) {
      return 'رقم هاتف غير صالح';
    }
  }

  if (val.length < min) {
    return "لا يمكن ان تكون البيانات اقل من $min";
  }

  if (val.length > max) {
    return "لا يمكن ان تكون البيانات اكبر من $max";
  }
}
