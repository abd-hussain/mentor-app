import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/add_comment_appointment.dart';
import 'package:mentor_app/services/appointments_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class CalenderBloc extends Bloc<AppointmentsService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<dynamic> cancelMeeting(int meetingId) async {
    return service.cancelAppointment(id: meetingId);
  }

  Future<dynamic> addNote(AddCommentToAppointment body) async {
    return service.addCommentToAppointment(body: body);
  }

  @override
  onDispose() {}
}
