import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/error/exceptions.dart';
import 'package:mentor_app/utils/mixins.dart';

class HttpInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var box = Hive.box(DatabaseBoxConstant.userInfo);
    if (box.get(DatabaseFieldConstant.token) != null || box.get(DatabaseFieldConstant.token) != "") {
      String bearerToken = "Bearer ${box.get(DatabaseFieldConstant.token)}";
      options.headers = {
        "Authorization": bearerToken,
        "lang": box.get(DatabaseFieldConstant.language),
      };
    } else {
      options.headers.putIfAbsent("lang", () => box.get(DatabaseFieldConstant.language));
      // options.headers.putIfAbsent("Content-Type", () => "application/json");
      // options.headers.putIfAbsent("User-Agent", () => "PostmanRuntime/7.36.0");
      // options.headers.putIfAbsent("Accept", () => "*/*");
      // options.headers.putIfAbsent("Accept-Encoding", () => "gzip, deflate, br");
      // options.headers.putIfAbsent("Connection", () => "keep-alive");
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      if (await validateResponse(response)) {
        return handler.next(response);
      }
    } catch (error) {
      handler.reject(error as DioException);
    }
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }

  Future<bool> validateResponse<T extends Model, TR>(Response response) async {
    debugPrint("request name ${response.requestOptions.path} -- status code ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        return true;
      case 201:
        return true;
      case 403:
        debugPrint("response.data ${response.data.toString()}");

        throw DioException(
            error: HttpException(
                status: response.statusCode!,
                message: response.data["detail"] ?? response.data.toString(),
                requestId: ""),
            requestOptions: response.requestOptions);
      default:
        debugPrint("response.data ${response.data.toString()}");

        throw DioException(
            error: HttpException(
                status: response.statusCode!,
                message: response.data["detail"]["message"],
                requestId: response.data["detail"]["request_id"]),
            requestOptions: response.requestOptions);
    }
  }
}
