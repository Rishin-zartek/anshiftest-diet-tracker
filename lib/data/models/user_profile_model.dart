import '../../domain/entities/user_profile.dart';

class UserProfileModel {
  final String id;
  final String name;
  final int age;
  final double weight;
  final double height;
  final String gender;
  final String activityLevel;
  final String goal;
  final double? targetWeight;
  final double dailyCalorieGoal;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    required this.activityLevel,
    required this.goal,
    this.targetWeight,
    required this.dailyCalorieGoal,
  });

  factory UserProfileModel.fromEntity(UserProfile entity) {
    return UserProfileModel(
      id: entity.id,
      name: entity.name,
      age: entity.age,
      weight: entity.weight,
      height: entity.height,
      gender: entity.gender,
      activityLevel: entity.activityLevel,
      goal: entity.goal,
      targetWeight: entity.targetWeight,
      dailyCalorieGoal: entity.dailyCalorieGoal,
    );
  }

  UserProfile toEntity() {
    return UserProfile(
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
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'weight': weight,
      'height': height,
      'gender': gender,
      'activityLevel': activityLevel,
      'goal': goal,
      'targetWeight': targetWeight,
      'dailyCalorieGoal': dailyCalorieGoal,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      gender: json['gender'] as String,
      activityLevel: json['activityLevel'] as String,
      goal: json['goal'] as String,
      targetWeight: json['targetWeight'] != null ? (json['targetWeight'] as num).toDouble() : null,
      dailyCalorieGoal: (json['dailyCalorieGoal'] as num).toDouble(),
    );
  }
}
