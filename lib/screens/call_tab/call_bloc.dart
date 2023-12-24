import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/calender_model.dart';
import 'package:mentor_app/services/account_service.dart';
import 'package:mentor_app/services/appointments_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class CallBloc extends Bloc<AccountService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  CalenderMeetings? getNearestMeetingToday(List<CalenderMeetings> meetings) {
    final now = DateTime.now();

    var activeMeetings = meetings.where((meeting) => meeting.state == AppointmentsState.active).toList();
    var removeOldMeetingFromTheList = activeMeetings.where((meeting) => meeting.toTime.isAfter(now)).toList();
    var filtermeetingavaliablewithing24Hour = removeOldMeetingFromTheList
        .where((meeting) => meeting.fromTime.isBefore(now.add(const Duration(hours: 24))))
        .toList();

    return filtermeetingavaliablewithing24Hour.isNotEmpty
        ? filtermeetingavaliablewithing24Hour
            .reduce((closest, current) => current.fromTime.isBefore(closest.fromTime) ? current : closest)
        : null;
  }

  Future<void> cancelAppointment({required int id}) {
    return locator<AppointmentsService>().cancelAppointment(id: id);
  }

  bool isTimeDifferencePositive(DateTime timeDifference) {
    return timeDifference.hour > 0 || timeDifference.minute > 0 || timeDifference.second > 0;
  }

  @override
  onDispose() {}
}
