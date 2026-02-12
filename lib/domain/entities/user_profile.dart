class UserProfile {
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

  UserProfile({
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

  UserProfile copyWith({
    String? id,
    String? name,
    int? age,
    double? weight,
    double? height,
    String? gender,
    String? activityLevel,
    String? goal,
    double? targetWeight,
    double? dailyCalorieGoal,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      activityLevel: activityLevel ?? this.activityLevel,
      goal: goal ?? this.goal,
      targetWeight: targetWeight ?? this.targetWeight,
      dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
    );
  }
}
