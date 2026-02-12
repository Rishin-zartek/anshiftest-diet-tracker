class CalorieCalculator {
  static double calculateBMR({
    required double weight,
    required double height,
    required int age,
    required String gender,
  }) {
    if (gender.toLowerCase() == 'male') {
      return (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      return (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
  }

  static double calculateTDEE({
    required double bmr,
    required String activityLevel,
  }) {
    final multipliers = {
      'sedentary': 1.2,
      'lightly_active': 1.375,
      'moderately_active': 1.55,
      'very_active': 1.725,
      'extra_active': 1.9,
    };

    return bmr * (multipliers[activityLevel] ?? 1.2);
  }

  static double calculateDailyCalorieGoal({
    required double tdee,
    required String goal,
  }) {
    switch (goal.toLowerCase()) {
      case 'lose':
        return tdee - 500;
      case 'gain':
        return tdee + 500;
      case 'maintain':
      default:
        return tdee;
    }
  }

  static double calculateCaloriesFromMacros({
    required double protein,
    required double carbs,
    required double fat,
  }) {
    return (protein * 4) + (carbs * 4) + (fat * 9);
  }

  static Map<String, double> calculateMacroPercentages({
    required double protein,
    required double carbs,
    required double fat,
  }) {
    final totalCalories = calculateCaloriesFromMacros(
      protein: protein,
      carbs: carbs,
      fat: fat,
    );

    if (totalCalories == 0) {
      return {'protein': 0, 'carbs': 0, 'fat': 0};
    }

    return {
      'protein': ((protein * 4) / totalCalories) * 100,
      'carbs': ((carbs * 4) / totalCalories) * 100,
      'fat': ((fat * 9) / totalCalories) * 100,
    };
  }
}
