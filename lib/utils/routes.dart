import 'package:flutter/material.dart';
import 'package:mentor_app/screens/main_contaner/main_container.dart';
import 'package:mentor_app/screens/setup_screen/setup_screen.dart';

class RoutesConstants {
  static const String initialRoute = 'initScreen';
  static const String mainContainer = 'mainContainer';
}

final Map<String, Widget> routes = {
  RoutesConstants.initialRoute: const SetupScreen(),
  RoutesConstants.mainContainer: const MainContainer(),
};
