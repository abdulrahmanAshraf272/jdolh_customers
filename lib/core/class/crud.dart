// to be able to use Either (functional programming).
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/data/models/reservation_invitors.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkUrl, Map data) async {
    try {
      if (
          //await checkInternet()
          true) {
        var response = await http.post(Uri.parse(linkUrl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postDataWithFile(
      String linkUrl, Map data, File file, String field) async {
    try {
      if (
          //await checkInternet()
          true) {
        var request = http.MultipartRequest("POST", Uri.parse(linkUrl));

        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var multipartFile = http.MultipartFile(field, stream, length,
            filename: basename(file.path));
        request.files.add(multipartFile);
        data.forEach((key, value) {
          request.fields[key] = value;
        });
        var myrequest = await request.send();

        var response = await http.Response.fromStream(myrequest);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String linkUrl) async {
    try {
      if (
          //await checkInternet()
          true) {
        var response = await http.get(Uri.parse(linkUrl));
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> sendInvitations(
      String linkUrl, List<Resinvitors> invitations) async {
    final List<Map<String, dynamic>> invitationJsonList =
        invitations.map((invitation) => invitation.toJson()).toList();
    final body = jsonEncode(invitationJsonList);

    try {
      if (
          //await checkInternet()
          true) {
        var response = await http.post(Uri.parse(linkUrl), body: body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }
}
