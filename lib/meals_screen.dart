import 'package:calorie_tracker/model/meal.dart';
import 'package:calorie_tracker/widgets/empty_list.dart';
import 'package:calorie_tracker/widgets/meals_list.dart';
import 'package:calorie_tracker/widgets/new_meal.dart';
import 'package:flutter/material.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final List<Meal> _meals = [
    Meal(
      description: "Milk with cereal",
      calories: 200,
      date: DateTime.now(),
      type: MealType.breakfast,
    ),
    Meal(
      description: "Pizza",
      calories: 400,
      date: DateTime.now(),
      type: MealType.luch,
    )
  ];

  void _openSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return NewMeal(onAddMeal: _addMeal);
        });
  }

  void _addMeal(Meal meal) {
    setState(() {
      _meals.add(meal);
    });
  }

  void _restoreMeal(index, meal) {
    setState(() => _meals.insert(index, meal));
  }

  void _removeMeal(Meal meal) {
    final index = _meals.indexOf(meal);
    setState(() => _meals.removeAt(index));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Meal removed'),
      duration: const Duration(seconds: 6),
      action: SnackBarAction(
        label: 'Cancel',
        onPressed: () => _restoreMeal(index, meal),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _meals.isEmpty
        ? const EmptyList('Add your first meal')
        : MealsList(_meals, onRemove: _removeMeal);

    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie tracker'),
        actions: [
          IconButton(onPressed: _openSheet, icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}
