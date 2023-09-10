import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mentor_app/main_context.dart';
import 'package:mentor_app/screens/main_contaner/main_container_bloc.dart';
import 'package:mentor_app/services/appointments_service.dart';
import 'package:mentor_app/services/auth_services.dart';
import 'package:mentor_app/services/filter_services.dart';
import 'package:mentor_app/services/general/authentication_service.dart';
import 'package:mentor_app/services/general/network_info_service.dart';
import 'package:mentor_app/services/home_services.dart';
import 'package:mentor_app/services/mentor_properties_services.dart';
import 'package:mentor_app/services/mentor_settings.dart';
import 'package:mentor_app/services/noticitions_services.dart';
import 'package:mentor_app/services/payment_services.dart';
import 'package:mentor_app/services/register_service.dart';
import 'package:mentor_app/services/report_service.dart';
import 'package:mentor_app/services/settings_service.dart';
import 'package:mentor_app/services/account_service.dart';
import 'package:mentor_app/utils/day_time.dart';
import 'package:mentor_app/utils/repository/http_interceptor.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => MainContext());

  locator.registerSingleton<NetworkInfoService>(NetworkInfoService());

  locator.registerFactory<FilterService>(() => FilterService());
  locator.registerFactory<AuthService>(() => AuthService());
  locator.registerFactory<AccountService>(() => AccountService());
  locator.registerFactory<SettingService>(() => SettingService());
  locator.registerFactory<ReportService>(() => ReportService());
  locator.registerFactory<HomeService>(() => HomeService());
  locator.registerFactory<NotificationsService>(() => NotificationsService());
  locator.registerFactory<AppointmentsService>(() => AppointmentsService());
  locator.registerFactory<MentorPropertiesService>(() => MentorPropertiesService());
  locator.registerFactory<PaymentService>(() => PaymentService());
  locator.registerFactory<MentorSettingsService>(() => MentorSettingsService());
  locator.registerFactory<RegisterService>(() => RegisterService());

  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => LocalAuthentication());
  locator.registerSingleton<DayTime>(DayTime());

  locator.registerFactory<Dio>(() => Dio());
  locator.registerFactory<HttpInterceptor>(() => HttpInterceptor());
  locator.registerSingleton<HttpRepository>(HttpRepository());
  locator.registerSingleton<MainContainerBloc>(MainContainerBloc());
}
