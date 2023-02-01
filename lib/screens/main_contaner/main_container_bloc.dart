import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/calender_model.dart';
import 'package:mentor_app/screens/main_contaner/widgets/tab_navigator.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/routes.dart';

enum SelectedTab { home, messages, call, calender, account }

class MainContainerBloc {
  final ValueNotifier<SelectedTab> currentTabIndexNotifier = ValueNotifier<SelectedTab>(SelectedTab.home);
  final ValueNotifier<List<CalenderMeetings>> meetingsListNotifier = ValueNotifier<List<CalenderMeetings>>([]);
  // final box = Hive.box(DatabaseBoxConstant.userInfo);

  GlobalKey<ConvexAppBarState> appBarKey = GlobalKey<ConvexAppBarState>();

  List<TabNavigator> navTabs = const [
    TabNavigator(initialRoute: RoutesConstants.homeScreen),
    TabNavigator(initialRoute: RoutesConstants.messagesScreen),
    TabNavigator(initialRoute: RoutesConstants.callScreen),
    TabNavigator(initialRoute: RoutesConstants.calenderScreen),
    TabNavigator(initialRoute: RoutesConstants.accountScreen)
  ];

  SelectedTab returnSelectedtypeDependOnIndex(int index) {
    switch (index) {
      case 0:
        return SelectedTab.home;
      case 1:
        return SelectedTab.messages;
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
      case SelectedTab.messages:
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

  // Future<List<CalenderMeetings>> getAppointmentsAndEvents() async {
  //   List<CalenderMeetings> list = [];

  //   list.addAll(await _getMentorAppointments());
  //   meetingsListNotifier.value = list;
  //   return list;
  // }

  // Future<List<CalenderMeetings>> _getMentorAppointments() async {
  //   List<CalenderMeetings> list = [];

  //TODO

  // await locator<AppointmentsService>().getMentorAppointments(box.get(DatabaseFieldConstant.userid)).then((value) {
  //   if (value.data != null) {
  //     for (AppointmentData item in value.data!) {
  //       final newItem = CalenderMeetings(
  //         meetingId: item.id!,
  //         mentorPrefix: item.mentorPrefix!,
  //         mentorFirstName: item.mentorFirstName!,
  //         mentorLastName: item.mentorLastName!,
  //         title: null,
  //         profileImg: item.profileImg,
  //         mentorId: item.mentorId!,
  //         categoryName: item.categoryName!,
  //         type: Type.meeting,
  //         fromTime: DateTime.parse(item.dateFrom!),
  //         toTime: DateTime.parse(item.dateTo!),
  //       );
  //       list.add(newItem);
  //     }
  //   }
  // });

  //   return list;
  // }
}
