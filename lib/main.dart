import 'package:bd_erp/features/authentication/pages/login_page.dart';
import 'package:bd_erp/locator.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  AppThemes().setTheme("light");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeData>(
      future: locator<AppThemes>().getThemeData(context),
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: snapshot.data,
            home: const LoginPage(),
          );
        } else {
          return MaterialApp(
            theme: AppThemes.darkTheme,
            home: const LoginPage(),
          );
        }
      },
    );
  }
}
