import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class MyCameraView extends StatelessWidget {
  final RtcEngine rtcEngine;
  const MyCameraView({super.key, required this.rtcEngine});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: 100,
        height: 150,
        child: Center(
            child: AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: rtcEngine,
            canvas: const VideoCanvas(uid: 0),
          ),
        )),
      ),
    );
  }
}
