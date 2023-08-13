import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';
import 'package:mentor_app/utils/repository/method_name_constractor.dart';

class MentorSettingsService with Service {
  Future<dynamic> getHourRate() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentorSettingsRate,
    );

    return response["data"]["hour_rate"];
  }

  Future<dynamic> updateHourRate({required String newRate}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      queryParam: {"rate": newRate},
      methodName: MethodNameConstant.mentorSettingsRate,
    );

    return response;
  }
}
