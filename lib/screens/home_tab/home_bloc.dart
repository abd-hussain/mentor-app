import 'dart:io';

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
  final ValueNotifier<List<MainStory>?> storiesListNotifier = ValueNotifier<List<MainStory>?>(null);
  final ValueNotifier<List<MainEvent>?> eventListNotifier = ValueNotifier<List<MainEvent>?>(null);

  void getHome() {
    service.getHome().then((value) {
      if (value.data != null) {
        bannerListNotifier.value = value.data!.mainBanner;
        storiesListNotifier.value = value.data!.mainStory;
        eventListNotifier.value = value.data!.mainEvent;
      }
    });
  }

  void reportEvent({required int eventId}) async {
    await locator<ReportService>().reportEvent(eventId: eventId);
  }

  void reportStory({required int storyId}) async {
    await locator<ReportService>().reportStory(storyId: storyId);
  }

  void addNewStory({required File file}) async {
    await service.addStiry(file);
  }

  @override
  onDispose() {
    bannerListNotifier.dispose();
    storiesListNotifier.dispose();
    eventListNotifier.dispose();
  }
}
