import 'dart:math';

import 'package:bd_erp/components/progres_indicator.dart';
import 'package:bd_erp/models/pdp_attendance_model.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ViewPdpAttendancePage extends StatelessWidget {
  const ViewPdpAttendancePage({super.key, required this.subject});
  final List<PdpAttendance> subject;
  int getPresent() {
    return subject.where((e) => !e.isInAbsent).length;
  }

  int getAbsent() {
    return subject.where((e) => e.isInAbsent).length;
  }

  List<PdpAttendance> get presents =>
      subject.where((e) => !e.isInAbsent).toList();
  List<PdpAttendance> get absents =>
      subject.where((e) => e.isInAbsent).toList();
  List<Map<DateTime, Map<String, dynamic>>> getAttendanceDetails(
      List<PdpAttendance> data) {
    Map<DateTime, Map<String, dynamic>> consolidatedAttendance = {};

    for (var i = 0; i < data.length; i++) {
      final dataOfDay = data[i];
      final date = (dataOfDay.attendanceDate);

      if (consolidatedAttendance.containsKey(date)) {
        // Update existing entry if necessary
        if (dataOfDay.isInAbsent) {
          consolidatedAttendance[date]!["isAbsent"]++;
        } else {
          consolidatedAttendance[date]!["isPresent"]++;
        }
      } else {
        // Add new entry if it doesn't already exist
        consolidatedAttendance[date] = {"isAbsent": 0, "isPresent": 0};
        if (dataOfDay.isInAbsent) {
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
    return Scaffold(
      backgroundColor: AppThemes.darkerGrey,
      appBar: AppBar(
        foregroundColor: AppThemes.white,
        title: const Text(
          "PDP Attendance",
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
              _buildAttendanceCard(presents, absents),
              const Text("Attendance Statistics",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppThemes.white)),
              _buildAttendanceGraph(getAttendanceDetails(subject)),
              const Text("Datewise Attendance",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppThemes.white)),
              ListView.builder(
                  reverse: true,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _attendanceCard(
                        getAttendanceDetails(subject)[index]);
                  },
                  itemCount: getAttendanceDetails(subject).length),
            ],
          ),
        ),
      ),
    );
  }
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

Widget _buildAttendanceCard(
    List<PdpAttendance> getPresent, List<PdpAttendance> getAbsent) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 11.0),
    child: Container(
      constraints: const BoxConstraints(minHeight: 100),
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
              // ignore: prefer_const_constructors
              Text(
                "PDP Attendance",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppThemes.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Presents: ${getPresent.length}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppThemes.white,
                      ),
                    ),
                    Text(
                      "Total Lectures: ${getAbsent.length}",
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
            child: ProgressChart(
              percentage:
                  (getPresent.length / (getPresent.length + getAbsent.length)) *
                      100,
              gradient:
                  (getPresent.length / (getPresent.length + getAbsent.length)) *
                              100 <
                          40
                      ? [
                          Colors.red,
                          Colors.red,
                          AppThemes.highlightYellow,
                        ]
                      : (getPresent.length /
                                      (getPresent.length + getAbsent.length)) *
                                  100 <
                              75
                          ? [
                              AppThemes.highlightYellow,
                              AppThemes.highlightYellow,
                              Colors.orange,
                            ]
                          : [Colors.green, Colors.green],
            ),
          ),
        ),
        const Gap(10),
      ]),
    ),
  );
}

Widget _buildAttendanceGraph(List<Map<DateTime, Map<String, dynamic>>> data) {
  data = data.reversed.toList();
  print(data);
  return SizedBox(
    height: 300,
    child: Padding(
      padding: EdgeInsets.all(20),
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: 4,
          barGroups: List.generate(min(data.length, 10), (index) {
            return BarChartGroupData(
              x: index + 1,
              barRods: [
                BarChartRodData(
                  toY: data[index].values.first["isPresent"].toDouble(),
                  color: Colors.green,
                  width: 8,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(1),
                    topRight: Radius.circular(1),
                  ),
                ),
                BarChartRodData(
                  toY: data[index].values.first["isAbsent"].toDouble(),
                  color: Colors.red,
                  width: 8,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(1),
                    topRight: Radius.circular(1),
                  ),
                ),
              ],
              barsSpace: 4,
            );
          }),
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
