import '../../domain/entities/meal_entry.dart';

class MealEntryModel {
  final String id;
  final String foodId;
  final String foodName;
  final double quantity;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final String mealType;
  final DateTime timestamp;
  final bool isRecipe;

  MealEntryModel({
    required this.id,
    required this.foodId,
    required this.foodName,
    required this.quantity,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.mealType,
    required this.timestamp,
    this.isRecipe = false,
  });

  factory MealEntryModel.fromEntity(MealEntry entity) {
    return MealEntryModel(
      id: entity.id,
      foodId: entity.foodId,
      foodName: entity.foodName,
      quantity: entity.quantity,
      calories: entity.calories,
      protein: entity.protein,
      carbs: entity.carbs,
      fat: entity.fat,
      mealType: entity.mealType.name,
      timestamp: entity.timestamp,
      isRecipe: entity.isRecipe,
    );
  }

  MealEntry toEntity() {
    return MealEntry(
      id: id,
      foodId: foodId,
      foodName: foodName,
      quantity: quantity,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      mealType: MealType.values.firstWhere((e) => e.name == mealType),
      timestamp: timestamp,
      isRecipe: isRecipe,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodId': foodId,
      'foodName': foodName,
      'quantity': quantity,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'mealType': mealType,
      'timestamp': timestamp.toIso8601String(),
      'isRecipe': isRecipe,
    };
  }

  factory MealEntryModel.fromJson(Map<String, dynamic> json) {
    return MealEntryModel(
      id: json['id'] as String,
      foodId: json['foodId'] as String,
      foodName: json['foodName'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      mealType: json['mealType'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRecipe: json['isRecipe'] as bool? ?? false,
    );
  }
}
