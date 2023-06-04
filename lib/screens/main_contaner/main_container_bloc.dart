import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/appointment.dart';
import 'package:mentor_app/models/https/calender_model.dart';
import 'package:mentor_app/screens/main_contaner/widgets/tab_navigator.dart';
import 'package:mentor_app/services/appointments_service.dart';
import 'package:mentor_app/utils/gender_format.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/routes.dart';

enum SelectedTab { home, messages, call, calender, account }

class MainContainerBloc extends Bloc<AppointmentsService> {
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

  void getMentorAppointments(BuildContext context) async {
    List<CalenderMeetings> list = [];

    await service.getMentorAppointments().then((value) {
      if (value.data != null) {
        for (AppointmentData item in value.data!) {
          final newItem = CalenderMeetings(
            meetingId: item.id!,
            firstName: item.firstName!,
            lastName: item.lastName!,
            profileImg: item.profileImg!,
            clientId: item.clientId!,
            state: handleMeetingState(item.state!),
            gender: GenderFormat().convertIndexToString(context, item.gender!),
            fromTime: DateTime.parse(item.dateFrom!),
            toTime: DateTime.parse(item.dateTo!),
          );
          list.add(newItem);
          meetingsListNotifier.value = list;
        }
      }
    });
  }

  AppointmentsState handleMeetingState(int index) {
    if (index == 1) {
      return AppointmentsState.active;
    } else if (index == 2) {
      return AppointmentsState.mentorCancel;
    } else if (index == 3) {
      return AppointmentsState.clientCancel;
    } else if (index == 4) {
      return AppointmentsState.clientMiss;
    } else if (index == 5) {
      return AppointmentsState.mentorMiss;
    } else {
      return AppointmentsState.completed;
    }
  }

  @override
  onDispose() {}
}
