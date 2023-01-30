import 'package:flutter/material.dart';
import 'package:mentor_app/screens/home_tab/widgets/header.dart';
import 'package:mentor_app/screens/messages_tab/messages_bloc.dart';
import 'package:mentor_app/screens/messages_tab/widgets/list_messages_widget.dart';
import 'package:mentor_app/utils/logger.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final bloc = MessagesBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Messages init Called ...');
    bloc.listOfMessages();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderHomePage(),
        SizedBox(
          height: MediaQuery.of(context).size.height - 300,
          child: MessagesList(
            messagesListNotifier: bloc.messagesListNotifier,
            onOpen: (item) {
              // TODO
            },
          ),
        ),
      ],
    );
  }
}
