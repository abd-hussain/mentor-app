import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class InsideCallBloc {
  late RtcEngine engine;
  String channelName = "";
  String? appId = "67fa993d64a346e1a2587f4a8b96f569";
  String tempToken =
      "007eJxTYBBfMEdg8f+T2lbvZl/OWu/kI+JWO7vBi0s20dE9LXr21zUKDGbmaYmWlsYpZiaJxiZmqYaJRqYW5mkmiRZJlmZppmaWL0XKUxoCGRn6WCQYGRkgEMRnZyhJLS4xMLdkYAAAL4od0g==";
  ValueNotifier<bool> localUserJoinedStatus = ValueNotifier<bool>(false);
  ValueNotifier<int?> remoteUidStatus = ValueNotifier<int?>(null);
  final infoStrings = <String>[];

  void handleReadingArguments(BuildContext context,
      {required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      channelName = newArguments["channelName"] as String;
    }
  }

  Future<void> initializeCall() async {
    await _initAgoraRtcEngine();

    _addAgoraEventHandlers();

    VideoEncoderConfiguration encoderConfiguration =
        const VideoEncoderConfiguration(
            dimensions: VideoDimensions(width: 1920, height: 1080));
    await engine.setVideoEncoderConfiguration(encoderConfiguration);
    await engine.joinChannel(
      token: tempToken,
      channelId: channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _initAgoraRtcEngine() async {
    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    await engine.setClientRole(role: ClientRoleType.clientRoleAudience);
    await engine.enableVideo();
    await engine.startPreview();
  }

  void _addAgoraEventHandlers() {
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          localUserJoinedStatus.value = true;
        },
        onLeaveChannel: (connection, stats) {
          debugPrint("local user ${connection.localUid} Leave");
          debugPrint("Status $stats");
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          remoteUidStatus.value = remoteUid;
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          remoteUidStatus.value = null;
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );
  }
}
