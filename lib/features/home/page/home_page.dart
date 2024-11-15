import 'package:bd_erp/features/authentication/bloc/auth_bloc.dart';
import 'package:bd_erp/features/authentication/repository/auth_rpository.dart';
import 'package:bd_erp/features/home/bloc/home_bloc.dart';
import 'package:bd_erp/features/home/repository/home_repository.dart';
import 'package:bd_erp/locator.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(FetchHome());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
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
        } else if (state is HomeSuccess) {
          return _buildHome(context);
        } else if (state is HomeError) {
          return Scaffold(
            backgroundColor: AppThemes.white,
            body: Center(
              child: Text(state.message),
            ),
          );
        } else {
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
        }
      },
    );
  }
}

Widget _buildHome(BuildContext context) {
  return Scaffold(
     backgroundColor: AppThemes.white,
    body: FutureBuilder(
        future: locator.get<HomeRepository>().gethomeDetails(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
                child: SpinKitWaveSpinner(
              color: Colors.white,
              size: 50.0,
              duration: Duration(milliseconds: 1200),
            ));
          } else if (snap.hasData) {
            final data = snap.data!;
            final subjects = data.overallPercentage;
            return Center(
              child: Text(subjects.toString()),
            );
          } else {
            return Center(child: Text('No Data Found'));
          }
        }),
  );
}
