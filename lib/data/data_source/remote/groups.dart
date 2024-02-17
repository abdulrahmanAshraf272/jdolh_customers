import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/class/crud.dart';

class GroupsData {
  Crud crud;
  GroupsData(this.crud);

  createGroup(String myId, String groupName, String membersId) async {
    var response = await crud.postData(ApiLinks.createGroup, {
      "myId": myId,
      "groupName": groupName,
      "membersID": membersId,
    });

    return response.fold((l) => l, (r) => r);
  }

  addToGroup(String groupId, String membersId) async {
    var response = await crud.postData(ApiLinks.addToGroup, {
      "groupId": groupId,
      "membersID": membersId,
    });

    return response.fold((l) => l, (r) => r);
  }

  deleteMember(String groupId, String userId) async {
    var response = await crud.postData(ApiLinks.deleteMember, {
      "groupId": groupId,
      "userId": userId,
    });

    return response.fold((l) => l, (r) => r);
  }

  editGroupName(String groupId, String newName) async {
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

  leaveGroup(String userId, String groupId) async {
    var response = await crud.postData(ApiLinks.leaveGroup, {
      "userId": userId,
      "groupId": groupId,
    });

    return response.fold((l) => l, (r) => r);
  }

  groupsView(String userId) async {
    var response = await crud.postData(ApiLinks.groupsView, {"userId": userId});

    return response.fold((l) => l, (r) => r);
  }

  groupMembers(String groupId) async {
    var response =
        await crud.postData(ApiLinks.groupMembers, {"groupId": groupId});

    return response.fold((l) => l, (r) => r);
  }
}
