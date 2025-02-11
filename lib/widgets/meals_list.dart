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

/*
In **Flutter**, a **Key** is an identifier used to differentiate and manage widgets efficiently in the 
widget tree. It helps Flutter determine whether a widget should be recreated or updated when the UI is rebuilt.

### **Why Use Keys?**
Flutter uses a **widget tree reconciliation process** (also called the "element tree") to 
determine which widgets should be kept, removed, or replaced. When Flutter rebuilds a widget 
tree, it matches widgets **based on their runtime type and position**. However, if 
widgets move around (e.g., in a `ListView` with reordered items), Flutter may not 
correctly identify them. Keys help in such cases by giving a **stable identity** 
to widgets across rebuilds.

---

### **Types of Keys in Flutter**
Flutter provides three main types of keys:

1. **GlobalKey**  
   - Unique across the entire app.
   - Retains widget state when moved.
   - Useful for accessing widget state from outside the widget tree.

   ```dart
   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   Form(
     key: formKey,
     child: TextFormField(),
   );
   ```

2. **LocalKey (Abstract Class)**
   - Used within a part of the widget tree.
   - Two types: `ValueKey` and `ObjectKey`.

   - **ValueKey**
     - Uses a specific value to differentiate widgets.
     - Best for immutable data like an ID in a list.

     ```dart
     ListView(
       children: items.map((item) => ListTile(
         key: ValueKey(item.id),
         title: Text(item.name),
       )).toList(),
     );
     ```

   - **ObjectKey**
     - Uses the object's identity instead of a simple value.
     - Useful when objects might have the same value but are different instances.

     ```dart
     ListTile(
       key: ObjectKey(myObject),
       title: Text(myObject.name),
     );
     ```

3. **UniqueKey**
   - Generates a new key every time it's created.
   - Prevents Flutter from reusing a widget and forces a rebuild.

   ```dart
   ListView(
     children: List.generate(10, (index) {
       return ListTile(
         key: UniqueKey(),
         title: Text('Item $index'),
       );
     }),
   );
   ```

---

### **When to Use Keys?**
- **In lists**: To keep track of items when they move or change.
- **When preserving state**: If you want to retain the state of a widget after reordering or replacing.
- **In animations**: Helps Flutter correctly match widgets between frames.

---

### **When Not to Use Keys?**
- When widgets are static and don't move or change dynamically.
- If there is no need to preserve the state of a widget between rebuilds.
*/
