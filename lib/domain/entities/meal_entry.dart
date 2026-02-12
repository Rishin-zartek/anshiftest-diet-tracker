enum MealType { breakfast, lunch, dinner, snacks }

class MealEntry {
  final String id;
  final String foodId;
  final String foodName;
  final double quantity;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final MealType mealType;
  final DateTime timestamp;
  final bool isRecipe;

  MealEntry({
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

  MealEntry copyWith({
    String? id,
    String? foodId,
    String? foodName,
    double? quantity,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    MealType? mealType,
    DateTime? timestamp,
    bool? isRecipe,
  }) {
    return MealEntry(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      foodName: foodName ?? this.foodName,
      quantity: quantity ?? this.quantity,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      mealType: mealType ?? this.mealType,
      timestamp: timestamp ?? this.timestamp,
      isRecipe: isRecipe ?? this.isRecipe,
    );
  }
}
