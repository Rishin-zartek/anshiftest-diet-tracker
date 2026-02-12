class RecipeIngredient {
  final String foodId;
  final String foodName;
  final double quantity;

  RecipeIngredient({
    required this.foodId,
    required this.foodName,
    required this.quantity,
  });
}

class Recipe {
  final String id;
  final String name;
  final List<RecipeIngredient> ingredients;
  final double servings;
  final String category;
  final bool isCustom;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.servings,
    required this.category,
    this.isCustom = false,
  });

  Recipe copyWith({
    String? id,
    String? name,
    List<RecipeIngredient>? ingredients,
    double? servings,
    String? category,
    bool? isCustom,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
      servings: servings ?? this.servings,
      category: category ?? this.category,
      isCustom: isCustom ?? this.isCustom,
    );
  }
}
