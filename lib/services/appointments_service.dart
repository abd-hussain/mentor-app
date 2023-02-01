import 'package:mentor_app/models/https/appointment.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';
import 'package:mentor_app/utils/repository/method_name_constractor.dart';

class AppointmentsService with Service {
  Future<Appointment> getMentorAppointments(int mentorID) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentorAppointments,
      queryParam: {"id": mentorID},
    );

    return Appointment.fromJson(response);
  }

  Future<void> cancelAppointment({required int id}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.cancelAppointment,
      queryParam: {"id": id},
    );

    return response;
  }
}
