import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/versioning_model.dart';
import 'package:mentor_app/services/settings_service.dart';
import 'package:mentor_app/utils/mixins.dart';

class VersioningBloc extends Bloc<SettingService> {
  final ValueNotifier<List<VersioningData>?> versionsListNotifier =
      ValueNotifier<List<VersioningData>?>(null);

  Future<void> pullRefresh() async {
    return Future.delayed(
      const Duration(milliseconds: 1000),
      () => getVerionsDetails(),
    );
  }

  getVerionsDetails() {
    service.getVersions().then((value) {
      versionsListNotifier.value = value.data;
    });
  }

  @override
  onDispose() {}
}
