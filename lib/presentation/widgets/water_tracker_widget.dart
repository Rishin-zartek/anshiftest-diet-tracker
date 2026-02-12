import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class WaterTrackerWidget extends ConsumerWidget {
  final double currentIntake;
  final DateTime date;

  const WaterTrackerWidget({
    super.key,
    required this.currentIntake,
    required this.date,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const goal = 2.5;
    final progress = (currentIntake / goal).clamp(0.0, 1.0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Water Intake',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${currentIntake.toStringAsFixed(1)}L / ${goal}L',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final repository = ref.read(logRepositoryProvider);
                    await repository.updateWaterIntake(date, currentIntake + 0.2);
                    ref.invalidate(dailyLogProvider);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('200ml'),
                ),
                ElevatedButton.icon(
                  onPressed: currentIntake > 0 ? () async {
                    final repository = ref.read(logRepositoryProvider);
                    await repository.updateWaterIntake(date, (currentIntake - 0.2).clamp(0, double.infinity));
                    ref.invalidate(dailyLogProvider);
                  } : null,
                  icon: const Icon(Icons.remove),
                  label: const Text('200ml'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
