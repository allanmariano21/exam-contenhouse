import 'package:flutter/material.dart';

import 'package:mobile_exam/screens/home/main.dart' as home;
import 'package:mobile_exam/screens/hint_1/main.dart' as hint_1;
import 'package:mobile_exam/screens/hint_2/main.dart' as hint_2;
import 'package:mobile_exam/screens/exam/main.dart' as exam;

extension Extension on BuildContext {
  Map<String, Widget Function(BuildContext)> get screens => Screens().routes;
}

class Screens {
  final routes = <String, Widget Function(BuildContext)>{
    "/": (context) => const home.Screen(),
    "/home": (context) => const home.Screen(),
    "/hint_1": (context) => const hint_1.Screen(),
    "/hint_2": (context) => const hint_2.Screen(),
    "/exam": (context) => const exam.Screen(),
  };
}
