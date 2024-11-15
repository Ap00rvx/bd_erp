import 'package:bd_erp/features/authentication/bloc/auth_bloc.dart';
import 'package:bd_erp/features/authentication/repository/auth_rpository.dart';
import 'package:bd_erp/locator.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final repo = locator.get<AuthRepository>();
    // print(user!.toJson());
    print(repo.dataModel!.toJson()); 
    return Scaffold(
        backgroundColor: AppThemes.white,
        appBar: AppBar(
          title: Text("Welcome"),
        ));
  }
}
