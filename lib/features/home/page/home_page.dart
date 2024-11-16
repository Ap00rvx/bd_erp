import 'dart:convert';

import 'package:bd_erp/components/detail_box.dart';
import 'package:bd_erp/models/std_atd_details.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spinController;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Triggering fetch event once
    context.read<HomeBloc>().add(FetchHome());
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return _buildLoading();
        } else if (state is HomeSuccess) {
          return _buildHome(context, state.data);
        } else if (state is HomeError) {
          return _buildError(state.message);
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      backgroundColor: AppThemes.white,
      body: Center(
        child: SpinKitWaveSpinner(
          color: Colors.white,
          size: 50.0,
          controller: _spinController,
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Scaffold(
      backgroundColor: AppThemes.white,
      body: Center(
        child: Text(message),
      ),
    );
  }

  Widget _buildHome(BuildContext context, dynamic data) {
    final userData = locator.get<AuthRepository>().user!;
    final attd = StdSubAtdDetails.fromJson(data['stdSubAtdDetails']);
    return Scaffold(
      backgroundColor: AppThemes.white,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(FetchHome());
        },
        child: CustomScrollView(
          slivers: [
            _buildAppBar(userData),
            SliverList(
              delegate: SliverChildListDelegate([
                AttendanceWidget(data: attd),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(userData) {
    return SliverAppBar(
      elevation: 3,
      expandedHeight: 180.0,
      pinned: true,
      backgroundColor: AppThemes.white,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.5,
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Hi, ${userData.firstName}!",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.notifications,
              color: Colors.black,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceWidget extends StatelessWidget {
  final dynamic data;

  const AttendanceWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppThemes.backgroundLightGrey,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Gap(10),
          SizedBox(
            width: 250,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Attendance Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppThemes.white,
                  ),
                ),
                const Gap(10),
                Text(
                  "Total Lectures: ${data.overallLecture}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppThemes.white,
                  ),
                ),
                Text(
                  "Total Present: ${data.overallPresent}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppThemes.white,
                  ),
                ),
                Text(
                  "Total Absent: ${data.overallLecture - data.overallPresent}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppThemes.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: AnimatedDonutChart(percentage: data.overallPercentage),
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
