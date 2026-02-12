import '../../domain/entities/daily_log.dart';
import 'meal_entry_model.dart';

class DailyLogModel {
  final String id;
  final DateTime date;
  final List<MealEntryModel> meals;
  final double waterIntake;
  final double exerciseCaloriesBurned;
  final double? weight;

  DailyLogModel({
    required this.id,
    required this.date,
    required this.meals,
    this.waterIntake = 0.0,
    this.exerciseCaloriesBurned = 0.0,
    this.weight,
  });

  factory DailyLogModel.fromEntity(DailyLog entity) {
    return DailyLogModel(
      id: entity.id,
      date: entity.date,
      meals: entity.meals.map((m) => MealEntryModel.fromEntity(m)).toList(),
      waterIntake: entity.waterIntake,
      exerciseCaloriesBurned: entity.exerciseCaloriesBurned,
      weight: entity.weight,
    );
  }

  DailyLog toEntity() {
    return DailyLog(
      id: id,
      date: date,
      meals: meals.map((m) => m.toEntity()).toList(),
      waterIntake: waterIntake,
      exerciseCaloriesBurned: exerciseCaloriesBurned,
      weight: weight,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'meals': meals.map((m) => m.toJson()).toList(),
      'waterIntake': waterIntake,
      'exerciseCaloriesBurned': exerciseCaloriesBurned,
      'weight': weight,
    };
  }

  factory DailyLogModel.fromJson(Map<String, dynamic> json) {
    return DailyLogModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      meals: (json['meals'] as List).map((m) => MealEntryModel.fromJson(m as Map<String, dynamic>)).toList(),
      waterIntake: (json['waterIntake'] as num?)?.toDouble() ?? 0.0,
      exerciseCaloriesBurned: (json['exerciseCaloriesBurned'] as num?)?.toDouble() ?? 0.0,
      weight: json['weight'] != null ? (json['weight'] as num).toDouble() : null,
    );
  }
}
