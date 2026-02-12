import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/meal_entry.dart';
import '../providers/providers.dart';

class AddFoodScreen extends ConsumerStatefulWidget {
  final DateTime date;
  final MealType? mealType;

  const AddFoodScreen({
    super.key,
    required this.date,
    this.mealType,
  });

  @override
  ConsumerState<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends ConsumerState<AddFoodScreen> {
  final _quantityController = TextEditingController(text: '100');
  MealType? _selectedMealType;

  @override
  void initState() {
    super.initState();
    _selectedMealType = widget.mealType ?? MealType.breakfast;
  }

  @override
  Widget build(BuildContext context) {
    final foodsAsync = ref.watch(filteredFoodsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search foods',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    ref.read(foodSearchQueryProvider.notifier).state = value;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<MealType>(
                  value: _selectedMealType,
                  decoration: const InputDecoration(
                    labelText: 'Meal Type',
                  ),
                  items: MealType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMealType = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: foodsAsync.when(
              data: (foods) {
                if (foods.isEmpty) {
                  return const Center(child: Text('No foods found'));
                }
                return ListView.builder(
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return ListTile(
                      title: Text(food.name),
                      subtitle: Text('${food.caloriesPer100g.toInt()} cal per 100g'),
                      trailing: const Icon(Icons.add_circle_outline),
                      onTap: () async {
                        final quantity = await showDialog<double>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Add ${food.name}'),
                            content: TextField(
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Quantity (grams)',
                                suffixText: 'g',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  final qty = double.tryParse(_quantityController.text) ?? 100;
                                  Navigator.pop(context, qty);
                                },
                                child: const Text('Add'),
                              ),
                            ],
                          ),
                        );

                        if (quantity != null && _selectedMealType != null) {
                          final multiplier = quantity / 100;
                          final meal = MealEntry(
                            id: const Uuid().v4(),
                            foodId: food.id,
                            foodName: food.name,
                            quantity: quantity,
                            calories: food.caloriesPer100g * multiplier,
                            protein: food.proteinPer100g * multiplier,
                            carbs: food.carbsPer100g * multiplier,
                            fat: food.fatPer100g * multiplier,
                            mealType: _selectedMealType!,
                            timestamp: DateTime.now(),
                          );

                          final repository = ref.read(logRepositoryProvider);
                          await repository.addMealEntry(widget.date, meal);
                          ref.invalidate(dailyLogProvider);

                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
