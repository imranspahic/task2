import 'package:flutter/material.dart';
import 'screens/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:task2np/models/AudioModel.dart';
import 'models/PermissionModel.dart';

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
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
