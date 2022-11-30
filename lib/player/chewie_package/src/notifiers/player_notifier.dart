import 'dart:async';

import 'package:flutter/material.dart';

///
/// The new State-Manager for Chewie!
/// Has to be an instance of Singleton to survive
/// over all State-Changes inside chewie
///
class PlayerNotifier extends ChangeNotifier {

  bool waterMark = false;
  Timer _timer;
  int _start = 0;

  watermarkTimerFun(){
    Timer.periodic(
      Duration(seconds: 30),
          (Timer timer) {
          if (_start == 0) {
            //timer.cancel();
            waterMark = !waterMark;
            _start = 60;
          } else {
            _start--;
            //if(_start == 15) waterMark = !waterMark;
          }
      },
    );
  }


  PlayerNotifier._(
    bool hideStuff,
  ) : _hideStuff = hideStuff;

  bool _hideStuff;

  bool get hideStuff => _hideStuff;

  set hideStuff(bool value) {
    _hideStuff = value;
    notifyListeners();
  }

  // ignore: prefer_constructors_over_static_methods
  static PlayerNotifier init() {
    return PlayerNotifier._(
      true,
    );
  }
}
