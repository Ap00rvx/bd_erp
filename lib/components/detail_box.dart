import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AnimatedDonutChart extends StatefulWidget {
  final double percentage;

  const AnimatedDonutChart({Key? key, required this.percentage})
      : super(key: key);

  @override
  _AnimatedDonutChartState createState() => _AnimatedDonutChartState();
}

class _AnimatedDonutChartState extends State<AnimatedDonutChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: widget.percentage).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(200, 200),
          child: Center(
              child: Text(
            widget.percentage.toString() + "%",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          )), // Size of the donut
          painter: DonutPainter(percentage: _animation.value),
        );
      },
    );
  }
}

class DonutPainter extends CustomPainter {
  final double percentage;

  DonutPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle (unfilled part)
    final backgroundPaint = Paint()
      ..color = AppThemes.backgroundLightGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    // Foreground circle (filled part)
    final foregroundPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppThemes.highlightYellow,
          AppThemes.highlightYellow,
          Colors.green
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    // Draw the unfilled circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw the filled arc
    final double sweepAngle = 2 * 3.141592653589793 * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2, // Start angle
      sweepAngle, // Sweep angle
      false, // Use center for pie chart; false for donut
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint when animation changes
  }
}
