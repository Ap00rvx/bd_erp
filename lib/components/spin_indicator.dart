import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinIndicator extends StatefulWidget {
  const SpinIndicator({super.key});

  @override
  State<SpinIndicator> createState() => _SpinIndicatorState();
}

class _SpinIndicatorState extends State<SpinIndicator>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Initialize AnimationController once
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.darkerGrey,
      body: Center(
        child: SpinKitWaveSpinner(
          color: Colors.white,
          size: 50.0,
          controller: _animationController,
        ),
      ),
    );
  }
}
