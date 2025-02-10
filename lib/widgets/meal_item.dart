import 'package:calorie_tracker/model/meal.dart';
import 'package:flutter/material.dart';

const icons = {
  MealType.breakfast: Icons.breakfast_dining,
  MealType.luch: Icons.lunch_dining,
  MealType.supper: Icons.outdoor_grill_sharp,
  MealType.other: Icons.bakery_dining_sharp,
};

class MealItem extends StatelessWidget {
  const MealItem(this._meal, {super.key});
  final Meal _meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(_meal.description,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('${_meal.calories} cal'),
                Spacer(),
                Row(children: [
                  Text(_meal.formattedDate),
                  const SizedBox(
                    width: 8,
                  ),
                  Icon(icons[_meal.type])
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
