import 'package:flutter_test/flutter_test.dart';
import 'package:diet_tracker/core/utils/calorie_calculator.dart';

void main() {
  group('CalorieCalculator - BMR Calculation', () {
    test('calculates BMR correctly for male', () {
      final bmr = CalorieCalculator.calculateBMR(
        weight: 70,
        height: 175,
        age: 30,
        gender: 'male',
      );
      
      // Expected: (10 * 70) + (6.25 * 175) - (5 * 30) + 5 = 1648.75
      expect(bmr, closeTo(1648.75, 0.01));
    });

    test('calculates BMR correctly for female', () {
      final bmr = CalorieCalculator.calculateBMR(
        weight: 60,
        height: 165,
        age: 25,
        gender: 'female',
      );
      
      // Expected: (10 * 60) + (6.25 * 165) - (5 * 25) - 161 = 600 + 1031.25 - 125 - 161 = 1345.25
      expect(bmr, closeTo(1345.25, 0.01));
    });

    test('handles case-insensitive gender input', () {
      final bmrMale = CalorieCalculator.calculateBMR(
        weight: 70,
        height: 175,
        age: 30,
        gender: 'MALE',
      );
      
      final bmrFemale = CalorieCalculator.calculateBMR(
        weight: 70,
        height: 175,
        age: 30,
        gender: 'Female',
      );
      
      expect(bmrMale, closeTo(1648.75, 0.01));
      // Female: (10 * 70) + (6.25 * 175) - (5 * 30) - 161 = 700 + 1093.75 - 150 - 161 = 1482.75
      expect(bmrFemale, closeTo(1482.75, 0.01));
    });

    test('calculates BMR for edge case - young age', () {
      final bmr = CalorieCalculator.calculateBMR(
        weight: 50,
        height: 160,
        age: 18,
        gender: 'female',
      );
      
      // Expected: (10 * 50) + (6.25 * 160) - (5 * 18) - 161 = 1249
      expect(bmr, closeTo(1249, 0.01));
    });

    test('calculates BMR for edge case - older age', () {
      final bmr = CalorieCalculator.calculateBMR(
        weight: 80,
        height: 180,
        age: 60,
        gender: 'male',
      );
      
      // Expected: (10 * 80) + (6.25 * 180) - (5 * 60) + 5 = 1630
      expect(bmr, closeTo(1630, 0.01));
    });
  });

  group('CalorieCalculator - TDEE Calculation', () {
    test('calculates TDEE for sedentary activity level', () {
      final tdee = CalorieCalculator.calculateTDEE(
        bmr: 1500,
        activityLevel: 'sedentary',
      );
      
      // Expected: 1500 * 1.2 = 1800
      expect(tdee, closeTo(1800, 0.01));
    });

    test('calculates TDEE for lightly active', () {
      final tdee = CalorieCalculator.calculateTDEE(
        bmr: 1500,
        activityLevel: 'lightly_active',
      );
      
      // Expected: 1500 * 1.375 = 2062.5
      expect(tdee, closeTo(2062.5, 0.01));
    });

    test('calculates TDEE for moderately active', () {
      final tdee = CalorieCalculator.calculateTDEE(
        bmr: 1500,
        activityLevel: 'moderately_active',
      );
      
      // Expected: 1500 * 1.55 = 2325
      expect(tdee, closeTo(2325, 0.01));
    });

    test('calculates TDEE for very active', () {
      final tdee = CalorieCalculator.calculateTDEE(
        bmr: 1500,
        activityLevel: 'very_active',
      );
      
      // Expected: 1500 * 1.725 = 2587.5
      expect(tdee, closeTo(2587.5, 0.01));
    });

    test('calculates TDEE for extra active', () {
      final tdee = CalorieCalculator.calculateTDEE(
        bmr: 1500,
        activityLevel: 'extra_active',
      );
      
      // Expected: 1500 * 1.9 = 2850
      expect(tdee, closeTo(2850, 0.01));
    });

    test('defaults to sedentary for unknown activity level', () {
      final tdee = CalorieCalculator.calculateTDEE(
        bmr: 1500,
        activityLevel: 'unknown_level',
      );
      
      // Expected: 1500 * 1.2 = 1800 (default)
      expect(tdee, closeTo(1800, 0.01));
    });
  });

  group('CalorieCalculator - Daily Calorie Goal', () {
    test('calculates goal for weight loss', () {
      final goal = CalorieCalculator.calculateDailyCalorieGoal(
        tdee: 2000,
        goal: 'lose',
      );
      
      // Expected: 2000 - 500 = 1500
      expect(goal, closeTo(1500, 0.01));
    });

    test('calculates goal for weight gain', () {
      final goal = CalorieCalculator.calculateDailyCalorieGoal(
        tdee: 2000,
        goal: 'gain',
      );
      
      // Expected: 2000 + 500 = 2500
      expect(goal, closeTo(2500, 0.01));
    });

    test('calculates goal for weight maintenance', () {
      final goal = CalorieCalculator.calculateDailyCalorieGoal(
        tdee: 2000,
        goal: 'maintain',
      );
      
      // Expected: 2000
      expect(goal, closeTo(2000, 0.01));
    });

    test('handles case-insensitive goal input', () {
      final goalLose = CalorieCalculator.calculateDailyCalorieGoal(
        tdee: 2000,
        goal: 'LOSE',
      );
      
      final goalGain = CalorieCalculator.calculateDailyCalorieGoal(
        tdee: 2000,
        goal: 'Gain',
      );
      
      expect(goalLose, closeTo(1500, 0.01));
      expect(goalGain, closeTo(2500, 0.01));
    });

    test('defaults to maintenance for unknown goal', () {
      final goal = CalorieCalculator.calculateDailyCalorieGoal(
        tdee: 2000,
        goal: 'unknown',
      );
      
      // Expected: 2000 (default to maintain)
      expect(goal, closeTo(2000, 0.01));
    });
  });

  group('CalorieCalculator - Calories from Macros', () {
    test('calculates calories from macros correctly', () {
      final calories = CalorieCalculator.calculateCaloriesFromMacros(
        protein: 50,
        carbs: 100,
        fat: 30,
      );
      
      // Expected: (50 * 4) + (100 * 4) + (30 * 9) = 200 + 400 + 270 = 870
      expect(calories, closeTo(870, 0.01));
    });

    test('handles zero macros', () {
      final calories = CalorieCalculator.calculateCaloriesFromMacros(
        protein: 0,
        carbs: 0,
        fat: 0,
      );
      
      expect(calories, closeTo(0, 0.01));
    });

    test('calculates with only protein', () {
      final calories = CalorieCalculator.calculateCaloriesFromMacros(
        protein: 25,
        carbs: 0,
        fat: 0,
      );
      
      // Expected: 25 * 4 = 100
      expect(calories, closeTo(100, 0.01));
    });

    test('calculates with only carbs', () {
      final calories = CalorieCalculator.calculateCaloriesFromMacros(
        protein: 0,
        carbs: 50,
        fat: 0,
      );
      
      // Expected: 50 * 4 = 200
      expect(calories, closeTo(200, 0.01));
    });

    test('calculates with only fat', () {
      final calories = CalorieCalculator.calculateCaloriesFromMacros(
        protein: 0,
        carbs: 0,
        fat: 20,
      );
      
      // Expected: 20 * 9 = 180
      expect(calories, closeTo(180, 0.01));
    });
  });

  group('CalorieCalculator - Macro Percentages', () {
    test('calculates macro percentages correctly', () {
      final percentages = CalorieCalculator.calculateMacroPercentages(
        protein: 50,
        carbs: 100,
        fat: 30,
      );
      
      // Total calories: (50*4) + (100*4) + (30*9) = 870
      // Protein: (50*4)/870 * 100 = 22.99%
      // Carbs: (100*4)/870 * 100 = 45.98%
      // Fat: (30*9)/870 * 100 = 31.03%
      
      expect(percentages['protein'], closeTo(22.99, 0.01));
      expect(percentages['carbs'], closeTo(45.98, 0.01));
      expect(percentages['fat'], closeTo(31.03, 0.01));
    });

    test('handles zero macros without division by zero', () {
      final percentages = CalorieCalculator.calculateMacroPercentages(
        protein: 0,
        carbs: 0,
        fat: 0,
      );
      
      expect(percentages['protein'], equals(0));
      expect(percentages['carbs'], equals(0));
      expect(percentages['fat'], equals(0));
    });

    test('calculates percentages with high protein diet', () {
      final percentages = CalorieCalculator.calculateMacroPercentages(
        protein: 150,
        carbs: 50,
        fat: 30,
      );
      
      // Total: (150*4) + (50*4) + (30*9) = 600 + 200 + 270 = 1070
      // Protein: 600/1070 * 100 = 56.07%
      // Carbs: 200/1070 * 100 = 18.69%
      // Fat: 270/1070 * 100 = 25.23%
      
      expect(percentages['protein'], closeTo(56.07, 0.01));
      expect(percentages['carbs'], closeTo(18.69, 0.01));
      expect(percentages['fat'], closeTo(25.23, 0.01));
    });

    test('percentages sum to approximately 100', () {
      final percentages = CalorieCalculator.calculateMacroPercentages(
        protein: 75,
        carbs: 200,
        fat: 50,
      );
      
      final sum = percentages['protein']! + 
                  percentages['carbs']! + 
                  percentages['fat']!;
      
      expect(sum, closeTo(100, 0.1));
    });
  });

  group('CalorieCalculator - Integration Tests', () {
    test('complete calorie calculation flow for male losing weight', () {
      // User profile: 75kg, 180cm, 28 years old, male, sedentary, wants to lose weight
      final bmr = CalorieCalculator.calculateBMR(
        weight: 75,
        height: 180,
        age: 28,
        gender: 'male',
      );
      
      final tdee = CalorieCalculator.calculateTDEE(
        bmr: bmr,
        activityLevel: 'sedentary',
      );
      
      final dailyGoal = CalorieCalculator.calculateDailyCalorieGoal(
        tdee: tdee,
        goal: 'lose',
      );
      
      // BMR: (10*75) + (6.25*180) - (5*28) + 5 = 1740
      // TDEE: 1740 * 1.2 = 2088
      // Goal: 2088 - 500 = 1588
      
      expect(bmr, closeTo(1740, 0.01));
      expect(tdee, closeTo(2088, 0.01));
      expect(dailyGoal, closeTo(1588, 0.01));
    });

    test('complete calorie calculation flow for female gaining weight', () {
      // User profile: 55kg, 165cm, 25 years old, female, moderately active, wants to gain weight
      final bmr = CalorieCalculator.calculateBMR(
        weight: 55,
        height: 165,
        age: 25,
        gender: 'female',
      );
      
      final tdee = CalorieCalculator.calculateTDEE(
        bmr: bmr,
        activityLevel: 'moderately_active',
      );
      
      final dailyGoal = CalorieCalculator.calculateDailyCalorieGoal(
        tdee: tdee,
        goal: 'gain',
      );
      
      // BMR: (10*55) + (6.25*165) - (5*25) - 161 = 550 + 1031.25 - 125 - 161 = 1295.25
      // TDEE: 1295.25 * 1.55 = 2007.6375
      // Goal: 2007.6375 + 500 = 2507.6375
      
      expect(bmr, closeTo(1295.25, 0.01));
      expect(tdee, closeTo(2007.64, 0.01));
      expect(dailyGoal, closeTo(2507.64, 0.01));
    });

    test('macro tracking for a typical meal', () {
      // Meal: 30g protein, 50g carbs, 15g fat
      final calories = CalorieCalculator.calculateCaloriesFromMacros(
        protein: 30,
        carbs: 50,
        fat: 15,
      );
      
      final percentages = CalorieCalculator.calculateMacroPercentages(
        protein: 30,
        carbs: 50,
        fat: 15,
      );
      
      // Calories: (30*4) + (50*4) + (15*9) = 120 + 200 + 135 = 455
      expect(calories, closeTo(455, 0.01));
      
      // Verify percentages sum to 100
      final sum = percentages['protein']! + 
                  percentages['carbs']! + 
                  percentages['fat']!;
      expect(sum, closeTo(100, 0.1));
    });
  });
}
