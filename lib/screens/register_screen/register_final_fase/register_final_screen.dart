import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mentor_app/screens/login_screen/login_screen.dart';
import 'package:mentor_app/screens/register_screen/register_final_fase/register_final_bloc.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/loading_view.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/error/exceptions.dart';
import 'package:mentor_app/utils/push_notifications/firebase_cloud_messaging_util.dart';

class RegisterFinalScreen extends StatefulWidget {
  const RegisterFinalScreen({super.key});

  @override
  State<RegisterFinalScreen> createState() => _RegisterFinalScreenState();
}

class _RegisterFinalScreenState extends State<RegisterFinalScreen> {
  final bloc = RegisterFinalBloc();

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        FirebaseCloudMessagingUtil.initConfigure(context);
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder<LoadingStatus>(
            valueListenable: bloc.loadingStatus,
            builder: (context, snapshot, child) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/animation_lm3q2kl2.zip',
                          width: MediaQuery.of(context).size.width - 16),
                      CustomText(
                        title: AppLocalizations.of(context)!.createprofile,
                        fontSize: 22,
                        textColor: const Color(0xff444444),
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        title: AppLocalizations.of(context)!.createprofiledesc,
                        fontSize: 16,
                        textColor: const Color(0xff444444),
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                          enableButton: true,
                          onTap: () async {
                            final scaffoldMessenger =
                                ScaffoldMessenger.of(context);
                            final navigation = Navigator.of(context);
                            final localization = AppLocalizations.of(context)!;
                            bloc.loadingStatus.value = LoadingStatus.inprogress;

                            try {
                              await bloc
                                  .handleCreatingTheProfile(context)
                                  .then((value) async {
                                bloc.loadingStatus.value = LoadingStatus.finish;
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                      content: Text(localization
                                          .accountcreatedsuccessfully)),
                                );
                                await bloc.clearRegistrationData();

                                navigation.pushReplacement(
                                    MaterialPageRoute(builder: (ctx) {
                                  return const LoginScreen();
                                }));
                              });
                            } on DioException catch (e) {
                              final error = e.error as HttpException;
                              bloc.loadingStatus.value = LoadingStatus.finish;
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                    content: Text(error.message.toString())),
                              );
                            }
                          }),
                    ],
                  ),
                  snapshot == LoadingStatus.inprogress
                      ? const LoadingView(fullScreen: true)
                      : Container()
                ],
              );
            }),
      ),
    );
  }
}
