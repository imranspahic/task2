import 'package:flutter/material.dart';
import 'package:task2/providers/preuzimanje.dart';
import './home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './models/AudioModel.dart';
// import './models/PermissionModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(SecondTask());
}

class SecondTask extends StatefulWidget {
  @override
  _SecondTaskState createState() => _SecondTaskState();
}

class _SecondTaskState extends State<SecondTask> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppFunctions()),
        ChangeNotifierProvider.value(value: Preuzimanje()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}