import 'package:flutter/material.dart';
import 'package:mentor_app/screens/account_tab/account_screen.dart';
import 'package:mentor_app/screens/calender_tab/calender_screen.dart';
import 'package:mentor_app/screens/call_tab/call_screen.dart';
import 'package:mentor_app/screens/home_tab/home_screen.dart';
import 'package:mentor_app/screens/main_contaner/main_container.dart';
import 'package:mentor_app/screens/messages_tab/messages_screen.dart';
import 'package:mentor_app/screens/setup_screen/setup_screen.dart';

class RoutesConstants {
  static const String initialRoute = 'initScreen';
  static const String mainContainer = 'mainContainer';
  static const String homeScreen = 'homeScreen';
  static const String messagesScreen = 'messagesScreen';
  static const String callScreen = 'callScreen';
  static const String calenderScreen = 'calenderScreen';
  static const String accountScreen = 'accountScreen';
}

final Map<String, Widget> routes = {
  RoutesConstants.initialRoute: const SetupScreen(),
  RoutesConstants.mainContainer: const MainContainer(),
  RoutesConstants.homeScreen: const HomeScreen(),
  RoutesConstants.messagesScreen: const MessagesScreen(),
  RoutesConstants.callScreen: const CallScreen(),
  RoutesConstants.calenderScreen: const CalenderScreen(),
  RoutesConstants.accountScreen: const AccountScreen(),
};
