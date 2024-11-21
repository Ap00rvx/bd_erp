// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:bd_erp/components/errror_page.dart';
import 'package:bd_erp/components/spin_indicator.dart';
import 'package:bd_erp/features/authentication/bloc/auth_bloc.dart';
import 'package:bd_erp/features/home/page/home_page.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FetchHome extends StatefulWidget {
  const FetchHome({super.key, required this.name, required this.pass});
  final String name;
  final String pass;
  @override
  State<FetchHome> createState() => _FetchHomeState();
}

class _FetchHomeState extends State<FetchHome> {
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
          return const SpinIndicator(); 
        } else if (state is AuthSuccess) {
          return const HomePage();
        } else if (state is AuthFailure)
          return const ErrrorPage(error: "Somthing went wrong");
        else
          return const SpinIndicator(); 
      },
    );
  }
}
