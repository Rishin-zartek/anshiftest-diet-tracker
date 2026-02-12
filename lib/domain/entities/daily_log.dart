import 'meal_entry.dart';

class DailyLog {
  final String id;
  final DateTime date;
  final List<MealEntry> meals;
  final double waterIntake;
  final double exerciseCaloriesBurned;
  final double? weight;

  DailyLog({
    required this.id,
    required this.date,
    required this.meals,
    this.waterIntake = 0.0,
    this.exerciseCaloriesBurned = 0.0,
    this.weight,
  });

  double get totalCalories => meals.fold(0.0, (sum, meal) => sum + meal.calories);
  double get totalProtein => meals.fold(0.0, (sum, meal) => sum + meal.protein);
  double get totalCarbs => meals.fold(0.0, (sum, meal) => sum + meal.carbs);
  double get totalFat => meals.fold(0.0, (sum, meal) => sum + meal.fat);

  DailyLog copyWith({
    String? id,
    DateTime? date,
    List<MealEntry>? meals,
    double? waterIntake,
    double? exerciseCaloriesBurned,
    double? weight,
  }) {
    return DailyLog(
      id: id ?? this.id,
      date: date ?? this.date,
      meals: meals ?? this.meals,
      waterIntake: waterIntake ?? this.waterIntake,
      exerciseCaloriesBurned: exerciseCaloriesBurned ?? this.exerciseCaloriesBurned,
      weight: weight ?? this.weight,
    );
  }
}
