import 'package:uuid/uuid.dart';
import '../../domain/entities/daily_log.dart';
import '../../domain/entities/meal_entry.dart';
import '../datasources/log_local_datasource.dart';
import '../models/daily_log_model.dart';
import '../models/meal_entry_model.dart';

class LogRepositoryImpl {
  final LogLocalDataSource _localDataSource;
  final _uuid = const Uuid();

  LogRepositoryImpl(this._localDataSource);

  Future<DailyLog> getDailyLog(DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final logModel = await _localDataSource.getDailyLog(normalizedDate);
    
    if (logModel != null) {
      return logModel.toEntity();
    }
    
    return DailyLog(
      id: _uuid.v4(),
      date: normalizedDate,
      meals: [],
      waterIntake: 0.0,
      exerciseCaloriesBurned: 0.0,
    );
  }

  Future<void> saveDailyLog(DailyLog log) async {
    final logModel = DailyLogModel.fromEntity(log);
    await _localDataSource.saveDailyLog(logModel);
  }

  Future<void> addMealEntry(DateTime date, MealEntry meal) async {
    final log = await getDailyLog(date);
    final updatedMeals = List<MealEntry>.from(log.meals)..add(meal);
    final updatedLog = log.copyWith(meals: updatedMeals);
    await saveDailyLog(updatedLog);
  }

  Future<void> removeMealEntry(DateTime date, String mealId) async {
    final log = await getDailyLog(date);
    final updatedMeals = log.meals.where((m) => m.id != mealId).toList();
    final updatedLog = log.copyWith(meals: updatedMeals);
    await saveDailyLog(updatedLog);
  }

  Future<void> updateWaterIntake(DateTime date, double waterIntake) async {
    final log = await getDailyLog(date);
    final updatedLog = log.copyWith(waterIntake: waterIntake);
    await saveDailyLog(updatedLog);
  }

  Future<void> updateExerciseCalories(DateTime date, double calories) async {
    final log = await getDailyLog(date);
    final updatedLog = log.copyWith(exerciseCaloriesBurned: calories);
    await saveDailyLog(updatedLog);
  }

  Future<void> updateWeight(DateTime date, double weight) async {
    final log = await getDailyLog(date);
    final updatedLog = log.copyWith(weight: weight);
    await saveDailyLog(updatedLog);
  }

  Future<List<DailyLog>> getLogsInRange(DateTime start, DateTime end) async {
    final logModels = await _localDataSource.getLogsInRange(start, end);
    return logModels.map((model) => model.toEntity()).toList();
  }

  Future<void> deleteDailyLog(DateTime date) async {
    await _localDataSource.deleteDailyLog(date);
  }
}
