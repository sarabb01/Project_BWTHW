import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PointsModel extends ChangeNotifier {
  double totalScore = 0;

  void updateScore(double input) {
    totalScore = input;

    notifyListeners();
  }

  void subtractScore(double input) {
    totalScore = totalScore - input;
    notifyListeners();
  }
}
