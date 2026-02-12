import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodsAsync = ref.watch(allFoodsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Foods'),
      ),
      body: foodsAsync.when(
        data: (foods) {
          final categories = foods.map((f) => f.category).toSet().toList();
          
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final categoryFoods = foods.where((f) => f.category == category).toList();
              
              return ExpansionTile(
                title: Text(category.toUpperCase()),
                subtitle: Text('${categoryFoods.length} items'),
                children: categoryFoods.map((food) {
                  return ListTile(
                    title: Text(food.name),
                    subtitle: Text(
                      'Cal: ${food.caloriesPer100g.toInt()} | '
                      'P: ${food.proteinPer100g.toInt()}g | '
                      'C: ${food.carbsPer100g.toInt()}g | '
                      'F: ${food.fatPer100g.toInt()}g'
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
