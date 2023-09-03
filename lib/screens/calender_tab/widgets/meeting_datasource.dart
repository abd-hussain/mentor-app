import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/calender_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MeetingDataSource extends CalendarDataSource {
  late final BuildContext context;

  MeetingDataSource(this.context, List<CalenderMeetings> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].fromTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].toTime;
  }

  @override
  String getSubject(int index) {
    return "${AppLocalizations.of(context)!.meeting} ${AppLocalizations.of(context)!.withword} ${appointments![index].firstName} ${appointments![index].lastName}";
  }

  @override
  Color getColor(int index) {
    if (appointments![index].state == AppointmentsState.active) {
      return const Color(0xff006400);
    } else if (appointments![index].state == AppointmentsState.completed) {
      return const Color(0xff444444);
    } else {
      return const Color(0xff880808);
    }
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
