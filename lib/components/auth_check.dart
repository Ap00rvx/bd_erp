import 'package:bd_erp/components/home.dart';
import 'package:bd_erp/components/spin_indicator.dart';
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

class _AuthCheckState extends State<AuthCheck> {
  late Future<List<String>> _futureCreds;

  @override
  void initState() {
    super.initState();
    // Initialize the Future once
    _futureCreds = getCreds();
  }

  Future<List<String>> getCreds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString("username") ?? "";
      final String pass = prefs.getString("password") ?? "";
      return [username, pass];
    } catch (e) {
      // Handle any errors that might occur during SharedPreferences access
      return ["", ""];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _futureCreds,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinIndicator();
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: AppThemes.white,
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data[0] != "" && data[1] != "") {
            return FetchHome(name: data[0], pass: data[1]);
          } else {
            return const LoginPage();
          }
        } else {
          return const LoginPage();
        }
      },
    );
  }
}