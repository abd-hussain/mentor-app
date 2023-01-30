import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mentor_app/models/https/home_response.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';
import 'package:mentor_app/utils/repository/method_name_constractor.dart';

class HomeService with Service {
  Future<HomeResponse> getHome() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.home,
    );
    return HomeResponse.fromJson(response);
  }

  Future<HomeResponse> addStiry(File? file) async {
    FormData? formData;
    String fileName = "";
    if (file != null) {
      fileName = file.path.split('/').last;
    }

    formData = FormData.fromMap({
      "attach":
          file != null ? await MultipartFile.fromFile(file.path, filename: fileName) : MultipartFile.fromString(""),
    });

    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.home,
      formData: formData,
    );
    return HomeResponse.fromJson(response);
  }
}
