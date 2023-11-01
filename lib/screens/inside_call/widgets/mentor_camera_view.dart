import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MentorCameraView extends StatelessWidget {
  final RtcEngine rtcEngine;
  final String channelName;
  final ValueNotifier<int?> remoteUidStatus;
  const MentorCameraView(
      {super.key,
      required this.remoteUidStatus,
      required this.rtcEngine,
      required this.channelName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<int?>(
          valueListenable: remoteUidStatus,
          builder: (context, snapshot, child) {
            return _remoteVideo(context, snapshot);
          }),
    );
  }

  Widget _remoteVideo(BuildContext context, int? remoteUid) {
    if (remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: rtcEngine,
          canvas: VideoCanvas(uid: remoteUid),
          connection: RtcConnection(channelId: channelName),
        ),
      );
    } else {
      return Text(
        AppLocalizations.of(context)!.pleasewaitforclient,
        textAlign: TextAlign.center,
      );
    }
  }
}
