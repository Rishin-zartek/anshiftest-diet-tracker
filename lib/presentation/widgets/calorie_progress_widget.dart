import 'package:flutter/material.dart';
import 'dart:math' as math;

class CalorieProgressWidget extends StatelessWidget {
  final double consumed;
  final double goal;
  final double burned;
  final double remaining;

  const CalorieProgressWidget({
    super.key,
    required this.consumed,
    required this.goal,
    required this.burned,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (consumed / goal).clamp(0.0, 1.0);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: CircularProgressPainter(progress: progress),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${remaining.toInt()}',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: remaining < 0 ? Colors.red : Colors.green,
                        ),
                      ),
                      Text(
                        'Remaining',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(context, 'Consumed', consumed.toInt(), Colors.orange),
                _buildStat(context, 'Burned', burned.toInt(), Colors.red),
                _buildStat(context, 'Goal', goal.toInt(), Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, int value, Color color) {
    return Column(
      children: [
        Text(
          '$value',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;

  CircularProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    final progressPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 10, backgroundPaint);

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 10),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
