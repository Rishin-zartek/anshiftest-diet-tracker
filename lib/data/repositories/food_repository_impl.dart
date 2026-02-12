import '../../domain/entities/food.dart';
import '../datasources/food_local_datasource.dart';

class FoodRepositoryImpl {
  final FoodLocalDataSource _localDataSource;

  FoodRepositoryImpl(this._localDataSource);

  Future<List<Food>> getAllFoods() async {
    final foodModels = await _localDataSource.loadFoodsFromAssets();
    final favorites = await _localDataSource.getFavoriteFoods();
    final favoriteIds = favorites.map((f) => f.id).toSet();
    
    return foodModels.map((model) {
      final isFav = favoriteIds.contains(model.id);
      return Food(
        id: model.id,
        name: model.name,
        caloriesPer100g: model.caloriesPer100g,
        proteinPer100g: model.proteinPer100g,
        carbsPer100g: model.carbsPer100g,
        fatPer100g: model.fatPer100g,
        fiberPer100g: model.fiberPer100g,
        category: model.category,
        isFavorite: isFav,
      );
    }).toList();
  }

  Future<List<Food>> searchFoods(String query) async {
    final allFoods = await getAllFoods();
    if (query.isEmpty) return allFoods;
    
    final lowerQuery = query.toLowerCase();
    return allFoods.where((food) => 
      food.name.toLowerCase().contains(lowerQuery)
    ).toList();
  }

  Future<List<Food>> getFoodsByCategory(String category) async {
    final allFoods = await getAllFoods();
    return allFoods.where((food) => food.category == category).toList();
  }

  Future<List<Food>> getFavoriteFoods() async {
    final allFoods = await getAllFoods();
    return allFoods.where((food) => food.isFavorite).toList();
  }

  Future<void> toggleFavorite(Food food) async {
    final foodModel = await _localDataSource.loadFoodsFromAssets()
        .then((foods) => foods.firstWhere((f) => f.id == food.id));
    await _localDataSource.toggleFavorite(foodModel);
  }

  Future<Food?> getFoodById(String id) async {
    final allFoods = await getAllFoods();
    try {
      return allFoods.firstWhere((food) => food.id == id);
    } catch (e) {
      return null;
    }
  }
}
