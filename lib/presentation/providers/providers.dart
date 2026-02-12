import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/food_local_datasource.dart';
import '../../data/datasources/log_local_datasource.dart';
import '../../data/datasources/user_local_datasource.dart';
import '../../data/repositories/food_repository_impl.dart';
import '../../data/repositories/log_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/daily_log.dart';
import '../../domain/entities/food.dart';

final foodDataSourceProvider = Provider((ref) => FoodLocalDataSource());
final logDataSourceProvider = Provider((ref) => LogLocalDataSource());
final userDataSourceProvider = Provider((ref) => UserLocalDataSource());

final foodRepositoryProvider = Provider((ref) {
  return FoodRepositoryImpl(ref.watch(foodDataSourceProvider));
});

final logRepositoryProvider = Provider((ref) {
  return LogRepositoryImpl(ref.watch(logDataSourceProvider));
});

final userRepositoryProvider = Provider((ref) {
  return UserRepositoryImpl(ref.watch(userDataSourceProvider));
});

final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return await repository.getUserProfile();
});

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final dailyLogProvider = FutureProvider<DailyLog>((ref) async {
  final date = ref.watch(selectedDateProvider);
  final repository = ref.watch(logRepositoryProvider);
  return await repository.getDailyLog(date);
});

final allFoodsProvider = FutureProvider<List<Food>>((ref) async {
  final repository = ref.watch(foodRepositoryProvider);
  return await repository.getAllFoods();
});

final favoriteFoodsProvider = FutureProvider<List<Food>>((ref) async {
  final repository = ref.watch(foodRepositoryProvider);
  return await repository.getFavoriteFoods();
});

final foodSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredFoodsProvider = FutureProvider<List<Food>>((ref) async {
  final query = ref.watch(foodSearchQueryProvider);
  final repository = ref.watch(foodRepositoryProvider);
  return await repository.searchFoods(query);
});
