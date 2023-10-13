import 'package:flutter/material.dart';
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
  final ValueNotifier<List<MainBanner>?> bannerListNotifier = ValueNotifier<List<MainBanner>?>(null);
  final ValueNotifier<List<NotificationsResponseData>?> notificationsListNotifier =
      ValueNotifier<List<NotificationsResponseData>?>(null);

  Future<void> pullRefresh() async {
    return Future.delayed(
      const Duration(milliseconds: 1000),
      () => getHome(),
    );
  }

  void getHome() {
    service.getHome().then((value) {
      if (value.data != null) {
        bannerListNotifier.value = value.data!.mainBanner;
      }
    });
  }

  Future<List<NotificationsResponseData>?> listOfNotifications() async {
    final value = await locator<NotificationsService>().listOfNotifications();
    return value.data;
  }

  @override
  onDispose() {
    bannerListNotifier.dispose();
    notificationsListNotifier.dispose();
  }
}
