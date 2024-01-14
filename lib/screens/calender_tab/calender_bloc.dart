import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/add_comment_appointment.dart';
import 'package:mentor_app/models/https/appointment.dart';
import 'package:mentor_app/models/https/calender_model.dart';
import 'package:mentor_app/services/appointments_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/gender_format.dart';
import 'package:mentor_app/utils/mixins.dart';

class CalenderBloc extends Bloc<AppointmentsService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  final ValueNotifier<List<CalenderMeetings>> meetingsListNotifier =
      ValueNotifier<List<CalenderMeetings>>([]);

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
            dateOfBirth: item.dateOfBirth!,
            appointmentType: item.appointmentType!,
            priceBefore: item.priceBeforeDiscount!,
            priceAfter: item.priceAfterDiscount!,
            countryId: item.countryId!,
            countryFlag: item.countryFlag!,
            mentornote: item.mentornote ?? "",
            clientnote: item.clientnote ?? "",
            channelID: item.channelID ?? "",
          );
          list.add(newItem);
        }
        meetingsListNotifier.value = list;
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

  Future<dynamic> cancelMeeting(int meetingId) async {
    return service.cancelAppointment(id: meetingId);
  }

  Future<dynamic> addNote(AddCommentToAppointment body) async {
    return service.addCommentToAppointment(body: body);
  }

  @override
  onDispose() {}
}
