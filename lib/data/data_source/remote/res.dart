import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class ResData {
  Crud crud;
  ResData(this.crud);

  changeHoldStatus({required String resid, required String status}) async {
    var response = await crud.postData(
        ApiLinks.changeHoldStatus, {"resid": resid, "status": status});

    return response.fold((l) => l, (r) => r);
  }

  deleteReservation({required String resid}) async {
    var response = await crud.postData(ApiLinks.deleteRes, {
      "resid": resid,
    });

    return response.fold((l) => l, (r) => r);
  }

  respondInvitations(
      {required String resid,
      required String userid,
      required String status}) async {
    var response = await crud.postData(ApiLinks.respondInvitation,
        {"resid": resid, "userid": userid, "status": status});

    return response.fold((l) => l, (r) => r);
  }

  getInvitors({required String resid}) async {
    var response = await crud.postData(ApiLinks.getInvitors, {
      "resid": resid,
    });

    return response.fold((l) => l, (r) => r);
  }

  sendInvitation(
      {required String resid,
      required String userid,
      required String creatorid,
      required String type,
      required String cost}) async {
    var response = await crud.postData(ApiLinks.sendInvitations, {
      "resid": resid,
      "userid": userid,
      "creatorid": creatorid,
      "type": type,
      "cost": cost
    });

    return response.fold((l) => l, (r) => r);
  }

  createRes(
      {required String userid,
      required String bchid,
      required String brandid,
      required String date,
      required String time,
      required String duration,
      required String billCost,
      required String billTax,
      required String resCost,
      required String resTax,
      required String totalPrice,
      required String billPolicy,
      required String resPolicy,
      required String isHomeService,
      required String withInvitores,
      required String resOption,
      required String status,
      required String paymentType,
      String extraSeats = '0',
      String creatorCost = '0'}) async {
    var response = await crud.postData(ApiLinks.createRes, {
      "userid": userid,
      "bchid": bchid,
      "brandid": brandid,
      "date": date,
      "time": time,
      "duration": duration,
      "billCost": billCost,
      "billTax": billTax,
      "resCost": resCost,
      "resTax": resTax,
      "totalPrice": totalPrice,
      "billPolicy": billPolicy,
      "resPolicy": resPolicy,
      "isHomeService": isHomeService,
      "withInvitores": withInvitores,
      "resOption": resOption,
      "status": status,
      "paymentType": paymentType,
      "extraSeats": extraSeats,
      "creatorCost": creatorCost
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
}
