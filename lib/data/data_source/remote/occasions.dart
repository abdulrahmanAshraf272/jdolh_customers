import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class OccasionsData {
  Crud crud;
  OccasionsData(this.crud);

  createOccasion(
      String myId,
      String myName,
      String occasionTitle,
      String occasionDate,
      String occasionLocation,
      String lat,
      String long,
      String locationLink,
      String invitors) async {
    var response = await crud.postData(ApiLinks.createOccasion, {
      "myId": myId,
      "myName": myName,
      "title": occasionTitle,
      "datetime": occasionDate,
      "location": occasionLocation,
      "lat": lat,
      "long": long,
      "locationLink": locationLink,
      "invitors": invitors,
    });

    return response.fold((l) => l, (r) => r);
  }

  editOccasion(
      String occasionId,
      String occasionTitle,
      String occasionDate,
      String occasionLocation,
      String lat,
      String long,
      String locationLink) async {
    var response = await crud.postData(ApiLinks.editOccasion, {
      "occasionId": occasionId,
      "title": occasionTitle,
      "date": occasionDate,
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

  addToOccasion(String occasionId, String invitorsID) async {
    var response = await crud.postData(ApiLinks.addToOccasion, {
      "occasionId": occasionId,
      "invitorsID": invitorsID,
    });

    return response.fold((l) => l, (r) => r);
  }

  deleteInvitors(String occasionId, String userId) async {
    var response = await crud.postData(ApiLinks.deleteOccasionInvitor, {
      "occasionId": occasionId,
      "userId": userId,
    });

    return response.fold((l) => l, (r) => r);
  }

  acceptInvitation(String userId, String occasionId) async {
    var response = await crud.postData(ApiLinks.acceptOccasion, {
      "occasionId": occasionId,
      "userId": userId,
    });

    return response.fold((l) => l, (r) => r);
  }

  rejectInvitation(String userId, String occasionId, String excuse,
      String creatorUserId) async {
    var response = await crud.postData(ApiLinks.rejectOccasion, {
      "userId": userId,
      "occasionId": occasionId,
      "excuse": excuse,
      "creatorUserId": creatorUserId
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
}
