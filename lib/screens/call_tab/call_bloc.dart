import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/calender_model.dart';
import 'package:mentor_app/services/account_service.dart';
import 'package:mentor_app/services/appointments_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class CallBloc extends Bloc<AccountService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  CalenderMeetings? checkIfThereIsAnyMeetingTodayAndReturnTheNearOne(List<CalenderMeetings> listOfData) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    List<CalenderMeetings> newList = [];
    for (CalenderMeetings appointment in listOfData) {
      Duration diffrent = today.difference(DateTime(appointment.fromTime.year, appointment.fromTime.month,
          appointment.fromTime.day, appointment.fromTime.hour, appointment.fromTime.minute));
      if (diffrent.inHours >= -24 && diffrent.inHours <= 24) {
        newList.add(appointment);
      }
    }

    if (newList.isNotEmpty) {
      CalenderMeetings returnedAppointment = newList[0];

      for (CalenderMeetings appoint in newList) {
        if (appoint.fromTime.isBefore(returnedAppointment.fromTime)) {
          returnedAppointment = appoint;
        }
      }
      return returnedAppointment;
    } else {
      return null;
    }
  }

  Future<void> cancelAppointment({required int id}) {
    return locator<AppointmentsService>().cancelAppointment(id: id);
  }

  @override
  onDispose() {}
}
