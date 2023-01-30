import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mentor_app/screens/main_contaner/main_container_bloc.dart';
import 'package:mentor_app/services/auth_services.dart';
import 'package:mentor_app/services/event_services.dart';
import 'package:mentor_app/services/filter_services.dart';
import 'package:mentor_app/services/general/authentication_service.dart';
import 'package:mentor_app/services/general/network_info_service.dart';
import 'package:mentor_app/services/home_services.dart';
import 'package:mentor_app/services/messages_services.dart';
import 'package:mentor_app/services/report_service.dart';
import 'package:mentor_app/services/settings_service.dart';
import 'package:mentor_app/shared_widget/account_service.dart';
import 'package:mentor_app/utils/day_time.dart';
import 'package:mentor_app/utils/repository/http_interceptor.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<NetworkInfoService>(NetworkInfoService());

  locator.registerFactory<FilterService>(() => FilterService());
  locator.registerFactory<AuthService>(() => AuthService());
  locator.registerFactory<AccountService>(() => AccountService());
  locator.registerFactory<SettingService>(() => SettingService());
  locator.registerFactory<ReportService>(() => ReportService());
  locator.registerFactory<HomeService>(() => HomeService());
  locator.registerFactory<EventService>(() => EventService());
  locator.registerFactory<MessagesService>(() => MessagesService());

  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => LocalAuthentication());
  locator.registerSingleton<DayTime>(DayTime());

  locator.registerFactory<Dio>(() => Dio());
  locator.registerFactory<HttpInterceptor>(() => HttpInterceptor());
  locator.registerSingleton<HttpRepository>(HttpRepository());
  locator.registerSingleton<MainContainerBloc>(MainContainerBloc());
}
