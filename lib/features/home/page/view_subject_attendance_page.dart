import 'package:bd_erp/components/progres_indicator.dart';
import 'package:bd_erp/features/home/repository/home_repository.dart';
import 'package:bd_erp/locator.dart';
import 'package:bd_erp/models/attendance_model.dart';
import 'package:bd_erp/models/std_atd_details.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ViewSubjectAttendancePage extends StatelessWidget {
  const ViewSubjectAttendancePage({super.key, required this.subject});
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    final attdanceDatajson = locator
        .get<HomeRepository>()
        .responseData!["attendanceData"] as List<dynamic>;
    final extraLectures =
        locator.get<HomeRepository>().responseData!["extraLectures"] as List;
    final subjectName = subject.id;
    final attdanceData = (attdanceDatajson + extraLectures)
        .where((element) => element["subjectId"] == subjectName)
        .toList();
    print(attdanceData);
    final attData = attdanceData.map((e) {
      return Attendance.fromJson(e);
    }).toList();
    print(attData.length);
    return Scaffold(
      backgroundColor: AppThemes.darkerGrey,
      appBar: AppBar(
        title: Text(
          subject.name,
          style: const TextStyle(
              color: AppThemes.white,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        backgroundColor: AppThemes.darkerGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [_buildSubjectCard(subject)],
          ),
        ),
      ),
    );
  }
}

Widget _buildSubjectCard(Subject subject) {
  return Container(
    // height: 150,
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    margin: const EdgeInsets.symmetric(vertical: 9), // Reduced margin
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
    child: Row(children: [
      const Gap(10),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject.name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppThemes.white,
              ),
            ),
            Text(
              subject.code,
              style: const TextStyle(
                fontSize: 16,
                color: AppThemes.highlightYellow,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Presents: " + subject.presentLeactures.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppThemes.white,
                    ),
                  ),
                  Text(
                    "Total Lectures: " + subject.totalLeactures.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppThemes.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ProgressChart(percentage: subject.percentageAttendance),
        ),
      ),
      const Gap(10),
    ]),
  );
}
