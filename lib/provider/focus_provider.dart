import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class FocusProvider extends ChangeNotifier {
  bool _isFocusing = false;
  final int totalDuration = 30 * 60;
  final CountDownController countDownController = CountDownController();

  bool get isFocusing => _isFocusing;

  void startFocusing() {
    _isFocusing = true;
    countDownController.restart(duration: totalDuration);
    notifyListeners();
  }

  void stopFocusing() {
    _isFocusing = false;
    countDownController.reset();
    notifyListeners();
  }

  void onTimerComplete(){
    _isFocusing = false;
    notifyListeners();
  }
}