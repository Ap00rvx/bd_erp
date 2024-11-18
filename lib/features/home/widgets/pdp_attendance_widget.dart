import 'package:bd_erp/components/progres_indicator.dart';
import 'package:bd_erp/features/home/page/view_pdp_attendance_page.dart';
import 'package:bd_erp/models/pdp_attendance_model.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';

class PdpAttendanceWidget extends StatelessWidget {
  const PdpAttendanceWidget({super.key, required this.subject});
  final List<PdpAttendance> subject;

  int getPresent() {
    return subject.where((e) => !e.isInAbsent).length;
  }

  int getAbsent() {
    return subject.where((e) => e.isInAbsent).length;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: ViewPdpAttendancePage(subject: subject),
                type: PageTransitionType.fade));
      },
      child: Padding(
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
                          "Total Presents: ${getPresent()}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppThemes.white,
                          ),
                        ),
                        Text(
                          "Total Lectures: ${getAbsent()}",
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
                      (getPresent() / (getPresent() + getAbsent())) * 100,
                  gradient: (getPresent() / (getPresent() + getAbsent())) *
                              100 <
                          40
                      ? [
                          Colors.red,
                          Colors.red,
                          AppThemes.highlightYellow,
                        ]
                      : (getPresent() / (getPresent() + getAbsent())) * 100 < 75
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
      ),
    );
  }
}
