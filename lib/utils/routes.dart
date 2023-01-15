import 'package:flutter/material.dart';
import 'package:mentor_app/screens/account_tab/account_screen.dart';
import 'package:mentor_app/screens/calender_tab/calender_screen.dart';
import 'package:mentor_app/screens/call_tab/call_screen.dart';
import 'package:mentor_app/screens/change_password/change_password_screen.dart';
import 'package:mentor_app/screens/home_tab/home_screen.dart';
import 'package:mentor_app/screens/invite_friends/invite_friends_screen.dart';
import 'package:mentor_app/screens/login_screen/login_screen.dart';
import 'package:mentor_app/screens/main_contaner/main_container.dart';
import 'package:mentor_app/screens/messages_tab/messages_screen.dart';
import 'package:mentor_app/screens/notifications/notifications_screen.dart';
import 'package:mentor_app/screens/register_screen/register_screen.dart';
import 'package:mentor_app/screens/report/report_screen.dart';
import 'package:mentor_app/screens/setup_screen/setup_screen.dart';
import 'package:mentor_app/screens/tutorials/tutorials_screen.dart';
import 'package:mentor_app/screens/web_view/web_view_screen.dart';

class RoutesConstants {
  static const String initialRoute = 'initScreen';
  static const String loginScreen = 'loginScreen';
  static const String reportScreen = 'reportScreen';
  static const String mainContainer = 'mainContainer';
  static const String homeScreen = 'homeScreen';
  static const String messagesScreen = 'messagesScreen';
  static const String callScreen = 'callScreen';
  static const String calenderScreen = 'calenderScreen';
  static const String accountScreen = 'accountScreen';
  static const String registerScreen = 'registerScreen';
  static const String notificationsScreen = 'notificationsScreen';
  static const String webViewScreen = 'webViewScreen';
  static const String inviteFriendScreen = 'inviteFriendScreen';
  static const String tutorialsScreen = 'tutorialsScreen';
  static const String changePasswordScreen = 'changePasswordScreen';
}

final Map<String, Widget> routes = {
  RoutesConstants.initialRoute: const SetupScreen(),
  RoutesConstants.loginScreen: const LoginScreen(),
  RoutesConstants.mainContainer: const MainContainer(),
  RoutesConstants.homeScreen: const HomeScreen(),
  RoutesConstants.messagesScreen: const MessagesScreen(),
  RoutesConstants.callScreen: const CallScreen(),
  RoutesConstants.calenderScreen: const CalenderScreen(),
  RoutesConstants.accountScreen: const AccountScreen(),
  RoutesConstants.registerScreen: const RegisterScreen(),
  RoutesConstants.notificationsScreen: const NotificationsScreen(),
  RoutesConstants.webViewScreen: const WebViewScreen(),
  RoutesConstants.inviteFriendScreen: const InviteFriendsScreen(),
  RoutesConstants.reportScreen: const ReportScreen(),
  RoutesConstants.tutorialsScreen: const TutorialsScreen(),
  RoutesConstants.changePasswordScreen: const ChangePasswordScreen(),
};
