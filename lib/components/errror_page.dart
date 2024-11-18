import 'package:bd_erp/components/auth_check.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ErrrorPage extends StatelessWidget {
  const ErrrorPage({super.key, required this.error});
  final String error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppThemes.darkerGrey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/image/err.png",
                height: 300,
                width: 300,
              ),
              Text(
                error,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 20), // Space between text and button
              ElevatedButton(
                onPressed: () => {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: const AuthCheck(),
                          type: PageTransitionType.fade),
                      (route) => false)
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: const Text("Restart Application"),
              ),
            ],
          ),
        ));
  }
}
