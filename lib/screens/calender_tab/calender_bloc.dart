import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/add_comment_appointment.dart';
import 'package:mentor_app/models/https/appointment.dart';
import 'package:mentor_app/services/appointments_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class CalenderBloc extends Bloc<AppointmentsService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  final ValueNotifier<List<AppointmentData>> meetingsListNotifier =
      ValueNotifier<List<AppointmentData>>([]);

  void getMentorAppointments(BuildContext context) async {
    await service.getMentorAppointments().then((value) {
      if (value.data != null) {
        meetingsListNotifier.value = handleTimingFromUTC(value.data!);
      }
    });
  }

  List<AppointmentData> handleTimingFromUTC(List<AppointmentData> data) {
    int offset = DateTime.now().timeZoneOffset.inHours;

    for (var appoint in data) {
      appoint.dateFrom = _adjustDate(appoint.dateFrom, offset);
      appoint.dateTo = _adjustDate(appoint.dateTo, offset);
    }

    return data;
  }

  String _adjustDate(String? dateString, int offset) {
    if (dateString == null) return '';

    final DateTime date = DateTime.parse(dateString);
    final DateTime adjustedDate = date.add(Duration(hours: offset));

    return adjustedDate.toString();
  }

  Future<dynamic> cancelMeeting(int meetingId) async {
    return service.cancelAppointment(id: meetingId);
  }

  Future<dynamic> addNote(AddCommentToAppointment body) async {
    return service.addCommentToAppointment(body: body);
  }

  @override
  onDispose() {}
}
