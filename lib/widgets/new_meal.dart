import 'dart:io';

import 'package:calorie_tracker/model/meal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMEd();

class NewMeal extends StatefulWidget {
  const NewMeal({super.key, required this.onAddMeal});

  final void Function(Meal meal) onAddMeal;

  @override
  State<NewMeal> createState() => _NewMealState();
}

class _NewMealState extends State<NewMeal> {
  // var _description = '';
  // void _onDescriptionChange(String value) {
  //   _description = value;
  // }

  final _descriptionController = TextEditingController();
  final _caloriesController = TextEditingController();
  DateTime? _selectedDate;
  MealType _selectedType = MealType.other;

  void _showDatePicker() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1, now.month, now.day);
    final selectedDate = await showDatePicker(
        context: context, initialDate: now, firstDate: first, lastDate: now);
    //.then((value) =(value));
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void _selectMealType(mealType) {
    setState(() {
      if (mealType == null) {
        return;
      }
      _selectedType = mealType;
    });
  }

  void _addMeal() {
    final description = _descriptionController.text.trim();
    final isDescriptionValid = description.isNotEmpty;
    final calories = int.tryParse(_caloriesController.text);
    final isCaloriesValid = calories != null && calories > 0;
    final isDateValid = _selectedDate != null;
    if (!isDescriptionValid || !isCaloriesValid || !isDateValid) {
      if (Platform.isIOS) {
        showCupertinoDialog(
            context: context,
            builder: (ctx) => CupertinoAlertDialog(
                  title: const Text('Invalid data'),
                  content: const Text(
                      'Please ensure that provided meal data is correct'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text("Close"))
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Invalid data'),
                  content: const Text(
                      'Please ensure that provided meal data is correct'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text("Close"))
                  ],
                ));
      }
      return;
    }
    widget.onAddMeal(Meal(
        description: description, calories: calories, date: _selectedDate!));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _descriptionController.dispose(); // requied
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;

    // LayoutBuilder(builder: (context, constraints) {
    //   print(constraints.maxWidth)
    //   return Text('Hello');
    // });

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(32, 16, 32, keyboardHeight + 16),
        child: Column(
          children: [
            TextField(
              // onChanged: _onDescriptionChange,
              controller: _descriptionController,
              maxLength: 20,
              decoration: const InputDecoration(label: Text('Description')),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _caloriesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text('Calories'), suffix: Text('cal')),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? "Meal date"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _showDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ))
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                DropdownButton(
                    value: _selectedType,
                    items: MealType.values
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item.name.toUpperCase(),
                              ),
                            ))
                        .toList(),
                    onChanged: _selectMealType),
                const Spacer(),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
                const SizedBox(width: 16),
                ElevatedButton(onPressed: _addMeal, child: Text("Add"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
