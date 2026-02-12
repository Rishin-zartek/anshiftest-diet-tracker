import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meal_entry.dart';
import '../providers/providers.dart';
import '../screens/add_food_screen.dart';

class MealCardWidget extends ConsumerStatefulWidget {
  final MealType mealType;
  final List<MealEntry> meals;
  final DateTime date;

  const MealCardWidget({
    super.key,
    required this.mealType,
    required this.meals,
    required this.date,
  });

  @override
  ConsumerState<MealCardWidget> createState() => _MealCardWidgetState();
}

class _MealCardWidgetState extends ConsumerState<MealCardWidget> {
  bool _isExpanded = false;

  String get _mealTitle {
    switch (widget.mealType) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
      case MealType.snacks:
        return 'Snacks';
    }
  }

  IconData get _mealIcon {
    switch (widget.mealType) {
      case MealType.breakfast:
        return Icons.free_breakfast;
      case MealType.lunch:
        return Icons.lunch_dining;
      case MealType.dinner:
        return Icons.dinner_dining;
      case MealType.snacks:
        return Icons.fastfood;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalCalories = widget.meals.fold<double>(0, (sum, meal) => sum + meal.calories);

    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(_mealIcon, color: Theme.of(context).colorScheme.primary),
            title: Text(_mealTitle),
            subtitle: Text('${totalCalories.toInt()} cal'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddFoodScreen(
                          date: widget.date,
                          mealType: widget.mealType,
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ],
            ),
          ),
          if (_isExpanded && widget.meals.isNotEmpty)
            ...widget.meals.map((meal) => ListTile(
              title: Text(meal.foodName),
              subtitle: Text('${meal.quantity.toInt()}g'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${meal.calories.toInt()} cal'),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Meal'),
                          content: const Text('Are you sure you want to delete this meal entry?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        final repository = ref.read(logRepositoryProvider);
                        await repository.removeMealEntry(widget.date, meal.id);
                        ref.invalidate(dailyLogProvider);
                      }
                    },
                  ),
                ],
              ),
            )),
          if (_isExpanded && widget.meals.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No meals added yet'),
            ),
        ],
      ),
    );
  }
}
