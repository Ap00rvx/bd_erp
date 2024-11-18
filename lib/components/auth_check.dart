import 'package:bd_erp/components/home.dart';
import 'package:bd_erp/features/authentication/pages/login_page.dart';

import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> with TickerProviderStateMixin {
  Future<List<String>> getCreds() async {
    final prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString("username") ?? "";
    final String pass = prefs.getString("password") ?? "";
    return [username, pass];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCreds(),
        builder: (context, snapshot) {
           if(snapshot.connectionState == ConnectionState.waiting){
            return Scaffold(
             backgroundColor: AppThemes.darkerGrey,
            body: Center(
              child: SpinKitWaveSpinner(
                color: Colors.white,
                size: 50.0,
                controller: AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 1200)),
              ),
            ),
          );
           } 

          else if (snapshot.hasData) {
            final data = snapshot.data!;
            if (data[0] != "" && data[1] != "") 
                return FetchHome(name: data[0],pass: data[1],);
            else 
            return const LoginPage();
          } else {
            return const LoginPage();
          }
        });
  }
}
