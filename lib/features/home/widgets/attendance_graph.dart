import 'package:bd_erp/models/attendance_model.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class AttendanceGraph extends StatefulWidget {
  const AttendanceGraph({super.key, required this.data});
  final List<Attendance> data;

  @override
  State<AttendanceGraph> createState() => _AttendanceGraphState();
}

class _AttendanceGraphState extends State<AttendanceGraph> {
  DateTime? parseDateTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return null;
    }
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print("Error parsing date string: $e");
      return null;
    }
  }

  Map<DateTime, Map<String, int>> attendanceCountsForLast10DaysFromLatest(
      List<Attendance> attendanceList) {
    // Ensure the list is not empty
    if (attendanceList.isEmpty) return {};

    // Parse dates and sort them in descending order to get the latest dates first
    List<DateTime> sortedDates = attendanceList
        .where((data) => parseDateTime(data.absentDate) != null)
        .map((data) => parseDateTime(data.absentDate)!)
        .toSet() // Remove duplicates
        .toList()
      ..sort((a, b) => b.compareTo(a)); // Sort in descending order

    // Get the 10 most recent unique dates
    List<DateTime> last10Dates = sortedDates.take(10).toList();

    // Filter attendance data to keep only records within the last 10 dates
    List<Attendance> last10DaysData = attendanceList.where((data) {
      final date = parseDateTime(data.absentDate);
      return date != null &&
          last10Dates.contains(DateTime(date.year, date.month, date.day));
    }).toList();

    // Count attendance for each of the last 10 dates
    Map<DateTime, Map<String, int>> dailyCounts = {};

    for (var data in last10DaysData) {
      final date = parseDateTime(data.absentDate);
      DateTime day = DateTime(date!.year, date.month, date.day);

      // Initialize the count for this date if it doesn't exist
      if (!dailyCounts.containsKey(day)) {
        dailyCounts[day] = {'present': 0, 'absent': 0};
      }

      // Increment the appropriate count based on presence or absence
      if (data.isAbsent) {
        dailyCounts[day]!['absent'] = dailyCounts[day]!['absent']! + 1;
      } else {
        dailyCounts[day]!['present'] = dailyCounts[day]!['present']! + 1;
      }
    }

    return dailyCounts;
  }

  int first = 1;
  int f = 1;
  List<FlSpot> getPresentData(Map<DateTime, Map<String, int>> attendanceData) {
    first = 1;
    return attendanceData.entries.map((entry) {
      // Use the day of the month as the x-axis value
      int x = first;
      first++;
      final y = entry.value['present']?.toDouble() ?? 0;
      // print(x.toString() + " " + y.toString());
      return FlSpot(x.toDouble(), y);
    }).toList();
  }

  List<String> getDates(Map<DateTime, Map<String, int>> attendanceData) {
    return attendanceData.keys
        .map((date) => "${date.month}-${date.day}")
        .toList();
  }

  List<FlSpot> getAbsentData(Map<DateTime, Map<String, int>> attendanceData) {
    int f = 1;
    return attendanceData.entries.map((entry) {
      final x = f.toDouble();
      f++; // Use the day of the month as the x-axis value
      final y = entry.value['absent']?.toDouble() ?? 0;
      return FlSpot(x, y);
    }).toList();
  }

  String formatDate(double value) {
    // Convert the day number back to a date string
    final day = value.toInt();
    final date = DateTime(2024, 11, day);
    return DateFormat('MMM d').format(date); // Format as "Nov 4"
  }

  @override
  Widget build(BuildContext context) {
    final data = attendanceCountsForLast10DaysFromLatest(widget.data);
    final List<double> presentData = data.entries
        .map((entry) => entry.value['present']?.toDouble() ?? 0.0)
        .toList();
    final List<double> absentData = data.entries
        .map((entry) => entry.value['absent']?.toDouble() ?? 0.0)
        .toList();
    final List<String> dates =
        data.keys.map((date) => "${date.day}-${date.month}").toList();
    // print(data.length);
    return Column(
      children: [
        const Text(
          "Attendance Statistics",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppThemes.white,
          ),
        ),
        SizedBox(
          height: 300,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BarChart(
                BarChartData(
                  maxY: 8,
                  backgroundColor: Colors.transparent,
                  gridData: const FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                  ),
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
                          return Text(
                            dates[value.toInt() - 1],
                            style: const TextStyle(
                                color: AppThemes.white, fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  barGroups: data.entries.map((entry) {
                    int index =
                        dates.indexOf("${entry.key.day}-${entry.key.month}");
                    final presentCount =
                        entry.value['present']?.toDouble() ?? 0;
                    final absentCount = entry.value['absent']?.toDouble() ?? 0;
                    return BarChartGroupData(
                      x: index + 1,
                      barRods: [
                        BarChartRodData(
                          toY: presentCount,
                          color: Colors.green,
                          width: 8,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(1),
                            topRight: Radius.circular(1),
                          ),
                        ),
                        BarChartRodData(
                          toY: absentCount,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(1),
                            topRight: Radius.circular(1),
                          ),
                          color: Colors.red,
                          width: 8,
                        ),
                      ],
                      barsSpace: 4,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
