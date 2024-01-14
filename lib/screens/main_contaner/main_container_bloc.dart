import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:mentor_app/screens/main_contaner/widgets/tab_navigator.dart';
import 'package:mentor_app/services/appointments_service.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/routes.dart';

enum SelectedTab { home, payment, call, calender, account }

class MainContainerBloc extends Bloc<AppointmentsService> {
  final ValueNotifier<SelectedTab> currentTabIndexNotifier =
      ValueNotifier<SelectedTab>(SelectedTab.home);

  GlobalKey<ConvexAppBarState> appBarKey = GlobalKey<ConvexAppBarState>();

  List<TabNavigator> navTabs = const [
    TabNavigator(initialRoute: RoutesConstants.homeScreen),
    TabNavigator(initialRoute: RoutesConstants.paymentsScreen),
    TabNavigator(initialRoute: RoutesConstants.callScreen),
    TabNavigator(initialRoute: RoutesConstants.calenderScreen),
    TabNavigator(initialRoute: RoutesConstants.accountScreen)
  ];

  SelectedTab returnSelectedtypeDependOnIndex(int index) {
    switch (index) {
      case 0:
        return SelectedTab.home;
      case 1:
        return SelectedTab.payment;
      case 2:
        return SelectedTab.call;
      case 3:
        return SelectedTab.calender;
      default:
        return SelectedTab.account;
    }
  }

  int getSelectedIndexDependOnTab(SelectedTab tab) {
    switch (tab) {
      case SelectedTab.home:
        return 0;
      case SelectedTab.payment:
        return 1;
      case SelectedTab.call:
        return 2;
      case SelectedTab.calender:
        return 3;
      case SelectedTab.account:
        return 4;
      default:
        return 0;
    }
  }

  @override
  onDispose() {}
}
