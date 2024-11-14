import 'package:bd_erp/locator.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String theme = 'auto';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = locator<AppThemes>().themeString;
  }

  @override
  Widget build(BuildContext context) {
    print(theme);
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppThemes.highlightYellow),
                child: Text('Login'))
          ],
        ),
      )),
    );
  }
}
