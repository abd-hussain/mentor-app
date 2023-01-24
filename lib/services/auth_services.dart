import 'package:mentor_app/models/https/login_request.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';
import 'package:mentor_app/utils/repository/method_name_constractor.dart';

class AuthService with Service {
  Future<dynamic> login({required LoginRequest loginData}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.login,
      postBody: loginData,
    );
    return response;
  }
}
