import 'dart:convert';
import 'dart:developer';
import 'package:bd_erp/features/authentication/repository/auth_rpository.dart';
import 'package:bd_erp/locator.dart';
import 'package:bd_erp/models/login_data_model.dart';
import 'package:bd_erp/models/std_atd_details.dart';
import 'package:bd_erp/static/network/urls.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  Map<String, dynamic>? responseData;
  List<dynamic>? pdpData;
  Future<void> getPdPData(Map<String, String> headers) async {
    final userData = locator.get<AuthRepository>().user!;

    try {
      final res = await http.get(
          Uri.parse(Urls.pdp + userData.admissionNumber + Urls.type),
          headers: headers);
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        pdpData = json;
        print(pdpData);
      } else {
        log(res.statusCode.toString());
      }
    } catch (err) {
      log(err.toString());
    } catch (err) {
      log(err.toString());
    }
  }

  Future<Either<void, String>> getAttendanceData(LoginDataModel data) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${data.accessToken}',
      'Cookie': Urls.cookie,
      'X-Wb': '1',
      'X-Contextid': '194',
      'X-Rx': '1',
      'X-Userid': data.xUserId,
      'X_token': data.xToken,
      'SessionId': data.sessionId
    };
    try {
      await getPdPData(headers);
      final res = await http.get(
          Uri.parse(Urls.attendance + data.xUserId + Urls.vw),
          headers: headers);
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        responseData = json;
        final stdData = json["stdSubAtdDetails"];
        print(stdData);
        return Left(null);
      } else {
        log("Error");
        return Right("Something went wrong :(");
      }
    } catch (err) {
      return Right(err.toString());
    }
  }

  Future<StdSubAtdDetails> gethomeDetails() async {
    if (responseData != null) {
      final stdData =
          StdSubAtdDetails.fromJson(responseData!["stdSubAtdDetails"]);
      return stdData;
    } else {
      await getAttendanceData(locator.get<AuthRepository>().dataModel!);
      final stdData =
          StdSubAtdDetails.fromJson(responseData!["stdSubAtdDetails"]);
      return stdData;
    }
  }
}
