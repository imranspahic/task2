import 'package:flutter/material.dart';
import 'package:task2/providers/preuzimanje.dart';
import './home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Preuzimanje(),
          child: MaterialApp(
        title: 'Task2',
        home: HomeScreen(),
      ),
    );
  }
}
