import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/notifications_response.dart';
import 'package:mentor_app/shared_widget/account_service.dart';
import 'package:mentor_app/utils/mixins.dart';

class NotificationsBloc extends Bloc<AccountService> {
  final ValueNotifier<List<NotificationsResponseData>?> notificationsListNotifier =
      ValueNotifier<List<NotificationsResponseData>?>(null);

  void listOfNotifications() {
    // service.listOfNotifications().then((value) {
    //   notificationsListNotifier.value = value.data;
    // });
  }

  void markNotificationReaded() async {
    // await service.markAllNotificationsReaded();
  }

  void deleteNotification(int id) async {
    // await service.deleteNotification(id);
  }

  @override
  onDispose() {
    notificationsListNotifier.dispose();
  }
}
