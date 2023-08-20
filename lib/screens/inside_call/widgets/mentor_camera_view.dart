import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class MentorCameraView extends StatelessWidget {
  final RtcEngine rtcEngine;
  final String channelName;
  final ValueNotifier<int?> remoteUidStatus;
  const MentorCameraView(
      {super.key, required this.remoteUidStatus, required this.rtcEngine, required this.channelName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<int?>(
          valueListenable: remoteUidStatus,
          builder: (context, snapshot, child) {
            return _remoteVideo(snapshot);
          }),
    );
  }

  Widget _remoteVideo(int? remoteUid) {
    if (remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: rtcEngine,
          canvas: VideoCanvas(uid: remoteUid),
          connection: RtcConnection(channelId: channelName),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
