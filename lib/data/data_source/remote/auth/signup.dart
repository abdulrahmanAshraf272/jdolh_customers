import 'dart:io';

import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class SignupData {
  Crud crud;
  SignupData(this.crud);
  deleteAccount({
    required String email,
  }) async {
    var response = await crud.postData(ApiLinks.deleteAccount, {
      "email": email,
    });

    return response.fold((l) => l, (r) => r);
  }

  postData(String name, String username, String password, String email,
      String phone, String gender, String city, File? file) async {
    if (file == null) {
      var response = await crud.postData(ApiLinks.signUp, {
        "name": name,
        "username": username,
        "password": password,
        "email": email,
        "phone": phone,
        "gender": gender,
        "city": city,
      });
      return response.fold((l) => l, (r) => r);
    } else {
      var response = await crud.postDataWithFile(
          ApiLinks.signUpWithImage,
          {
            "name": name,
            "username": username,
            "password": password,
            "email": email,
            "phone": phone,
            "gender": gender,
            "city": city,
          },
          file,
          'file');
      return response.fold((l) => l, (r) => r);
    }
  }

  // ======== Edit ===========//
  editPersonalData(
      {required String name,
      required String username,
      required String userid,
      required String email,
      required String phone,
      required String gender,
      required String city,
      required File? file}) async {
    if (file == null) {
      var response = await crud.postData(ApiLinks.editPersonalData, {
        "name": name,
        "username": username,
        "userid": userid,
        "email": email,
        "phone": phone,
        "gender": gender,
        "city": city,
      });
      return response.fold((l) => l, (r) => r);
    } else {
      var response = await crud.postDataWithFile(
          ApiLinks.editPersonalDataWithImage,
          {
            "name": name,
            "username": username,
            "userid": userid,
            "email": email,
            "phone": phone,
            "gender": gender,
            "city": city,
          },
          file,
          'file');
      return response.fold((l) => l, (r) => r);
    }
  }

  getUser(String userid) async {
    var response = await crud.postData(ApiLinks.getUser, {
      "userid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }
}
