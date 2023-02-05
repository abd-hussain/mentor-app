import 'package:dio/dio.dart';
import 'package:mentor_app/models/https/account_info_model.dart';
import 'package:mentor_app/models/https/update_account_request.dart';
import 'package:mentor_app/models/https/update_password_request.dart';
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
    final response = await repository.callRequest(
      requestType: RequestType.delete,
      methodName: MethodNameConstant.deleteAccount,
    );
    return response;
  }

  Future<dynamic> changePassword({required UpdatePasswordRequest account}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.changePassword,
      postBody: account,
    );
    return response;
  }

  Future<AccountInfo> updateProfileInfo({required UpdateAccountRequest account}) async {
    String profileFileName = "";
    String iDFileName = "";

    if (account.profileImage != null) {
      profileFileName = account.profileImage!.path.split('/').last;
    }
    if (account.iDImage != null) {
      iDFileName = account.iDImage!.path.split('/').last;
    }
    FormData formData = FormData.fromMap({
      "profile_picture": account.profileImage != null
          ? await MultipartFile.fromFile(account.profileImage!.path, filename: profileFileName)
          : MultipartFile.fromString(""),
      "id_image": account.iDImage != null
          ? await MultipartFile.fromFile(account.iDImage!.path, filename: iDFileName)
          : MultipartFile.fromString(""),
      "suffixe_name": MultipartFile.fromString(account.suffix ?? ""),
      "first_name": MultipartFile.fromString(account.firstName ?? ""),
      "last_name": MultipartFile.fromString(account.lastName ?? ""),
      "date_of_birth": MultipartFile.fromString(account.dateOfBirth),
      "country_id": MultipartFile.fromString(account.countryId.toString()),
      "gender": MultipartFile.fromString(account.gender != null ? account.gender.toString() : ""),
      "mobile_number": MultipartFile.fromString(account.mobileNumber ?? ""),
      "speaking_language":
          MultipartFile.fromString(account.speackingLanguage != null ? account.speackingLanguage!.toString() : ""),
    });
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.accountInfo,
      formData: formData,
    );
    return AccountInfo.fromJson(response);
  }
}
