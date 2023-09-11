import 'package:flutter/material.dart';
import 'package:mentor_app/screens/inside_call/inside_call_bloc.dart';
import 'package:mentor_app/screens/inside_call/widgets/mentor_camera_view.dart';
import 'package:mentor_app/screens/inside_call/widgets/my_camera_view.dart';
import 'package:mentor_app/screens/inside_call/widgets/toolbar.dart';

class InsideCallScreen extends StatefulWidget {
  const InsideCallScreen({super.key});

  @override
  State<InsideCallScreen> createState() => _InsideCallScreenState();
}

class _InsideCallScreenState extends State<InsideCallScreen> {
  final bloc = InsideCallBloc();

  @override
  void didChangeDependencies() {
    bloc.handleReadingArguments(context,
        arguments: ModalRoute.of(context)!.settings.arguments);
    bloc.initializeCall();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.engine.leaveChannel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MentorCameraView(
              rtcEngine: bloc.engine,
              remoteUidStatus: bloc.remoteUidStatus,
              channelName: bloc.channelName,
            ),
            MyCameraView(
                rtcEngine: bloc.engine,
                localUserJoinedStatus: bloc.localUserJoinedStatus),
            CallToolBarView(engine: bloc.engine),
          ],
        ),
      ),
    );
  }
}
