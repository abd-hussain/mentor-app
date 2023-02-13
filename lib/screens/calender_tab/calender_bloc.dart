import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/services/appointments_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class CalenderBloc extends Bloc<AppointmentsService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<dynamic> cancelMeeting(int meetingId) async {
    return service.cancelAppointment(id: meetingId);
  }

  @override
  onDispose() {}
}
