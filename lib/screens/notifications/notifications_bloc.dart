import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/notifications_response.dart';
import 'package:mentor_app/services/noticitions_services.dart';
import 'package:mentor_app/utils/mixins.dart';

class NotificationsBloc extends Bloc<NotificationsService> {
  final ValueNotifier<List<NotificationsResponseData>?> notificationsListNotifier =
      ValueNotifier<List<NotificationsResponseData>?>(null);

  Future<void> pullRefresh() async {
    return Future.delayed(
      const Duration(milliseconds: 1000),
      () => listOfNotifications(),
    );
  }

  void listOfNotifications() {
    service.listOfNotifications().then((value) {
      notificationsListNotifier.value = value.data;
    });
  }

  void markNotificationReaded() async {
    await service.markAllNotificationsReaded();
  }

  void deleteNotification(int id) async {
    await service.deleteNotification(id);
  }

  @override
  onDispose() {
    notificationsListNotifier.dispose();
  }
}
