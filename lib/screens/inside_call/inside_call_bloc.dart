import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/services/appointments_service.dart';

class InsideCallBloc {
  late RtcEngine engine;
  String channelName = "";
  int callID = 0;
  int meetingDurationInMin = 0;

  String? appId = "67fa993d64a346e1a2587f4a8b96f569";
  String callToken = "";

  ValueNotifier<int?> remoteUidStatus = ValueNotifier<int?>(null);
  final infoStrings = <String>[];

  ValueNotifier<int> loadingForTimer = ValueNotifier<int>(0);
  int timerStartNumberSec = 0;
  int timerStartNumberMin = 0;

  void handleReadingArguments(BuildContext context, {required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      channelName = newArguments["channelName"] as String;
      callToken = newArguments["callToken"] as String;
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

    await engine.setVideoEncoderConfiguration(configuration);
    await engine.joinChannel(
      token: callToken,
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
        },
        onLeaveChannel: (connection, stats) {
          debugPrint("local user ${connection.localUid} Leave");
          debugPrint("Status $stats");
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          remoteUidStatus.value = remoteUid;
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          remoteUidStatus.value = null;
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );
  }

  Future<void> joinAppointment({required int id}) {
    return locator<AppointmentsService>().joinCall(id: id);
  }

  Future<void> exitAppointment({required int id}) {
    return locator<AppointmentsService>().exitCall(id: id);
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_isTimerFinished()) {
          timer.cancel();
          //TODO: handle when call finish
        } else {
          _decrementTimer();
          loadingForTimer.value = timerStartNumberSec - 1;
        }
      },
    );
  }

  void _decrementTimer() {
    if (timerStartNumberSec > 0) {
      timerStartNumberSec--;
    } else if (timerStartNumberMin > 0) {
      timerStartNumberMin--;
      timerStartNumberSec = 59;
    }
  }

  bool _isTimerFinished() {
    return timerStartNumberMin == 0 && timerStartNumberSec == 0;
  }
}
