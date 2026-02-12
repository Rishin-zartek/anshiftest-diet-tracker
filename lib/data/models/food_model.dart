import '../../domain/entities/food.dart';

class FoodModel {
  final String id;
  final String name;
  final double caloriesPer100g;
  final double proteinPer100g;
  final double carbsPer100g;
  final double fatPer100g;
  final double fiberPer100g;
  final String category;
  final bool isFavorite;

  FoodModel({
    required this.id,
    required this.name,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
    this.fiberPer100g = 0.0,
    required this.category,
    this.isFavorite = false,
  });

  factory FoodModel.fromEntity(Food entity) {
    return FoodModel(
      id: entity.id,
      name: entity.name,
      caloriesPer100g: entity.caloriesPer100g,
      proteinPer100g: entity.proteinPer100g,
      carbsPer100g: entity.carbsPer100g,
      fatPer100g: entity.fatPer100g,
      fiberPer100g: entity.fiberPer100g,
      category: entity.category,
      isFavorite: entity.isFavorite,
    );
  }

  Food toEntity() {
    return Food(
      id: id,
      name: name,
      caloriesPer100g: caloriesPer100g,
      proteinPer100g: proteinPer100g,
      carbsPer100g: carbsPer100g,
      fatPer100g: fatPer100g,
      fiberPer100g: fiberPer100g,
      category: category,
      isFavorite: isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'caloriesPer100g': caloriesPer100g,
      'proteinPer100g': proteinPer100g,
      'carbsPer100g': carbsPer100g,
      'fatPer100g': fatPer100g,
      'fiberPer100g': fiberPer100g,
      'category': category,
      'isFavorite': isFavorite,
    };
  }

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] as String,
      name: json['name'] as String,
      caloriesPer100g: (json['caloriesPer100g'] as num).toDouble(),
      proteinPer100g: (json['proteinPer100g'] as num).toDouble(),
      carbsPer100g: (json['carbsPer100g'] as num).toDouble(),
      fatPer100g: (json['fatPer100g'] as num).toDouble(),
      fiberPer100g: json['fiberPer100g'] != null ? (json['fiberPer100g'] as num).toDouble() : 0.0,
      category: json['category'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}
