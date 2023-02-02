import 'package:mentor_app/models/https/account_info_model.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';
import 'package:mentor_app/utils/repository/method_name_constractor.dart';

class AccountService with Service {
  Future<AccountInfo> getProfileInfo() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.accountInfo,
    );
    return AccountInfo.fromJson(response);
  }

  Future<dynamic> removeAccount() async {
    // final response = await repository.callRequest(
    //   requestType: RequestType.delete,
    //   methodName: MethodNameConstant.deleteAccount,
    // );
    // return response;

    //TODO : handle calling API of remove account
  }
}
