import 'dart:convert';
import 'dart:math';
import 'package:bd_erp/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:bd_erp/models/login_data_model.dart';
import 'package:bd_erp/static/network/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

class AuthRepository {
  LoginDataModel? dataModel;
  UserModel? user;
  Future<Either<LoginDataModel, String>> login(
      String username, String password) async {
    try {
      final res = await http.post(Uri.parse(Urls.login),
          body: "grant_type=password&username=$username&password=$password");
      if (res.statusCode == 200) {
        final jsonData = jsonDecode(res.body);
        dataModel = LoginDataModel.fromJson(jsonData);
        return Left(dataModel!);
      } else {
        return Right(res.statusCode.toString());
      }
    } catch (err) {
      return Right(err.toString());
    }
  }

  Future<UserModel> getUser(LoginDataModel login) async {
    final res = await http.get(
        Uri.parse(Urls.userDetais + login.xUserId + Urls.vv),
        headers: {'Authorization': "Bearer ${login.accessToken}"});
    user = UserModel.fromJson(jsonDecode(res.body));
    // print(user!.toJson()); 
    return user!;
  }
}
