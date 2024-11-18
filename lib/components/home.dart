import 'package:bd_erp/components/errror_page.dart';
import 'package:bd_erp/features/authentication/bloc/auth_bloc.dart';
import 'package:bd_erp/features/home/page/home_page.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FetchHome extends StatefulWidget {
  const FetchHome({super.key, required this.name, required this.pass});
  final String name;
  final String pass;
  @override
  State<FetchHome> createState() => _FetchHomeState();
}

class _FetchHomeState extends State<FetchHome> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(LoginEvent(widget.name, widget.pass));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
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
        } else if (state is AuthSuccess) {
          return const HomePage();
        } else if (state is AuthFailure)
          return ErrrorPage(error: "Somthing went wrong");
        else
          return Scaffold(
            backgroundColor: AppThemes.white,
            body: Center(
              child: SpinKitWaveSpinner(
                color: Colors.white,
                size: 50.0,
                controller: AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 1200)),
              ),
            ),
          );
      },
    );
  }
}
