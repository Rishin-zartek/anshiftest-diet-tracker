import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import '../models/food_model.dart';
import '../../core/utils/database_service.dart';

class FoodLocalDataSource {
  Future<List<FoodModel>> loadFoodsFromAssets() async {
    final String jsonString = await rootBundle.loadString('assets/data/foods.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => FoodModel.fromJson(json)).toList();
  }

  Future<List<FoodModel>> getFavoriteFoods() async {
    final box = await DatabaseService.getFavoriteFoodsBox();
    final List<FoodModel> favorites = [];
    for (var key in box.keys) {
      final jsonData = box.get(key);
      if (jsonData != null) {
        favorites.add(FoodModel.fromJson(Map<String, dynamic>.from(jsonData)));
      }
    }
    return favorites;
  }

  Future<void> toggleFavorite(FoodModel food) async {
    final box = await DatabaseService.getFavoriteFoodsBox();
    if (box.containsKey(food.id)) {
      await box.delete(food.id);
    } else {
      await box.put(food.id, food.toJson());
    }
  }

  Future<bool> isFavorite(String foodId) async {
    final box = await DatabaseService.getFavoriteFoodsBox();
    return box.containsKey(foodId);
  }
}
