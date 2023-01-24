import 'package:flutter/material.dart';
import 'package:mentor_app/screens/account_tab/account_screen.dart';
import 'package:mentor_app/screens/calender_tab/calender_screen.dart';
import 'package:mentor_app/screens/call_tab/call_screen.dart';
import 'package:mentor_app/screens/change_password/change_password_screen.dart';
import 'package:mentor_app/screens/edit_experience/edit_experience_screen.dart';
import 'package:mentor_app/screens/edit_profile/edit_profile_screen.dart';
import 'package:mentor_app/screens/event_details/event_details_screen.dart';
import 'package:mentor_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:mentor_app/screens/home_tab/home_screen.dart';
import 'package:mentor_app/screens/invite_friends/invite_friends_screen.dart';
import 'package:mentor_app/screens/login_screen/login_screen.dart';
import 'package:mentor_app/screens/main_contaner/main_container.dart';
import 'package:mentor_app/screens/messages_tab/messages_screen.dart';
import 'package:mentor_app/screens/notifications/notifications_screen.dart';
import 'package:mentor_app/screens/payments/payments_screen.dart';
import 'package:mentor_app/screens/register_screen/register_fase2_screen.dart';
import 'package:mentor_app/screens/register_screen/register_fase3_screen.dart';
import 'package:mentor_app/screens/report/report_screen.dart';
import 'package:mentor_app/screens/setup_screen/setup_screen.dart';
import 'package:mentor_app/screens/tutorials/tutorials_screen.dart';
import 'package:mentor_app/screens/web_view/web_view_screen.dart';
import 'package:mentor_app/screens/working_hours/working_hours_screen.dart';

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
  static const String registerfaze2Screen = 'registerfaze2Screen';
  static const String registerfaze3Screen = 'registerfaze3Screen';

  static const String notificationsScreen = 'notificationsScreen';
  static const String webViewScreen = 'webViewScreen';
  static const String inviteFriendScreen = 'inviteFriendScreen';
  static const String tutorialsScreen = 'tutorialsScreen';
  static const String changePasswordScreen = 'changePasswordScreen';
  static const String editProfileScreen = 'editProfileScreen';
  static const String editExperienceScreen = 'editExperienceScreen';
  static const String workingHoursScreen = 'workingHoursScreen';
  static const String paymentsScreen = 'paymentsScreen';
  static const String forgotPasswordScreen = 'forgotPasswordScreen';
  static const String eventDetailsScreen = 'eventDetailsScreen';
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
  RoutesConstants.registerfaze2Screen: const RegisterFaze2Screen(),
  RoutesConstants.registerfaze3Screen: const RegisterFaze3Screen(),
  RoutesConstants.notificationsScreen: const NotificationsScreen(),
  RoutesConstants.webViewScreen: const WebViewScreen(),
  RoutesConstants.inviteFriendScreen: const InviteFriendsScreen(),
  RoutesConstants.reportScreen: const ReportScreen(),
  RoutesConstants.tutorialsScreen: const TutorialsScreen(),
  RoutesConstants.changePasswordScreen: const ChangePasswordScreen(),
  RoutesConstants.editProfileScreen: const EditProfileScreen(),
  RoutesConstants.editExperienceScreen: const EditExperienceScreen(),
  RoutesConstants.workingHoursScreen: const WorkingHoursScreen(),
  RoutesConstants.paymentsScreen: const PaymentsScreen(),
  RoutesConstants.forgotPasswordScreen: const ForgotPasswordScreen(),
  RoutesConstants.eventDetailsScreen: const EventDetailsScreen(),
};
