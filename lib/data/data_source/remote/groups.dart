import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class GroupsData {
  Crud crud;
  GroupsData(this.crud);

  createGroup({required String creatorid, required String groupName}) async {
    var response = await crud.postData(ApiLinks.createGroup, {
      "creatorid": creatorid,
      "groupName": groupName,
    });

    return response.fold((l) => l, (r) => r);
  }

  addGroupMemeber(
      {required String groupid,
      required String creatorid,
      required String userid}) async {
    var response = await crud.postData(ApiLinks.addGroupMember,
        {"groupid": groupid, "creatorid": creatorid, "userid": userid});

    return response.fold((l) => l, (r) => r);
  }

  deleteMember({required String groupid, required String userid}) async {
    var response = await crud.postData(ApiLinks.deleteMember, {
      "groupid": groupid,
      "userid": userid,
    });

    return response.fold((l) => l, (r) => r);
  }

  editGroupName({required String groupId, required String newName}) async {
    var response = await crud.postData(ApiLinks.editGroupName, {
      "groupId": groupId,
      "newName": newName,
    });

    return response.fold((l) => l, (r) => r);
  }

  deleteGroup(String groupId) async {
    var response =
        await crud.postData(ApiLinks.deleteGroup, {"groupId": groupId});

    return response.fold((l) => l, (r) => r);
  }

  clearMembers(String creatorid) async {
    var response =
        await crud.postData(ApiLinks.clearMembers, {"creatorid": creatorid});

    return response.fold((l) => l, (r) => r);
  }

  groupsView({required String userId}) async {
    var response = await crud.postData(ApiLinks.groupsView, {"userId": userId});

    return response.fold((l) => l, (r) => r);
  }

  groupMembers(String groupId) async {
    var response =
        await crud.postData(ApiLinks.groupMembers, {"groupId": groupId});

    return response.fold((l) => l, (r) => r);
  }
}
