import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/messages.dart';
import 'package:mentor_app/services/messages_services.dart';
import 'package:mentor_app/utils/mixins.dart';

class MessagesBloc extends Bloc<MessagesService> {
  final ValueNotifier<List<MessagesListData>?> messagesListNotifier = ValueNotifier<List<MessagesListData>?>(null);

  void listOfMessages() {
    service.listOfMessages().then((value) {
      if (value.data != null) {
        messagesListNotifier.value = value.data!;
      }
    });
  }

  @override
  onDispose() {}
}
