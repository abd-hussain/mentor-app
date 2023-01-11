import 'package:flutter/material.dart';
import 'package:mentor_app/screens/call_tab/call_bloc.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final bloc = CallBloc();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
