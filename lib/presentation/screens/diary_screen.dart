import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/providers.dart';
import '../widgets/calorie_progress_widget.dart';
import '../widgets/meal_card_widget.dart';
import '../widgets/water_tracker_widget.dart';
import '../../domain/entities/meal_entry.dart';
import 'add_food_screen.dart';

class DiaryScreen extends ConsumerWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final dailyLogAsync = ref.watch(dailyLogProvider);
    final userProfileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (date != null) {
                ref.read(selectedDateProvider.notifier).state = date;
              }
            },
          ),
        ],
      ),
      body: dailyLogAsync.when(
        data: (dailyLog) {
          final userProfile = userProfileAsync.value;
          final goalCalories = userProfile?.dailyCalorieGoal ?? 2000;
          final consumedCalories = dailyLog.totalCalories;
          final burnedCalories = dailyLog.exerciseCaloriesBurned;
          final remainingCalories = goalCalories - consumedCalories + burnedCalories;

          final breakfastMeals = dailyLog.meals.where((m) => m.mealType == MealType.breakfast).toList();
          final lunchMeals = dailyLog.meals.where((m) => m.mealType == MealType.lunch).toList();
          final dinnerMeals = dailyLog.meals.where((m) => m.mealType == MealType.dinner).toList();
          final snacksMeals = dailyLog.meals.where((m) => m.mealType == MealType.snacks).toList();

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(dailyLogProvider);
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  DateFormat('EEEE, MMMM d').format(selectedDate),
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                CalorieProgressWidget(
                  consumed: consumedCalories,
                  goal: goalCalories,
                  burned: burnedCalories,
                  remaining: remainingCalories,
                ),
                const SizedBox(height: 24),
                WaterTrackerWidget(
                  currentIntake: dailyLog.waterIntake,
                  date: selectedDate,
                ),
                const SizedBox(height: 24),
                MealCardWidget(
                  mealType: MealType.breakfast,
                  meals: breakfastMeals,
                  date: selectedDate,
                ),
                const SizedBox(height: 16),
                MealCardWidget(
                  mealType: MealType.lunch,
                  meals: lunchMeals,
                  date: selectedDate,
                ),
                const SizedBox(height: 16),
                MealCardWidget(
                  mealType: MealType.dinner,
                  meals: dinnerMeals,
                  date: selectedDate,
                ),
                const SizedBox(height: 16),
                MealCardWidget(
                  mealType: MealType.snacks,
                  meals: snacksMeals,
                  date: selectedDate,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFoodScreen(date: selectedDate),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Food'),
      ),
    );
  }
}
