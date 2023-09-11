import 'package:mentor_app/models/https/working_hour_request.dart';
import 'package:mentor_app/models/https/working_hours.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';
import 'package:mentor_app/utils/repository/method_name_constractor.dart';

class MentorPropertiesService with Service {
  Future<WorkingHours> getWorkingHours() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentorWorkingHours,
    );

    return WorkingHours.fromJson(response);
  }

  Future<dynamic> updateWorkingHours(
      {required WorkingHoursRequest data}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.mentorWorkingHours,
      postBody: data,
    );

    return response;
  }
}
