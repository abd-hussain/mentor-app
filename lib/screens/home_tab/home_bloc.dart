import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/home_response.dart';
import 'package:mentor_app/services/home_services.dart';
import 'package:mentor_app/services/report_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class HomeBloc extends Bloc<HomeService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  final ValueNotifier<List<MainBanner>?> bannerListNotifier = ValueNotifier<List<MainBanner>?>(null);
  final ValueNotifier<List<MainEvent>?> eventListNotifier = ValueNotifier<List<MainEvent>?>(null);

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
        eventListNotifier.value = value.data!.mainEvent;
      }
    });
  }

  void reportEvent({required int eventId}) async {
    await locator<ReportService>().reportEvent(eventId: eventId);
  }

  @override
  onDispose() {
    bannerListNotifier.dispose();
    eventListNotifier.dispose();
  }
}
