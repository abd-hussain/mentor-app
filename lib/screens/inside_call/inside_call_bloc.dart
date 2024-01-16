import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/services/appointments_service.dart';

class InsideCallBloc {
  String channelName = "";
  int callID = 0;
  int meetingDurationInMin = 0;
  ValueNotifier<RtcEngine?> engineNotifier = ValueNotifier<RtcEngine?>(null);

  String? appId = "67fa993d64a346e1a2587f4a8b96f569";
  String generatedCallToken = "";
  ValueNotifier<int?> remoteUidStatus = ValueNotifier<int?>(null);
  final infoStrings = <String>[];

  void handleReadingArguments(BuildContext context,
      {required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      channelName = newArguments["channelName"] as String;
      callID = newArguments["callID"] as int;
      meetingDurationInMin = newArguments["durations"] as int;
    }
  }

  Future<void> initializeCall() async {
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();

    VideoEncoderConfiguration configuration = const VideoEncoderConfiguration(
      dimensions: VideoDimensions(width: 1920, height: 1080),
      orientationMode: OrientationMode.orientationModeAdaptive,
    );

    await engineNotifier.value!.setVideoEncoderConfiguration(configuration);
    await engineNotifier.value!.joinChannel(
      token: generatedCallToken,
      channelId: channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _initAgoraRtcEngine() async {
    engineNotifier.value = createAgoraRtcEngine();

    await engineNotifier.value!.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    await engineNotifier.value!
        .setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engineNotifier.value!.enableVideo();
    await engineNotifier.value!.startPreview();
  }

  void _addAgoraEventHandlers() {
    engineNotifier.value!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
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

  Future<void> joinAppointment(
      {required int id, required String channelName}) async {
    locator<AppointmentsService>()
        .joinCall(id: id, channelName: channelName)
        .then((value) {
      generatedCallToken = value["data"];
      initializeCall();
    });
  }

  Future<void> exitAppointment({required int id}) {
    return locator<AppointmentsService>().exitCall(id: id);
  }
}
