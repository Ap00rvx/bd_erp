import 'package:bd_erp/components/auth_check.dart';
import 'package:bd_erp/features/authentication/bloc/auth_bloc.dart';
import 'package:bd_erp/features/home/bloc/home_bloc.dart';
import 'package:bd_erp/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "nun",
        ),
        home: const AuthCheck(),
      ),
    );
  }
}
