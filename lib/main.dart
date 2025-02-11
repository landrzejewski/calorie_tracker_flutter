import 'package:calorie_tracker/meals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var lightScheme = ColorScheme.fromSeed(seedColor: Colors.lightBlue);
var darkScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: darkScheme,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: darkScheme.onPrimaryContainer,
            foregroundColor: darkScheme.primaryContainer,
            centerTitle: true),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  color: darkScheme.onSecondaryContainer, fontSize: 16),
            ),
        cardTheme: const CardTheme().copyWith(
          color: darkScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: darkScheme.primaryContainer),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: lightScheme,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: lightScheme.onPrimaryContainer,
            foregroundColor: lightScheme.primaryContainer,
            centerTitle: true),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  color: lightScheme.onSecondaryContainer, fontSize: 16),
            ),
        cardTheme: const CardTheme().copyWith(
          color: lightScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: lightScheme.primaryContainer),
        ),
      ),
      home: MealsScreen(),
    );
  }
}
