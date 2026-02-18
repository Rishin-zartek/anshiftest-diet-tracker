import 'package:flutter_test/flutter_test.dart';
import 'package:diet_tracker/data/models/meal_entry_model.dart';
import 'package:diet_tracker/domain/entities/meal_entry.dart';

void main() {
  group('MealEntryModel - JSON Serialization', () {
    test('toJson converts model to JSON correctly', () {
      final timestamp = DateTime(2024, 2, 12, 8, 30);
      final model = MealEntryModel(
        id: 'entry_1',
        foodId: 'food_1',
        foodName: 'Idli',
        quantity: 150.0,
        calories: 87.0,
        protein: 3.0,
        carbs: 18.0,
        fat: 0.15,
        mealType: 'breakfast',
        timestamp: timestamp,
        isRecipe: false,
      );

      final json = model.toJson();

      expect(json['id'], equals('entry_1'));
      expect(json['foodId'], equals('food_1'));
      expect(json['foodName'], equals('Idli'));
      expect(json['quantity'], equals(150.0));
      expect(json['calories'], equals(87.0));
      expect(json['protein'], equals(3.0));
      expect(json['carbs'], equals(18.0));
      expect(json['fat'], equals(0.15));
      expect(json['mealType'], equals('breakfast'));
      expect(json['timestamp'], equals(timestamp.toIso8601String()));
      expect(json['isRecipe'], equals(false));
    });

    test('fromJson creates model from JSON correctly', () {
      final timestampStr = '2024-02-12T12:00:00.000';
      final json = {
        'id': 'entry_2',
        'foodId': 'food_2',
        'foodName': 'Sambar Rice',
        'quantity': 250.0,
        'calories': 212.5,
        'protein': 11.25,
        'carbs': 30.0,
        'fat': 6.25,
        'mealType': 'lunch',
        'timestamp': timestampStr,
        'isRecipe': true,
      };

      final model = MealEntryModel.fromJson(json);

      expect(model.id, equals('entry_2'));
      expect(model.foodId, equals('food_2'));
      expect(model.foodName, equals('Sambar Rice'));
      expect(model.quantity, equals(250.0));
      expect(model.calories, equals(212.5));
      expect(model.protein, equals(11.25));
      expect(model.carbs, equals(30.0));
      expect(model.fat, equals(6.25));
      expect(model.mealType, equals('lunch'));
      expect(model.timestamp, equals(DateTime.parse(timestampStr)));
      expect(model.isRecipe, equals(true));
    });

    test('fromJson handles missing optional isRecipe field', () {
      final json = {
        'id': 'entry_3',
        'foodId': 'food_3',
        'foodName': 'Dosa',
        'quantity': 100.0,
        'calories': 168.0,
        'protein': 3.5,
        'carbs': 28.0,
        'fat': 4.0,
        'mealType': 'breakfast',
        'timestamp': '2024-02-12T08:00:00.000',
      };

      final model = MealEntryModel.fromJson(json);

      expect(model.isRecipe, equals(false));
    });

    test('fromJson handles integer values for double fields', () {
      final json = {
        'id': 'entry_4',
        'foodId': 'food_4',
        'foodName': 'Puttu',
        'quantity': 200,
        'calories': 260,
        'protein': 6,
        'carbs': 54,
        'fat': 2,
        'mealType': 'breakfast',
        'timestamp': '2024-02-12T07:30:00.000',
        'isRecipe': false,
      };

      final model = MealEntryModel.fromJson(json);

      expect(model.quantity, equals(200.0));
      expect(model.calories, equals(260.0));
      expect(model.protein, equals(6.0));
      expect(model.carbs, equals(54.0));
      expect(model.fat, equals(2.0));
    });

    test('JSON round-trip preserves all data', () {
      final timestamp = DateTime(2024, 2, 12, 19, 30);
      final original = MealEntryModel(
        id: 'entry_5',
        foodId: 'food_5',
        foodName: 'Avial',
        quantity: 180.0,
        calories: 171.0,
        protein: 5.4,
        carbs: 18.0,
        fat: 9.0,
        mealType: 'dinner',
        timestamp: timestamp,
        isRecipe: true,
      );

      final json = original.toJson();
      final restored = MealEntryModel.fromJson(json);

      expect(restored.id, equals(original.id));
      expect(restored.foodId, equals(original.foodId));
      expect(restored.foodName, equals(original.foodName));
      expect(restored.quantity, equals(original.quantity));
      expect(restored.calories, equals(original.calories));
      expect(restored.protein, equals(original.protein));
      expect(restored.carbs, equals(original.carbs));
      expect(restored.fat, equals(original.fat));
      expect(restored.mealType, equals(original.mealType));
      expect(restored.timestamp, equals(original.timestamp));
      expect(restored.isRecipe, equals(original.isRecipe));
    });
  });

  group('MealEntryModel - Entity Conversion', () {
    test('fromEntity creates model from entity correctly', () {
      final timestamp = DateTime(2024, 2, 12, 13, 0);
      final entity = MealEntry(
        id: 'entry_6',
        foodId: 'food_6',
        foodName: 'Thoran',
        quantity: 120.0,
        calories: 90.0,
        protein: 3.0,
        carbs: 9.6,
        fat: 4.2,
        mealType: MealType.lunch,
        timestamp: timestamp,
        isRecipe: false,
      );

      final model = MealEntryModel.fromEntity(entity);

      expect(model.id, equals(entity.id));
      expect(model.foodId, equals(entity.foodId));
      expect(model.foodName, equals(entity.foodName));
      expect(model.quantity, equals(entity.quantity));
      expect(model.calories, equals(entity.calories));
      expect(model.protein, equals(entity.protein));
      expect(model.carbs, equals(entity.carbs));
      expect(model.fat, equals(entity.fat));
      expect(model.mealType, equals('lunch'));
      expect(model.timestamp, equals(entity.timestamp));
      expect(model.isRecipe, equals(entity.isRecipe));
    });

    test('toEntity creates entity from model correctly', () {
      final timestamp = DateTime(2024, 2, 12, 16, 0);
      final model = MealEntryModel(
        id: 'entry_7',
        foodId: 'food_7',
        foodName: 'Banana Chips',
        quantity: 50.0,
        calories: 260.0,
        protein: 1.0,
        carbs: 30.0,
        fat: 15.0,
        mealType: 'snacks',
        timestamp: timestamp,
        isRecipe: false,
      );

      final entity = model.toEntity();

      expect(entity.id, equals(model.id));
      expect(entity.foodId, equals(model.foodId));
      expect(entity.foodName, equals(model.foodName));
      expect(entity.quantity, equals(model.quantity));
      expect(entity.calories, equals(model.calories));
      expect(entity.protein, equals(model.protein));
      expect(entity.carbs, equals(model.carbs));
      expect(entity.fat, equals(model.fat));
      expect(entity.mealType, equals(MealType.snacks));
      expect(entity.timestamp, equals(model.timestamp));
      expect(entity.isRecipe, equals(model.isRecipe));
    });

    test('entity round-trip preserves all data', () {
      final timestamp = DateTime(2024, 2, 12, 20, 0);
      final originalEntity = MealEntry(
        id: 'entry_8',
        foodId: 'food_8',
        foodName: 'Fish Curry',
        quantity: 200.0,
        calories: 240.0,
        protein: 30.0,
        carbs: 8.0,
        fat: 10.0,
        mealType: MealType.dinner,
        timestamp: timestamp,
        isRecipe: true,
      );

      final model = MealEntryModel.fromEntity(originalEntity);
      final restoredEntity = model.toEntity();

      expect(restoredEntity.id, equals(originalEntity.id));
      expect(restoredEntity.foodId, equals(originalEntity.foodId));
      expect(restoredEntity.foodName, equals(originalEntity.foodName));
      expect(restoredEntity.quantity, equals(originalEntity.quantity));
      expect(restoredEntity.calories, equals(originalEntity.calories));
      expect(restoredEntity.protein, equals(originalEntity.protein));
      expect(restoredEntity.carbs, equals(originalEntity.carbs));
      expect(restoredEntity.fat, equals(originalEntity.fat));
      expect(restoredEntity.mealType, equals(originalEntity.mealType));
      expect(restoredEntity.timestamp, equals(originalEntity.timestamp));
      expect(restoredEntity.isRecipe, equals(originalEntity.isRecipe));
    });

    test('converts all MealType enum values correctly', () {
      final timestamp = DateTime(2024, 2, 12, 12, 0);
      final mealTypes = [
        MealType.breakfast,
        MealType.lunch,
        MealType.dinner,
        MealType.snacks,
      ];

      for (final mealType in mealTypes) {
        final entity = MealEntry(
          id: 'entry_${mealType.name}',
          foodId: 'food_1',
          foodName: 'Test Food',
          quantity: 100.0,
          calories: 100.0,
          protein: 5.0,
          carbs: 15.0,
          fat: 3.0,
          mealType: mealType,
          timestamp: timestamp,
        );

        final model = MealEntryModel.fromEntity(entity);
        expect(model.mealType, equals(mealType.name));

        final restoredEntity = model.toEntity();
        expect(restoredEntity.mealType, equals(mealType));
      }
    });
  });

  group('MealEntryModel - Edge Cases', () {
    test('handles zero nutritional values', () {
      final timestamp = DateTime(2024, 2, 12, 10, 0);
      final model = MealEntryModel(
        id: 'entry_9',
        foodId: 'food_9',
        foodName: 'Water',
        quantity: 250.0,
        calories: 0.0,
        protein: 0.0,
        carbs: 0.0,
        fat: 0.0,
        mealType: 'snacks',
        timestamp: timestamp,
        isRecipe: false,
      );

      final json = model.toJson();
      final restored = MealEntryModel.fromJson(json);

      expect(restored.calories, equals(0.0));
      expect(restored.protein, equals(0.0));
      expect(restored.carbs, equals(0.0));
      expect(restored.fat, equals(0.0));
    });

    test('handles large quantity values', () {
      final timestamp = DateTime(2024, 2, 12, 12, 30);
      final model = MealEntryModel(
        id: 'entry_10',
        foodId: 'food_10',
        foodName: 'Rice',
        quantity: 500.0,
        calories: 650.0,
        protein: 13.0,
        carbs: 140.0,
        fat: 1.5,
        mealType: 'lunch',
        timestamp: timestamp,
        isRecipe: false,
      );

      final json = model.toJson();
      final restored = MealEntryModel.fromJson(json);

      expect(restored.quantity, equals(500.0));
      expect(restored.calories, equals(650.0));
    });

    test('handles fractional nutritional values', () {
      final timestamp = DateTime(2024, 2, 12, 15, 0);
      final model = MealEntryModel(
        id: 'entry_11',
        foodId: 'food_11',
        foodName: 'Coconut Chutney',
        quantity: 30.0,
        calories: 45.3,
        protein: 0.9,
        carbs: 2.7,
        fat: 3.6,
        mealType: 'breakfast',
        timestamp: timestamp,
        isRecipe: true,
      );

      final json = model.toJson();
      final restored = MealEntryModel.fromJson(json);

      expect(restored.calories, closeTo(45.3, 0.01));
      expect(restored.protein, closeTo(0.9, 0.01));
      expect(restored.carbs, closeTo(2.7, 0.01));
      expect(restored.fat, closeTo(3.6, 0.01));
    });

    test('handles different timestamp formats', () {
      final timestamps = [
        DateTime(2024, 1, 1, 0, 0, 0),
        DateTime(2024, 12, 31, 23, 59, 59),
        DateTime(2024, 6, 15, 12, 30, 45),
      ];

      for (final timestamp in timestamps) {
        final model = MealEntryModel(
          id: 'entry_${timestamp.millisecondsSinceEpoch}',
          foodId: 'food_1',
          foodName: 'Test Food',
          quantity: 100.0,
          calories: 100.0,
          protein: 5.0,
          carbs: 15.0,
          fat: 3.0,
          mealType: 'lunch',
          timestamp: timestamp,
        );

        final json = model.toJson();
        final restored = MealEntryModel.fromJson(json);

        expect(restored.timestamp, equals(timestamp));
      }
    });

    test('handles special characters in food name', () {
      final timestamp = DateTime(2024, 2, 12, 18, 0);
      final model = MealEntryModel(
        id: 'entry_12',
        foodId: 'food_12',
        foodName: 'Parippu Curry (Dal) - Homemade',
        quantity: 150.0,
        calories: 157.5,
        protein: 10.5,
        carbs: 27.0,
        fat: 0.75,
        mealType: 'dinner',
        timestamp: timestamp,
        isRecipe: true,
      );

      final json = model.toJson();
      final restored = MealEntryModel.fromJson(json);

      expect(restored.foodName, equals('Parippu Curry (Dal) - Homemade'));
    });
  });

  group('MealEntryModel - Integration Tests', () {
    test('complete flow: entity -> model -> JSON -> model -> entity', () {
      final timestamp = DateTime(2024, 2, 12, 14, 0);
      final originalEntity = MealEntry(
        id: 'entry_13',
        foodId: 'food_13',
        foodName: 'Chicken Biryani',
        quantity: 300.0,
        calories: 450.0,
        protein: 36.0,
        carbs: 54.0,
        fat: 12.0,
        mealType: MealType.lunch,
        timestamp: timestamp,
        isRecipe: true,
      );

      final model = MealEntryModel.fromEntity(originalEntity);
      final json = model.toJson();
      final restoredModel = MealEntryModel.fromJson(json);
      final restoredEntity = restoredModel.toEntity();

      expect(restoredEntity.id, equals(originalEntity.id));
      expect(restoredEntity.foodId, equals(originalEntity.foodId));
      expect(restoredEntity.foodName, equals(originalEntity.foodName));
      expect(restoredEntity.quantity, equals(originalEntity.quantity));
      expect(restoredEntity.calories, equals(originalEntity.calories));
      expect(restoredEntity.protein, equals(originalEntity.protein));
      expect(restoredEntity.carbs, equals(originalEntity.carbs));
      expect(restoredEntity.fat, equals(originalEntity.fat));
      expect(restoredEntity.mealType, equals(originalEntity.mealType));
      expect(restoredEntity.timestamp, equals(originalEntity.timestamp));
      expect(restoredEntity.isRecipe, equals(originalEntity.isRecipe));
    });
  });
}
