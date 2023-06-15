import 'package:flutter/material.dart';
import 'package:tiempo_app/src/ui/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Tiempo',
      home: HomeScreen(),
    );
  }
}
