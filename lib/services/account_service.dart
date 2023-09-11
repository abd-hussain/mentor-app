import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mentor_app/models/https/account_exp_model.dart';
import 'package:mentor_app/models/https/account_info_model.dart';
import 'package:mentor_app/models/https/update_account_request.dart';
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

  Future<AccountInfo> updateProfileInfo(
      {required UpdateAccountRequest account}) async {
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
          ? await MultipartFile.fromFile(account.profileImage!.path,
              filename: profileFileName)
          : MultipartFile.fromString(""),
      "id_image": account.iDImage != null
          ? await MultipartFile.fromFile(account.iDImage!.path,
              filename: iDFileName)
          : MultipartFile.fromString(""),
      "suffixe_name": MultipartFile.fromString(account.suffix ?? ""),
      "first_name": MultipartFile.fromString(account.firstName ?? ""),
      "last_name": MultipartFile.fromString(account.lastName ?? ""),
      "date_of_birth": MultipartFile.fromString(account.dateOfBirth),
      "country_id": MultipartFile.fromString(account.countryId.toString()),
      "gender": MultipartFile.fromString(
          account.gender != null ? account.gender.toString() : ""),
      "mobile_number": MultipartFile.fromString(account.mobileNumber ?? ""),
      "speaking_language": MultipartFile.fromString(
          account.speackingLanguage != null
              ? account.speackingLanguage!.toString()
              : ""),
    });
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.accountInfo,
      formData: formData,
    );
    return AccountInfo.fromJson(response);
  }

  Future<AccountExperiance> getProfileExperiance() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.accountExperiance,
    );
    return AccountExperiance.fromJson(response);
  }

  Future<dynamic> updateProfileExperiance(
      {required UpdateAccountExperianceRequest account}) async {
    String cvFileName = "";
    String cert1FileName = "";
    String cert2FileName = "";
    String cert3FileName = "";

    if (account.cv != null && account.cv != File("")) {
      cvFileName = account.cv!.path.split('/').last;
    }
    if (account.cert1 != null) {
      cert1FileName = account.cert1!.path.split('/').last;
    }
    if (account.cert2 != null) {
      cert2FileName = account.cert2!.path.split('/').last;
    }
    if (account.cert3 != null) {
      cert3FileName = account.cert3!.path.split('/').last;
    }
    FormData formData = FormData.fromMap({
      "cv": account.cv != null && account.cv != File("")
          ? await MultipartFile.fromFile(account.cv!.path, filename: cvFileName)
          : MultipartFile.fromString(""),
      "cert1": account.cert1 != null && account.cert1 != File("")
          ? await MultipartFile.fromFile(account.cert1!.path,
              filename: cert1FileName)
          : MultipartFile.fromString(""),
      "cert2": account.cert2 != null && account.cert2 != File("")
          ? await MultipartFile.fromFile(account.cert2!.path,
              filename: cert2FileName)
          : MultipartFile.fromString(""),
      "cert3": account.cert3 != null && account.cert3 != File("")
          ? await MultipartFile.fromFile(account.cert3!.path,
              filename: cert3FileName)
          : MultipartFile.fromString(""),
      "experience_since":
          MultipartFile.fromString(account.experienceSince ?? ""),
      "majors": account.majors!,
    });

    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.accountExperiance,
      formData: formData,
    );
    return response;
  }
}
