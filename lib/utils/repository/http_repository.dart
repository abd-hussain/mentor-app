import 'package:dio/dio.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/services/general/network_info_service.dart';
import 'package:mentor_app/utils/constants/constant.dart';
import 'package:mentor_app/utils/error/exceptions.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_interceptor.dart';

enum RequestType { get, post, delete, put }

class HttpRepository {
  Future<dynamic> callRequest({
    required RequestType requestType,
    required String methodName,
    Map<String, dynamic> queryParam = const {},
    Model? postBody,
    FormData? formData,
  }) async {
    Response response;

    const baseUrl = AppConstant.applicationMainURL;

    if (await locator<NetworkInfoService>().isConnected()) {
      final dioClient = locator<Dio>()
        ..options = BaseOptions(
          baseUrl: baseUrl,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        )
        ..interceptors.add(locator<HttpInterceptor>());

      switch (requestType) {
        case RequestType.get:
          response = await dioClient.get(
            methodName,
            queryParameters: queryParam,
            // options: Options(contentType: contentType),
          );

          break;
        case RequestType.post:
          response = await dioClient.post(
            methodName,
            data: formData ?? postBody?.toJson(),
            queryParameters: queryParam,
            // options: Options(contentType: contentType),
          );
          break;
        case RequestType.delete:
          response = await dioClient.delete(
            methodName,
            data: postBody?.toJson(),
            queryParameters: queryParam,
            // options: Options(contentType: contentType),
          );
          break;
        case RequestType.put:
          response = await dioClient.put(
            methodName,
            data: formData ?? postBody?.toJson(),
            queryParameters: queryParam,
            // options: Options(contentType: contentType),
          );
          break;
      }

      return response.data;
    } else {
      throw ConnectionException(message: "Please check your internet connection");
    }
  }
}
