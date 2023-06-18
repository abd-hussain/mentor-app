import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/register_fase6_bloc.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

enum OTPSTATUS {
  idk,
  notValid,
  valid,
}

class PinField extends StatefulWidget {
  final TextEditingController pinController;
  final Register6Bloc bloc;

  const PinField({super.key, required this.pinController, required this.bloc});

  @override
  State<PinField> createState() => _PinFieldState();
}

class _PinFieldState extends State<PinField> {
  ValueNotifier<OTPSTATUS> otpValidationStatus = ValueNotifier<OTPSTATUS>(OTPSTATUS.idk);
  int timerStartNumberSec = 0;
  int timerStartNumberMin = 0;

  Timer? timer;

  @override
  void didChangeDependencies() {
    widget.bloc.emailController.addListener(() {
      timerStartNumberSec = 0;
      timerStartNumberMin = 0;
      widget.pinController.text = "";
      otpValidationStatus.value = OTPSTATUS.idk;
    });

    widget.pinController.addListener(() {
      if (widget.pinController.text.length == 6) {
        if (widget.pinController.text == "000000") {
          otpValidationStatus.value = OTPSTATUS.valid;
          widget.bloc.fieldShowingStatus.value = FieldCanShow.phoneNumber;
        } else {
          otpValidationStatus.value = OTPSTATUS.notValid;
        }
        // bloc.callVerifyRequset().then((value) async {
        //   if (value.data != null) {
        //     bloc.otpNotValid.value = false;
        //     await Navigator.of(context, rootNavigator: true).pushNamed(
        //       RoutesConstants.loginFourthStepRoute,
        //       arguments: {
        //         AppConstant.tokenToPass: value.data!.token,
        //         AppConstant.useridToPass: bloc.userId,
        //       },
        //     );
        //   } else {
        //     bloc.otpNotValid.value = true;
        //   }
        // });
      }
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer!.cancel();
    otpValidationStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ValueListenableBuilder<OTPSTATUS>(
          valueListenable: otpValidationStatus,
          builder: (context, snapshot, child) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blueGrey),
                        ),
                        child: TextField(
                          maxLength: 6,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          controller: widget.pinController,
                          readOnly: snapshot == OTPSTATUS.valid,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 0),
                            border: InputBorder.none,
                            counterText: "",
                            floatingLabelAlignment: FloatingLabelAlignment.center,
                            hintStyle: TextStyle(color: Colors.black54, fontSize: 18),
                            hintText: "Your OTP Code",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    snapshot == OTPSTATUS.valid
                        ? const Expanded(
                            flex: 1,
                            child: Icon(
                              Ionicons.checkmark,
                              color: Colors.green,
                              size: 40,
                            ),
                          )
                        : Expanded(
                            flex: 1,
                            child: timerStartNumberMin == 0 && timerStartNumberSec == 0
                                ? CustomButton(
                                    buttonTitle: "Send Code",
                                    enableButton: true,
                                    padding: const EdgeInsets.all(0),
                                    onTap: () async {
                                      // await bloc.callRequestOfAuthAgain().then((value) {
                                      //   bloc.resetTimer();
                                      timerStartNumberMin = 1;
                                      timerStartNumberSec = 30;
                                      startTimer();
                                      //   logger.wtf("value.data!.lastOtp");
                                      //   logger.wtf(value.data!.lastOtp);
                                      setState(() {});
                                      // });
                                    })
                                : Center(
                                    child: CustomText(
                                      title: timerStartNumberSec > 9
                                          ? "0$timerStartNumberMin:$timerStartNumberSec"
                                          : "0$timerStartNumberMin:0$timerStartNumberSec",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      textColor: timerStartNumberMin == 0 && timerStartNumberSec <= 10
                                          ? Colors.red
                                          : const Color(0xff4CB6EA),
                                    ),
                                  ),
                          ),
                  ],
                ),
                const SizedBox(height: 4),
                snapshot == OTPSTATUS.notValid
                    ? const Row(
                        children: [
                          CustomText(
                            title: "OTP Is Not Valid",
                            fontSize: 14,
                            textAlign: TextAlign.start,
                            textColor: Colors.red,
                          ),
                        ],
                      )
                    : Container(),
              ],
            );
          }),
    );
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (timerStartNumberMin == 0 && timerStartNumberSec == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            if (timerStartNumberSec > 0) {
              timerStartNumberSec = timerStartNumberSec - 1;
            } else {
              timerStartNumberMin = timerStartNumberMin - 1;
              timerStartNumberSec = 59;
            }
          });
        }
      },
    );
  }
}
