import 'package:flutter/material.dart';
class Preuzimanje extends ChangeNotifier {

  bool preuzeto = true;

  void togglePreuzimanje() {
    preuzeto = !preuzeto;
    notifyListeners();
  }
}