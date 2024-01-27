import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:mentor_app/screens/inside_call/inside_call_bloc.dart';
import 'package:mentor_app/screens/inside_call/widgets/client_camera_view.dart';
import 'package:mentor_app/screens/inside_call/widgets/my_camera_view.dart';
import 'package:mentor_app/screens/inside_call/widgets/timer_end_call_view.dart';
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
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (bloc.engineNotifier.value != null) {
      bloc.engineNotifier.value!.leaveChannel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ValueListenableBuilder<RtcEngine?>(
                valueListenable: bloc.engineNotifier,
                builder: (context, snapshot, child) {
                  if (snapshot != null) {
                    return ClientCameraView(
                      rtcEngine: snapshot,
                      remoteUidStatus: bloc.remoteUidStatus,
                      channelName: bloc.channelName,
                      timesup: () async {
                        await bloc.exitAppointment(id: bloc.callID);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
            ValueListenableBuilder<RtcEngine?>(
                valueListenable: bloc.engineNotifier,
                builder: (context, snapshot, child) {
                  if (snapshot != null) {
                    return MyCameraView(rtcEngine: snapshot);
                  } else {
                    return Container();
                  }
                }),
            ValueListenableBuilder<int?>(
                valueListenable: bloc.remoteUidStatus,
                builder: (context, snapshot, child) {
                  if (snapshot != null) {
                    return TimerEndCallView(
                      meetingDurationInMin: bloc.meetingDurationInMin,
                      timesup: () async {
                        await bloc.exitAppointment(id: bloc.callID);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
            ValueListenableBuilder<RtcEngine?>(
                valueListenable: bloc.engineNotifier,
                builder: (context, snapshot, child) {
                  if (snapshot != null) {
                    return CallToolBarView(
                      engine: snapshot,
                      callEnd: () async {
                        await bloc.exitAppointment(id: bloc.callID);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
