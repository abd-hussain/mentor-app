import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

class ClientCameraView extends StatefulWidget {
  final RtcEngine rtcEngine;
  final String channelName;
  final ValueNotifier<int?> remoteUidStatus;
  final Function() timesup;

  const ClientCameraView({
    super.key,
    required this.remoteUidStatus,
    required this.rtcEngine,
    required this.channelName,
    required this.timesup,
  });

  @override
  State<ClientCameraView> createState() => _ClientCameraViewState();
}

class _ClientCameraViewState extends State<ClientCameraView> {
  ValueNotifier<int> loadingForTimer = ValueNotifier<int>(0);
  int timerStartNumberSec = 0;
  int timerStartNumberMin = 0;

  @override
  void initState() {
    timerStartNumberSec = 0;
    timerStartNumberMin = 10;
    loadingForTimer.value = timerStartNumberSec;

    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    loadingForTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<int?>(
          valueListenable: widget.remoteUidStatus,
          builder: (context, snapshot, child) {
            return _remoteVideo(context, snapshot);
          }),
    );
  }

  Widget _remoteVideo(BuildContext context, int? remoteUid) {
    if (remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: widget.rtcEngine,
          canvas: VideoCanvas(uid: remoteUid),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title: AppLocalizations.of(context)!.pleasewaitforclient,
              textAlign: TextAlign.center,
              fontSize: 16,
              textColor: const Color(0xff444444),
            ),
            const SizedBox(height: 8),
            const CircularProgressIndicator(),
            const SizedBox(height: 8),
            CustomText(
              title: AppLocalizations.of(context)!.pleasewaitforclientdesc,
              textAlign: TextAlign.center,
              fontSize: 12,
              maxLins: 5,
              textColor: const Color(0xff444444),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<Object>(
                valueListenable: loadingForTimer,
                builder: (context, snapshot, child) {
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomText(
                      title:
                          "${timerStartNumberMin > 9 ? "$timerStartNumberMin" : "0$timerStartNumberMin"} : ${timerStartNumberSec > 9 ? "$timerStartNumberSec" : "0$timerStartNumberSec"}",
                      textAlign: TextAlign.center,
                      fontSize: 15,
                      textColor: const Color(0xff444444),
                    ),
                  );
                }),
          ],
        ),
      );
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_isTimerFinished()) {
          timer.cancel();
          widget.timesup();
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
