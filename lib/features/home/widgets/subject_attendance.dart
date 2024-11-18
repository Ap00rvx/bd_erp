import 'package:bd_erp/components/progres_indicator.dart';
import 'package:bd_erp/features/home/page/view_subject_attendance_page.dart';
import 'package:bd_erp/models/std_atd_details.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';

class SubjectAttendanceWidget extends StatelessWidget {
  const SubjectAttendanceWidget({Key? key, required this.subjects})
      : super(key: key);
  final List<Subject> subjects;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Gap(10), // Reduced the gap here
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 11.0),
        child: Text(
          "Subject Wise Attendance",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppThemes.white,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: ViewSubjectAttendancePage(
                              subject: subjects[index]),
                          type: PageTransitionType.fade));
                },
                child: _buildSubjectCard(subjects[index]));
          },
        ),
      ),
    ]);
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
          child: ProgressChart(percentage: subject.percentageAttendance,gradient:  subject.percentageAttendance < 40
            ? [
                Colors.red,
                Colors.red,
                AppThemes.highlightYellow,
    
              ]
            : subject.percentageAttendance  < 75
                ? [
                    AppThemes.highlightYellow,
                    AppThemes.highlightYellow,
                    Colors.orange,
                  ]
                : [Colors.green, Colors.green],),
        ),
      ),
      const Gap(10),
    ]),
  );
}
