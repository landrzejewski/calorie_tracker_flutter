import 'package:calorie_tracker/model/meal.dart';
import 'package:calorie_tracker/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class MealsList extends StatelessWidget {
  const MealsList(this._meals, {super.key, required this.onRemove});
  final List<Meal> _meals;
  final void Function(Meal) onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _meals.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(_meals[index].id),
          onDismissed: (direction) => onRemove(_meals[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withAlpha(80),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
          ),
          child: MealItem(_meals[index]),
        );
      },
    );
  }
}
