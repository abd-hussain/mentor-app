import 'package:flutter/material.dart';
import 'package:mentor_app/screens/messages_tab/messages_bloc.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final bloc = MessagesBloc();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
