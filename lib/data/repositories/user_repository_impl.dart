import '../../domain/entities/user_profile.dart';
import '../../core/utils/calorie_calculator.dart';
import '../datasources/user_local_datasource.dart';
import '../models/user_profile_model.dart';

class UserRepositoryImpl {
  final UserLocalDataSource _localDataSource;

  UserRepositoryImpl(this._localDataSource);

  Future<UserProfile?> getUserProfile() async {
    final profileModel = await _localDataSource.getUserProfile();
    return profileModel?.toEntity();
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    final profileModel = UserProfileModel.fromEntity(profile);
    await _localDataSource.saveUserProfile(profileModel);
  }

  Future<UserProfile> createUserProfile({
    required String id,
    required String name,
    required int age,
    required double weight,
    required double height,
    required String gender,
    required String activityLevel,
    required String goal,
    double? targetWeight,
  }) async {
    final bmr = CalorieCalculator.calculateBMR(
      weight: weight,
      height: height,
      age: age,
      gender: gender,
    );

    final tdee = CalorieCalculator.calculateTDEE(
      bmr: bmr,
      activityLevel: activityLevel,
    );

    final dailyCalorieGoal = CalorieCalculator.calculateDailyCalorieGoal(
      tdee: tdee,
      goal: goal,
    );

    final profile = UserProfile(
      id: id,
      name: name,
      age: age,
      weight: weight,
      height: height,
      gender: gender,
      activityLevel: activityLevel,
      goal: goal,
      targetWeight: targetWeight,
      dailyCalorieGoal: dailyCalorieGoal,
    );

    await saveUserProfile(profile);
    return profile;
  }

  Future<void> deleteUserProfile() async {
    await _localDataSource.deleteUserProfile();
  }
}
