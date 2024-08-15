import 'package:get/get.dart';

validInput(String val, int min, int max, [String type = '']) {
  if (val.isEmpty) {
    return "الحقل فارغ!".tr;
  }
  if (type == 'username') {
    if (!GetUtils.isUsername(val)) {
      return 'اسم مستخدم غير صالح, مثال"ahmed_ali22'.tr;
    }
  }
  if (type == 'email') {
    if (!GetUtils.isEmail(val)) {
      return 'بريد الكتروني غير صالح'.tr;
    }
  }

  if (type == 'phone') {
    if (!GetUtils.isPhoneNumber(val)) {
      return 'رقم هاتف غير صالح'.tr;
    }
  }

  if (val.length < min) {
    return "لا يمكن ان تكون البيانات اقل من خانتين".tr;
  }

  if (val.length > max) {
    return "لا يمكن ان تكون البيانات اكبر من 100 خانه".tr;
  }
}

String? firstNameValidInput(String value) {
  if (value.isEmpty) {
    return "الحقل فارغ!".tr;
  } else if (value.length < 2) {
    return 'لا يمكن ان يكون الاسم اصغر من حرفين'.tr;
  } else if (value.length > 60) {
    return 'لا يمكن ان يكون الاسم اكبر من 60 حرف'.tr;
  } else if (value.contains(' ')) {
    return 'غير مسموح بوجود فراغات في الاسم الاول واسم العائلة'.tr;
  }
  return null;
}

validInputUsername(String val, int min, int max) {
  if (val.isEmpty) {
    return "الحقل فارغ!".tr;
  }

  if (!GetUtils.isUsername(val)) {
    return 'اسم مستخدم غير صالح, مثال"ahmed_ali22'.tr;
  }

  if (val.length < min) {
    return "لا يمكن ان يكون اسم المستخدم اقل من $min خانات";
  }

  if (val.length > max) {
    return "لا يمكن ان يكون اسم المستخدم اكبر من $min خانات";
  }
}
