import 'dart:convert';

import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';
import 'package:jdolh_customers/data/models/reservation_invitors.dart';

class ResData {
  Crud crud;
  ResData(this.crud);

  createRes(
      {required String userid,
      required String bchid,
      required String brandid,
      required String date,
      required String time,
      required String duration,
      required String price,
      required String resCost,
      required String taxCost,
      required String totalPrice,
      required String billPolicy,
      required String resPolicy,
      required String isHomeService,
      required String withInvitores,
      required String resOption,
      required String status}) async {
    var response = await crud.postData(ApiLinks.createRes, {
      "userid": userid,
      "bchid": bchid,
      "brandid": brandid,
      "date": date,
      "time": time,
      "duration": duration,
      "price": price,
      "resCost": resCost,
      "taxCost": taxCost,
      "totalPrice": totalPrice,
      "billPolicy": billPolicy,
      "resPolicy": resPolicy,
      "isHomeService": isHomeService,
      "withInvitores": withInvitores,
      "resOption": resOption,
      "status": status
    });

    return response.fold((l) => l, (r) => r);
  }

  addResLocation(
      {required String resid,
      required String userid,
      required String location,
      required String lat,
      required String lng,
      required String hood,
      required String street,
      required String building,
      required String floor,
      required String apartment}) async {
    var response = await crud.postData(ApiLinks.addResLocation, {
      "resid": resid,
      "userid": userid,
      "location": location,
      "lat": lat,
      "lng": lng,
      "hood": hood,
      "street": street,
      "building": building,
      "floor": floor,
      "apartment": apartment,
    });

    return response.fold((l) => l, (r) => r);
  }

  getRes({
    required String resid,
  }) async {
    var response = await crud.postData(ApiLinks.getRes, {
      "resid": resid,
    });

    return response.fold((l) => l, (r) => r);
  }

  getReservedTime({required String bchid, required String resOption}) async {
    var response = await crud.postData(
        ApiLinks.getReservedTime, {"bchid": bchid, "resOption": resOption});

    return response.fold((l) => l, (r) => r);
  }

  getPolicyTitle(
      {required String resPolicyid, required String billPolicyid}) async {
    var response = await crud.postData(ApiLinks.getPolicyTitle,
        {"resPolicyid": resPolicyid, "billPolicyid": billPolicyid});

    return response.fold((l) => l, (r) => r);
  }

  changeResStatus(
      {required String resid,
      required String status,
      required String rejectionReason}) async {
    var response = await crud.postData(ApiLinks.changeResStatus,
        {"resid": resid, "status": status, "rejectionReason": rejectionReason});

    return response.fold((l) => l, (r) => r);
  }

  getAllMyRes({required String userid}) async {
    var response =
        await crud.postData(ApiLinks.getAllMyRes, {"userid": userid});

    return response.fold((l) => l, (r) => r);
  }

  getResCart({required String resid}) async {
    var response = await crud.postData(ApiLinks.getResCart, {"resid": resid});

    return response.fold((l) => l, (r) => r);
  }

  sendInvitations(List<Resinvitors> invitations) async {
    var response =
        await crud.sendInvitations(ApiLinks.sendInvitations, invitations);

    return response.fold((l) => l, (r) => r);
  }
}
