import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class OccasionsData {
  Crud crud;
  OccasionsData(this.crud);

  createOccasion(
    String myId,
    String myName,
    String occasionTitle,
    String date,
    String time,
    String occasionLocation,
    String lat,
    String long,
    String locationLink,
  ) async {
    var response = await crud.postData(ApiLinks.createOccasion, {
      "myId": myId,
      "myName": myName,
      "title": occasionTitle,
      "date": date,
      "time": time,
      "location": occasionLocation,
      "lat": lat,
      "long": long,
      "locationLink": locationLink,
    });

    return response.fold((l) => l, (r) => r);
  }

  editOccasion(
      String occasionId,
      String occasionTitle,
      String date,
      String time,
      String occasionLocation,
      String lat,
      String long,
      String locationLink) async {
    var response = await crud.postData(ApiLinks.editOccasion, {
      "occasionId": occasionId,
      "title": occasionTitle,
      "date": date,
      "time": time,
      "location": occasionLocation,
      "lat": lat,
      "long": long,
      "locationLink": locationLink
    });

    return response.fold((l) => l, (r) => r);
  }

  deleteOccasion(String occasionId) async {
    var response = await crud.postData(ApiLinks.deleteOccasion, {
      "occasionId": occasionId,
    });

    return response.fold((l) => l, (r) => r);
  }

  addMember(
      {required String occasionid,
      required String userid,
      required String creatorid}) async {
    var response = await crud.postData(ApiLinks.addOccasionMember,
        {"occasionid": occasionid, "userid": userid, "creatorid": creatorid});

    return response.fold((l) => l, (r) => r);
  }

  deleteMember(String occasionId, String userId) async {
    var response = await crud.postData(ApiLinks.deleteOccasionInvitor, {
      "occasionId": occasionId,
      "userId": userId,
    });

    return response.fold((l) => l, (r) => r);
  }

  responedToInvitation(
      {required String userId,
      required String occasionId,
      required String respond,
      required String excuse}) async {
    var response = await crud.postData(ApiLinks.responedToInvitation, {
      "occasionId": occasionId,
      "userId": userId,
      "respond": respond,
      "excuse": excuse
    });

    return response.fold((l) => l, (r) => r);
  }

  viewOccasions(String userId) async {
    var response =
        await crud.postData(ApiLinks.viewOccasion, {"userId": userId});

    return response.fold((l) => l, (r) => r);
  }

  viewInvitors(String occasionId) async {
    var response = await crud
        .postData(ApiLinks.viewOccasionInvitors, {"occasionId": occasionId});

    return response.fold((l) => l, (r) => r);
  }

  clearMembers(String creatorid) async {
    var response = await crud
        .postData(ApiLinks.clearMemberOccasion, {"creatorid": creatorid});

    return response.fold((l) => l, (r) => r);
  }
}
