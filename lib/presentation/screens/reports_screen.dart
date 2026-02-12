import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/providers.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyLogAsync = ref.watch(dailyLogProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: dailyLogAsync.when(
        data: (dailyLog) {
          final totalProtein = dailyLog.totalProtein;
          final totalCarbs = dailyLog.totalCarbs;
          final totalFat = dailyLog.totalFat;
          final total = totalProtein + totalCarbs + totalFat;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Macro Distribution',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 24),
                      if (total > 0)
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: totalProtein,
                                  title: 'Protein\n${totalProtein.toInt()}g',
                                  color: Colors.blue,
                                  radius: 80,
                                ),
                                PieChartSectionData(
                                  value: totalCarbs,
                                  title: 'Carbs\n${totalCarbs.toInt()}g',
                                  color: Colors.orange,
                                  radius: 80,
                                ),
                                PieChartSectionData(
                                  value: totalFat,
                                  title: 'Fat\n${totalFat.toInt()}g',
                                  color: Colors.red,
                                  radius: 80,
                                ),
                              ],
                              sectionsSpace: 2,
                              centerSpaceRadius: 40,
                            ),
                          ),
                        )
                      else
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: Text('No data available'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Summary',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryRow('Total Calories', '${dailyLog.totalCalories.toInt()} cal'),
                      _buildSummaryRow('Protein', '${totalProtein.toInt()}g'),
                      _buildSummaryRow('Carbs', '${totalCarbs.toInt()}g'),
                      _buildSummaryRow('Fat', '${totalFat.toInt()}g'),
                      _buildSummaryRow('Water', '${dailyLog.waterIntake.toStringAsFixed(1)}L'),
                      _buildSummaryRow('Exercise', '${dailyLog.exerciseCaloriesBurned.toInt()} cal burned'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
