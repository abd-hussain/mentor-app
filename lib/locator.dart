import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mentor_app/services/filter_services.dart';
import 'package:mentor_app/services/general/network_info_service.dart';
import 'package:mentor_app/utils/repository/http_interceptor.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<NetworkInfoService>(NetworkInfoService());
  locator.registerFactory<FilterService>(() => FilterService());

  locator.registerFactory<Dio>(() => Dio());
  locator.registerFactory<HttpInterceptor>(() => HttpInterceptor());
  locator.registerSingleton<HttpRepository>(HttpRepository());
}