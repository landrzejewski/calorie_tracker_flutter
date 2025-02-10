import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMEd();

class Meal {
  Meal({
    required this.description,
    required this.calories,
    required this.date,
    this.type = MealType.other,
  }) : id = uuid.v7();

  final String id;
  final String description;
  final int calories;
  final DateTime date;
  final MealType type;

  String get formattedDate {
    return formatter.format(date);
  }
}

enum MealType { breakfast, luch, supper, other }
