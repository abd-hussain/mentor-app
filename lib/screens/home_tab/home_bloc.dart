import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/home_response.dart';
import 'package:mentor_app/shared_widget/account_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class HomeBloc extends Bloc<AccountService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  final ValueNotifier<List<MainBanner>?> bannerListNotifier = ValueNotifier<List<MainBanner>?>(null);
  final ValueNotifier<List<MainStory>?> storiesListNotifier = ValueNotifier<List<MainStory>?>(null);
  final ValueNotifier<List<MainEvent>?> eventListNotifier = ValueNotifier<List<MainEvent>?>(null);

  void getHome() {}

  void reportEvent({required int eventId}) {
    // service.reportEvent(eventId: eventId).then((value) {
    //   eventListNotifier.value = value.data!;
    // });
  }

  void reportStory({required int storyId}) {
    // service.reportStory(storyId: storyId).then((value) {
    //   storiesListNotifier.value = value.data!;
    // });
  }

  @override
  onDispose() {
    bannerListNotifier.dispose();
    storiesListNotifier.dispose();
    eventListNotifier.dispose();
  }
}
