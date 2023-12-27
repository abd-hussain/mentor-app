import 'package:flutter/material.dart';
import 'package:mentor_app/screens/inside_call/inside_call_bloc.dart';
import 'package:mentor_app/screens/inside_call/widgets/client_camera_view.dart';
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
    bloc.handleReadingArguments(context, arguments: ModalRoute.of(context)!.settings.arguments);
    bloc.initializeCall();
    bloc.joinAppointment(id: bloc.callID);
    super.didChangeDependencies();
  }

  //TODO: handle when the call is established the time for it

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
            ClientCameraView(
              rtcEngine: bloc.engine,
              remoteUidStatus: bloc.remoteUidStatus,
              channelName: bloc.channelName,
              timesup: () async {
                await bloc.exitAppointment(id: bloc.callID);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
            MyCameraView(rtcEngine: bloc.engine),
            CallToolBarView(
              engine: bloc.engine,
              callEnd: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
