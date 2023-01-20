import 'package:flutter/material.dart';
import 'package:mentor_app/screens/call_tab/call_bloc.dart';
import 'package:mentor_app/screens/call_tab/widgets/no_call_view.dart';
import 'package:mentor_app/screens/home_tab/widgets/header.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/logger.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final bloc = CallBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Call init Called ...');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HeaderHomePage(),
          noCallView(),
        ],
      ),
    );
  }

  Widget noCallView() {
    return NoCallView(
      language: bloc.box.get(DatabaseFieldConstant.language),
    );
  }
}
