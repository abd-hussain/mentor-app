import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/active_appointment.dart';
import 'package:mentor_app/services/appointments_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class CallBloc extends Bloc<AppointmentsService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  final ValueNotifier<List<ActiveAppointmentsData>>
      activeMentorAppointmentsListNotifier =
      ValueNotifier<List<ActiveAppointmentsData>>([]);

  void getActiveMentorAppointments(BuildContext context) async {
    await service.getActiveMentorAppointments().then((value) {
      if (value.data != null) {
        activeMentorAppointmentsListNotifier.value = value.data!;
      }
    });
  }

  ActiveAppointmentsData? getNearestMeetingToday(
      List<ActiveAppointmentsData> activeMeetings) {
    final now = DateTime.now();

    var removeOldMeetingFromTheList = activeMeetings
        .where((meeting) => DateTime.parse(meeting.dateTo!).isAfter(now))
        .toList();

    var filtermeetingavaliablewithing24Hour = removeOldMeetingFromTheList
        .where((meeting) => DateTime.parse(meeting.dateFrom!)
            .isBefore(now.add(const Duration(hours: 24))))
        .toList();

    return filtermeetingavaliablewithing24Hour.isNotEmpty
        ? filtermeetingavaliablewithing24Hour.reduce((closest, current) =>
            DateTime.parse(current.dateFrom!)
                    .isBefore(DateTime.parse(closest.dateFrom!))
                ? current
                : closest)
        : null;
  }

  Future<void> cancelAppointment({required int id}) {
    return service.cancelAppointment(id: id);
  }

  bool isTimeDifferencePositive(DateTime timeDifference) {
    return timeDifference.hour > 0 ||
        timeDifference.minute > 0 ||
        timeDifference.second > 0;
  }

  @override
  onDispose() {}
}
