import 'package:flutter/material.dart';
import 'package:mentor_app/screens/account_tab/account_screen.dart';
import 'package:mentor_app/screens/calender_tab/calender_screen.dart';
import 'package:mentor_app/screens/call_tab/call_screen.dart';
import 'package:mentor_app/screens/change_password/change_password_screen.dart';
import 'package:mentor_app/screens/edit_experience/edit_experience_screen.dart';
import 'package:mentor_app/screens/edit_profile/edit_profile_screen.dart';
import 'package:mentor_app/screens/event_details/event_details_screen.dart';
import 'package:mentor_app/screens/forgot_password/forgot_password_confirmation_screen.dart';
import 'package:mentor_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:mentor_app/screens/home_tab/home_screen.dart';
import 'package:mentor_app/screens/invite_friends/invite_friends_screen.dart';
import 'package:mentor_app/screens/login_screen/login_screen.dart';
import 'package:mentor_app/screens/main_contaner/main_container.dart';
import 'package:mentor_app/screens/notifications/notifications_screen.dart';
import 'package:mentor_app/screens/payments_tab/payments_screen.dart';
import 'package:mentor_app/screens/rate_per_hour/rate_per_hour_screen.dart';
import 'package:mentor_app/screens/register_screen/register_fase_2/register_fase2_screen.dart';
import 'package:mentor_app/screens/register_screen/register_fase_3/register_fase3_screen.dart';
import 'package:mentor_app/screens/register_screen/register_fase_4/register_fase4_screen.dart';
import 'package:mentor_app/screens/register_screen/register_fase_5/register_fase5_screen.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/register_fase6_screen.dart';
import 'package:mentor_app/screens/register_screen/register_fase_7/register_fase7_screen.dart';
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
  static const String callScreen = 'callScreen';
  static const String calenderScreen = 'calenderScreen';
  static const String accountScreen = 'accountScreen';
  static const String registerfaze2Screen = 'registerfaze2Screen';
  static const String registerfaze3Screen = 'registerfaze3Screen';
  static const String registerfaze4Screen = 'registerfaze4Screen';
  static const String registerfaze5Screen = 'registerfaze5Screen';
  static const String registerfaze6Screen = 'registerfaze6Screen';
  static const String registerfaze7Screen = 'registerfaze7Screen';

  static const String notificationsScreen = 'notificationsScreen';
  static const String webViewScreen = 'webViewScreen';
  static const String inviteFriendScreen = 'inviteFriendScreen';
  static const String tutorialsScreen = 'tutorialsScreen';
  static const String changePasswordScreen = 'changePasswordScreen';
  static const String editProfileScreen = 'editProfileScreen';
  static const String editExperienceScreen = 'editExperienceScreen';
  static const String workingHoursScreen = 'workingHoursScreen';
  static const String ratePerHourScreen = 'ratePerHourScreen';

  static const String paymentsScreen = 'paymentsScreen';
  static const String forgotPasswordScreen = 'forgotPasswordScreen';
  static const String eventDetailsScreen = 'eventDetailsScreen';
  static const String forgotPasswordConfirmationScreen = 'forgotPasswordConfirmationScreen';
  static const String chatScreen = 'chatScreen';
}

final Map<String, Widget> routes = {
  RoutesConstants.initialRoute: const SetupScreen(),
  RoutesConstants.loginScreen: const LoginScreen(),
  RoutesConstants.mainContainer: const MainContainer(),
  RoutesConstants.homeScreen: const HomeScreen(),
  RoutesConstants.callScreen: const CallScreen(),
  RoutesConstants.calenderScreen: const CalenderScreen(),
  RoutesConstants.accountScreen: const AccountScreen(),
  RoutesConstants.registerfaze2Screen: const RegisterFaze2Screen(),
  RoutesConstants.registerfaze3Screen: const RegisterFaze3Screen(),
  RoutesConstants.registerfaze4Screen: const RegisterFaze4Screen(),
  RoutesConstants.registerfaze5Screen: const RegisterFaze5Screen(),
  RoutesConstants.registerfaze6Screen: const RegisterFaze6Screen(),
  RoutesConstants.registerfaze7Screen: const RegisterFaze7Screen(),
  RoutesConstants.notificationsScreen: const NotificationsScreen(),
  RoutesConstants.webViewScreen: const WebViewScreen(),
  RoutesConstants.inviteFriendScreen: const InviteFriendsScreen(),
  RoutesConstants.reportScreen: const ReportScreen(),
  RoutesConstants.tutorialsScreen: const TutorialsScreen(),
  RoutesConstants.changePasswordScreen: const ChangePasswordScreen(),
  RoutesConstants.editProfileScreen: const EditProfileScreen(),
  RoutesConstants.editExperienceScreen: const EditExperienceScreen(),
  RoutesConstants.workingHoursScreen: const WorkingHoursScreen(),
  RoutesConstants.ratePerHourScreen: const RatePerHourScreen(),
  RoutesConstants.paymentsScreen: const PaymentsScreen(),
  RoutesConstants.forgotPasswordScreen: const ForgotPasswordScreen(),
  RoutesConstants.forgotPasswordConfirmationScreen: const ForgotPasswordConfirmationScreen(),
  RoutesConstants.eventDetailsScreen: const EventDetailsScreen(),
};
