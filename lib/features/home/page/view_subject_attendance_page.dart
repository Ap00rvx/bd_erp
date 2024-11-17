import 'dart:math';

import 'package:bd_erp/components/progres_indicator.dart';
import 'package:bd_erp/features/home/repository/home_repository.dart';
import 'package:bd_erp/locator.dart';
import 'package:bd_erp/models/attendance_model.dart';
import 'package:bd_erp/models/std_atd_details.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ViewSubjectAttendancePage extends StatelessWidget {
  const ViewSubjectAttendancePage({super.key, required this.subject});
  final Subject subject;

  List<Map<DateTime, Map<String, dynamic>>> getAttendanceDetails(
      List<Attendance> data) {
    Map<DateTime, Map<String, dynamic>> consolidatedAttendance = {};

    for (var i = 0; i < data.length; i++) {
      final dataOfDay = data[i];
      final date = DateTime.parse(dataOfDay.absentDate);

      if (consolidatedAttendance.containsKey(date)) {
        // Update existing entry if necessary
        if (dataOfDay.isAbsent) {
          consolidatedAttendance[date]!["isAbsent"]++;
        } else {
          consolidatedAttendance[date]!["isPresent"]++;
        }
      } else {
        // Add new entry if it doesn't already exist
        consolidatedAttendance[date] = {"isAbsent": 0, "isPresent": 0};
        if (dataOfDay.isAbsent) {
          consolidatedAttendance[date]!["isAbsent"]++;
        } else {
          consolidatedAttendance[date]!["isPresent"]++;
        }
      }
    }
    // Convert the map to a list of maps for the result
    print(consolidatedAttendance);
    return consolidatedAttendance.entries
        .map((entry) => {entry.key: entry.value})
        .toList();
  }

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
        foregroundColor: AppThemes.white,
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
            children: [
              _buildSubjectCard(subject),
             const  Text("Attendance Statistics",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppThemes.white)),
              _buildAttendanceGraph(getAttendanceDetails(attData)),
              const Text("Datewise Attendance",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppThemes.white)),
              _buildAttendanceList(getAttendanceDetails(attData))
            ],
          ),
        ),
      ),
    );
  }
}

List<FlSpot> getPresent(List<Map<DateTime, Map<String, dynamic>>> data) {
  int first = 1;
  return data.map((entry) {
    // Use the day of the month as the x-axis value
    int x = first;
    first++;
    final y = entry.values.first["isPresent"].toDouble();
    // print(x.toString() + " " + y.toString());
    return FlSpot(x.toDouble(), y);
  }).toList();
}

List<FlSpot> getaAbssent(List<Map<DateTime, Map<String, dynamic>>> data) {
  int first = 1;
  return data.map((entry) {
    // Use the day of the month as the x-axis value
    int x = first;
    first++;
    final y = entry.values.first["isAbsent"].toDouble();
    // print(x.toString() + " " + y.toString());
    return FlSpot(x.toDouble(), y);
  }).toList();
}

Widget _buildAttendanceList(List<Map<DateTime, Map<String, dynamic>>> data) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    reverse: true,
    itemCount: data.length,
    itemBuilder: (context, index) {
      print(data[index]);
      return _attendanceCard(data[index]);
    },
  );
}

Widget _attendanceCard(Map<DateTime, Map<String, dynamic>> data) {
  final date = data.keys.first;
  final info = data[date];
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
              "${date.day}/${date.month}/${date.year}",
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: info!["isPresent"] > 0,
              child: Text(
                "P" * info!["isPresent"],
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Visibility(
              visible: info!["isAbsent"] > 0,
              child: Text(
                "A" * info!["isAbsent"],
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      const Gap(30),
    ]),
  );
}

Widget _buildAttendanceGraph(List<Map<DateTime, Map<String, dynamic>>> data) {
  data = data.reversed.toList();
  return SizedBox(
    height: 300,
    child: Padding(
      padding: EdgeInsets.all(20),
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: min(data.length.toDouble(), 10),
          minY: 0,
          maxY: 4,
          lineBarsData: [
            LineChartBarData(
              spots: getPresent(data).sublist(0, min(data.length, 10)),
              isCurved: true,
              isStepLineChart: true,
              color: Colors.green,
              barWidth: 1,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.green,
                        Colors.green.withOpacity(0.5),
                      ])),
            ),
            LineChartBarData(
              spots: getaAbssent(data).sublist(0, min(data.length, 10)),
              isCurved: false,
              color: Colors.red,
              barWidth: 1,
              isStrokeCapRound: true,
              isStepLineChart: true,
              belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.red,
                        Colors.red.withOpacity(0.5),
                      ])),
            ),
          ],
          backgroundColor: Colors.transparent,
          gridData: const FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              verticalInterval: 1),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  return Text(
                    '${value.toInt()}',
                    style: TextStyle(color: AppThemes.white),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  // print(value);
                  return Text(
                    data[value.toInt() - 1].keys.first.day.toString() +
                        "/" +
                        data[value.toInt() - 1].keys.first.month.toString(),
                    style: TextStyle(color: AppThemes.white, fontSize: 8),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    ),
  );
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
