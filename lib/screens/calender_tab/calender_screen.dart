import 'package:flutter/material.dart';
import 'package:mentor_app/screens/calender_tab/calender_bloc.dart';
import 'package:mentor_app/utils/logger.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final bloc = CalenderBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Calender init Called ...');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
