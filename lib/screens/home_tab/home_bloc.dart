import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/home_response.dart';
import 'package:mentor_app/models/https/notifications_response.dart';
import 'package:mentor_app/services/home_services.dart';
import 'package:mentor_app/services/noticitions_services.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class HomeBloc extends Bloc<HomeService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<List<MainBannerData>?> getHome() async {
    final value = await service.getHome();
    if (value.data != null) {
      return value.data ?? [];
    } else {
      return [];
    }
  }

  Future<List<NotificationsResponseData>?> listOfNotifications() async {
    final value = await locator<NotificationsService>().listOfNotifications();
    return value.data;
  }

  void callRegisterTokenRequest() async {
    final String token = box.get(DatabaseFieldConstant.pushNotificationToken);
    await locator<NotificationsService>().registerToken(token);
  }

  @override
  onDispose() {}
}
