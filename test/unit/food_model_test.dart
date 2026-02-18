import 'package:flutter_test/flutter_test.dart';
import 'package:diet_tracker/data/models/food_model.dart';
import 'package:diet_tracker/domain/entities/food.dart';

void main() {
  group('FoodModel - JSON Serialization', () {
    test('toJson converts model to JSON correctly', () {
      final model = FoodModel(
        id: 'food_1',
        name: 'Idli',
        caloriesPer100g: 58.0,
        proteinPer100g: 2.0,
        carbsPer100g: 12.0,
        fatPer100g: 0.1,
        fiberPer100g: 0.8,
        category: 'breakfast',
        isFavorite: true,
      );

      final json = model.toJson();

      expect(json['id'], equals('food_1'));
      expect(json['name'], equals('Idli'));
      expect(json['caloriesPer100g'], equals(58.0));
      expect(json['proteinPer100g'], equals(2.0));
      expect(json['carbsPer100g'], equals(12.0));
      expect(json['fatPer100g'], equals(0.1));
      expect(json['fiberPer100g'], equals(0.8));
      expect(json['category'], equals('breakfast'));
      expect(json['isFavorite'], equals(true));
    });

    test('fromJson creates model from JSON correctly', () {
      final json = {
        'id': 'food_2',
        'name': 'Dosa',
        'caloriesPer100g': 168,
        'proteinPer100g': 3.5,
        'carbsPer100g': 28.0,
        'fatPer100g': 4.0,
        'fiberPer100g': 1.2,
        'category': 'breakfast',
        'isFavorite': false,
      };

      final model = FoodModel.fromJson(json);

      expect(model.id, equals('food_2'));
      expect(model.name, equals('Dosa'));
      expect(model.caloriesPer100g, equals(168.0));
      expect(model.proteinPer100g, equals(3.5));
      expect(model.carbsPer100g, equals(28.0));
      expect(model.fatPer100g, equals(4.0));
      expect(model.fiberPer100g, equals(1.2));
      expect(model.category, equals('breakfast'));
      expect(model.isFavorite, equals(false));
    });

    test('fromJson handles missing optional fields with defaults', () {
      final json = {
        'id': 'food_3',
        'name': 'Appam',
        'caloriesPer100g': 120,
        'proteinPer100g': 2.5,
        'carbsPer100g': 25.0,
        'fatPer100g': 1.0,
        'category': 'breakfast',
      };

      final model = FoodModel.fromJson(json);

      expect(model.fiberPer100g, equals(0.0));
      expect(model.isFavorite, equals(false));
    });

    test('fromJson handles integer values for double fields', () {
      final json = {
        'id': 'food_4',
        'name': 'Puttu',
        'caloriesPer100g': 130,
        'proteinPer100g': 3,
        'carbsPer100g': 27,
        'fatPer100g': 1,
        'fiberPer100g': 2,
        'category': 'breakfast',
        'isFavorite': true,
      };

      final model = FoodModel.fromJson(json);

      expect(model.caloriesPer100g, equals(130.0));
      expect(model.proteinPer100g, equals(3.0));
      expect(model.carbsPer100g, equals(27.0));
      expect(model.fatPer100g, equals(1.0));
      expect(model.fiberPer100g, equals(2.0));
    });

    test('JSON round-trip preserves all data', () {
      final original = FoodModel(
        id: 'food_5',
        name: 'Sambar',
        caloriesPer100g: 85.0,
        proteinPer100g: 4.5,
        carbsPer100g: 12.0,
        fatPer100g: 2.5,
        fiberPer100g: 3.0,
        category: 'lunch',
        isFavorite: true,
      );

      final json = original.toJson();
      final restored = FoodModel.fromJson(json);

      expect(restored.id, equals(original.id));
      expect(restored.name, equals(original.name));
      expect(restored.caloriesPer100g, equals(original.caloriesPer100g));
      expect(restored.proteinPer100g, equals(original.proteinPer100g));
      expect(restored.carbsPer100g, equals(original.carbsPer100g));
      expect(restored.fatPer100g, equals(original.fatPer100g));
      expect(restored.fiberPer100g, equals(original.fiberPer100g));
      expect(restored.category, equals(original.category));
      expect(restored.isFavorite, equals(original.isFavorite));
    });
  });

  group('FoodModel - Entity Conversion', () {
    test('fromEntity creates model from entity correctly', () {
      final entity = Food(
        id: 'food_6',
        name: 'Rasam',
        caloriesPer100g: 45.0,
        proteinPer100g: 1.5,
        carbsPer100g: 8.0,
        fatPer100g: 1.0,
        fiberPer100g: 1.5,
        category: 'lunch',
        isFavorite: false,
      );

      final model = FoodModel.fromEntity(entity);

      expect(model.id, equals(entity.id));
      expect(model.name, equals(entity.name));
      expect(model.caloriesPer100g, equals(entity.caloriesPer100g));
      expect(model.proteinPer100g, equals(entity.proteinPer100g));
      expect(model.carbsPer100g, equals(entity.carbsPer100g));
      expect(model.fatPer100g, equals(entity.fatPer100g));
      expect(model.fiberPer100g, equals(entity.fiberPer100g));
      expect(model.category, equals(entity.category));
      expect(model.isFavorite, equals(entity.isFavorite));
    });

    test('toEntity creates entity from model correctly', () {
      final model = FoodModel(
        id: 'food_7',
        name: 'Avial',
        caloriesPer100g: 95.0,
        proteinPer100g: 3.0,
        carbsPer100g: 10.0,
        fatPer100g: 5.0,
        fiberPer100g: 4.0,
        category: 'lunch',
        isFavorite: true,
      );

      final entity = model.toEntity();

      expect(entity.id, equals(model.id));
      expect(entity.name, equals(model.name));
      expect(entity.caloriesPer100g, equals(model.caloriesPer100g));
      expect(entity.proteinPer100g, equals(model.proteinPer100g));
      expect(entity.carbsPer100g, equals(model.carbsPer100g));
      expect(entity.fatPer100g, equals(model.fatPer100g));
      expect(entity.fiberPer100g, equals(model.fiberPer100g));
      expect(entity.category, equals(model.category));
      expect(entity.isFavorite, equals(model.isFavorite));
    });

    test('entity round-trip preserves all data', () {
      final originalEntity = Food(
        id: 'food_8',
        name: 'Thoran',
        caloriesPer100g: 75.0,
        proteinPer100g: 2.5,
        carbsPer100g: 8.0,
        fatPer100g: 3.5,
        fiberPer100g: 3.5,
        category: 'lunch',
        isFavorite: false,
      );

      final model = FoodModel.fromEntity(originalEntity);
      final restoredEntity = model.toEntity();

      expect(restoredEntity.id, equals(originalEntity.id));
      expect(restoredEntity.name, equals(originalEntity.name));
      expect(restoredEntity.caloriesPer100g, equals(originalEntity.caloriesPer100g));
      expect(restoredEntity.proteinPer100g, equals(originalEntity.proteinPer100g));
      expect(restoredEntity.carbsPer100g, equals(originalEntity.carbsPer100g));
      expect(restoredEntity.fatPer100g, equals(originalEntity.fatPer100g));
      expect(restoredEntity.fiberPer100g, equals(originalEntity.fiberPer100g));
      expect(restoredEntity.category, equals(originalEntity.category));
      expect(restoredEntity.isFavorite, equals(originalEntity.isFavorite));
    });
  });

  group('FoodModel - Edge Cases', () {
    test('handles zero nutritional values', () {
      final model = FoodModel(
        id: 'food_9',
        name: 'Water',
        caloriesPer100g: 0.0,
        proteinPer100g: 0.0,
        carbsPer100g: 0.0,
        fatPer100g: 0.0,
        fiberPer100g: 0.0,
        category: 'beverage',
        isFavorite: false,
      );

      final json = model.toJson();
      final restored = FoodModel.fromJson(json);

      expect(restored.caloriesPer100g, equals(0.0));
      expect(restored.proteinPer100g, equals(0.0));
      expect(restored.carbsPer100g, equals(0.0));
      expect(restored.fatPer100g, equals(0.0));
      expect(restored.fiberPer100g, equals(0.0));
    });

    test('handles high nutritional values', () {
      final model = FoodModel(
        id: 'food_10',
        name: 'Ghee',
        caloriesPer100g: 900.0,
        proteinPer100g: 0.3,
        carbsPer100g: 0.0,
        fatPer100g: 99.5,
        fiberPer100g: 0.0,
        category: 'fat',
        isFavorite: true,
      );

      final json = model.toJson();
      final restored = FoodModel.fromJson(json);

      expect(restored.caloriesPer100g, equals(900.0));
      expect(restored.fatPer100g, equals(99.5));
    });

    test('handles special characters in name', () {
      final model = FoodModel(
        id: 'food_11',
        name: 'Parippu Curry (Dal)',
        caloriesPer100g: 105.0,
        proteinPer100g: 7.0,
        carbsPer100g: 18.0,
        fatPer100g: 0.5,
        fiberPer100g: 5.0,
        category: 'lunch',
        isFavorite: false,
      );

      final json = model.toJson();
      final restored = FoodModel.fromJson(json);

      expect(restored.name, equals('Parippu Curry (Dal)'));
    });

    test('handles different category values', () {
      final categories = ['breakfast', 'lunch', 'dinner', 'snacks', 'beverage'];
      
      for (final category in categories) {
        final model = FoodModel(
          id: 'food_$category',
          name: 'Test Food',
          caloriesPer100g: 100.0,
          proteinPer100g: 5.0,
          carbsPer100g: 15.0,
          fatPer100g: 3.0,
          category: category,
        );

        final json = model.toJson();
        final restored = FoodModel.fromJson(json);

        expect(restored.category, equals(category));
      }
    });
  });
}
