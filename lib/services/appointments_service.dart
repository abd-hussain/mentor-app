import 'package:mentor_app/models/https/add_comment_appointment.dart';
import 'package:mentor_app/models/https/appointment.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';
import 'package:mentor_app/utils/repository/method_name_constractor.dart';

class AppointmentsService with Service {
  Future<Appointments> getMentorAppointments() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentorAppointments,
    );

    return Appointments.fromJson(response);
  }

  Future<void> cancelAppointment({required int id}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.cancelAppointment,
      queryParam: {"id": id},
    );

    return response;
  }

  Future<void> compleateAppointment({required int id}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.compleatedAppointment,
      queryParam: {"id": id},
    );

    return response;
  }

  Future<void> addCommentToAppointment({required AddCommentToAppointment body}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.commentAppointment,
      postBody: body,
    );

    return response;
  }
}
