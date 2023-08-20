import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class MyCameraView extends StatelessWidget {
  final RtcEngine rtcEngine;
  final ValueNotifier<bool> localUserJoinedStatus;
  const MyCameraView({super.key, required this.rtcEngine, required this.localUserJoinedStatus});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: 100,
        height: 150,
        child: Center(
          child: ValueListenableBuilder<bool>(
              valueListenable: localUserJoinedStatus,
              builder: (context, snapshot, child) {
                return snapshot
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: rtcEngine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
