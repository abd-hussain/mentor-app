import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/notifications_response.dart';
import 'package:mentor_app/shared_widget/account_service.dart';
import 'package:mentor_app/utils/mixins.dart';

class MessagesBloc extends Bloc<AccountService> {
  final ValueNotifier<List<NotificationsResponseData>?> messagesListNotifier =
      ValueNotifier<List<NotificationsResponseData>?>(null);

  void listOfMessages() {
    // service.listOfNotifications().then((value) {
    //   notificationsListNotifier.value = value.data;
    // });
  }

  void deleteMessage(int id) async {
    // await service.deleteNotification(id);
  }

  @override
  onDispose() {}
}
