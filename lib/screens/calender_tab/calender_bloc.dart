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
        print(value.data!.length);
        meetingsListNotifier.value = value.data!;
      }
    });
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
