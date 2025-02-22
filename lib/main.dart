import 'package:flutter/material.dart';
import 'package:todolistapp/screens/home_screen.dart';
import 'package:todolistapp/screens/todo_screen.dart';

// lancement de l'app -> Dart lance l'application Flutter
void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoList',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
