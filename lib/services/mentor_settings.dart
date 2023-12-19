import 'package:mentor_app/models/https/hour_rate_response.dart';
import 'package:mentor_app/models/https/update_password_request.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';
import 'package:mentor_app/utils/repository/method_name_constractor.dart';

class MentorSettingsService with Service {
  Future<HourRateResponse> getHourRate() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentorSettingsRate,
    );

    return HourRateResponse.fromJson(response);
  }

  Future<dynamic> updateHourRate(
      {required String newRate, required String iban}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      queryParam: {"rate": newRate, "iban": iban},
      methodName: MethodNameConstant.mentorSettingsRate,
    );

    return response;
  }

  Future<dynamic> removeAccount() async {
    final response = await repository.callRequest(
      requestType: RequestType.delete,
      methodName: MethodNameConstant.deleteAccount,
    );
    return response;
  }

  Future<dynamic> changePassword(
      {required UpdatePasswordRequest account}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.changePassword,
      postBody: account,
    );
    return response;
  }
}
