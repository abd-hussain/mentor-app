import 'package:flutter/material.dart';
import 'package:mentor_app/models/authentication_models.dart';
import 'package:mentor_app/screens/login_screen/login_bloc.dart';
import 'package:mentor_app/screens/login_screen/widgets/biometric_login_view.dart';
import 'package:mentor_app/shared_widget/email_field.dart';
import 'package:mentor_app/screens/login_screen/widgets/forgot_password_widget.dart';
import 'package:mentor_app/shared_widget/password_field.dart';
import 'package:mentor_app/screens/register_screen/widgets/info_bottom_sheet.dart';
import 'package:mentor_app/shared_widget/background_container.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/loading_view.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/push_notifications/firebase_cloud_messaging_util.dart';
import 'package:mentor_app/utils/push_notifications/notification_manager.dart';
import 'package:mentor_app/utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = LoginBloc();

  @override
  void didChangeDependencies() {
    bloc.maincontext = context;
    bloc.initBiometric(context);
    bloc.handleListeners();

    NotificationManager.init(context: context);

    Future.delayed(const Duration(seconds: 2), () {
      FirebaseCloudMessagingUtil.initConfigure();
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ValueListenableBuilder<LoadingStatus>(
              valueListenable: bloc.loadingStatusNotifier,
              builder: (context, snapshot, child) {
                return snapshot == LoadingStatus.inprogress
                    ? const LoadingView()
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Center(
                              child: CustomText(
                                title: AppLocalizations.of(context)!.appTitle,
                                fontSize: 30,
                                textColor: const Color(0xff444444),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(50, 16, 50, 0),
                              child: CustomText(
                                textColor: Color(0xff191C1F),
                                textAlign: TextAlign.center,
                                title: 'Mentors App',
                                fontSize: 16,
                                maxLins: 2,
                              ),
                            ),
                            BackgroundContainer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30),
                                  EmailFieldLogin(
                                    controller: bloc.emailController,
                                    onClear: () {
                                      bloc.emailController.clear();
                                      bloc.showHideEmailClearNotifier.value =
                                          false;
                                      bloc.fieldsValidations.value = false;
                                    },
                                    onchange: () => bloc.fieldValidation(),
                                    showHideEmailClearNotifier:
                                        bloc.showHideEmailClearNotifier,
                                  ),
                                  const SizedBox(height: 20),
                                  PasswordField(
                                    controller: bloc.passwordController,
                                    onClear: () {
                                      bloc.passwordController.clear();
                                      bloc.showHidePasswordClearNotifier.value =
                                          false;
                                      bloc.fieldsValidations.value = false;
                                    },
                                    onchange: () => bloc.fieldValidation(),
                                    showHidePasswordClearNotifier:
                                        bloc.showHidePasswordClearNotifier,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Center(
                                      child: ValueListenableBuilder<String>(
                                          valueListenable: bloc.errorMessage,
                                          builder: (context, snapshot, child) {
                                            return CustomText(
                                              title: snapshot,
                                              fontSize: 14,
                                              textAlign: TextAlign.center,
                                              textColor: Colors.red,
                                            );
                                          }),
                                    ),
                                  ),
                                  ValueListenableBuilder<bool>(
                                      valueListenable: bloc.fieldsValidations,
                                      builder: (context, snapshot, child) {
                                        return CustomButton(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          buttonTitle:
                                              AppLocalizations.of(context)!
                                                  .login,
                                          enableButton: snapshot,
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            bloc.doLoginCall(
                                              context: context,
                                              userName: bloc
                                                  .emailController.text
                                                  .trim(),
                                              password:
                                                  bloc.passwordController.text,
                                            );
                                          },
                                        );
                                      }),
                                  ValueListenableBuilder<
                                          AuthenticationBiometricType>(
                                      valueListenable:
                                          bloc.biometricResultNotifier,
                                      builder: (context, snapshot, child) {
                                        return (snapshot.isAvailable &&
                                                bloc.biometricStatus)
                                            ? BiometrincLoginView(
                                                biometricType: snapshot.type,
                                                onPress: () async {
                                                  if (!bloc
                                                      .isBiometricAppeared) {
                                                    await bloc.box.get(
                                                                DatabaseFieldConstant
                                                                    .biometricStatus) ==
                                                            'true'
                                                        ? await bloc
                                                            .tryToAuthintecateUserByBiometric(
                                                                context)
                                                        : ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                  "Login_BiometricMssage_BiometricLoginIsDisabled"),
                                                            ),
                                                          );
                                                  }
                                                },
                                              )
                                            : const SizedBox();
                                      }),
                                  const ForgotPasswordWidget(),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(50, 16, 50, 5),
                              child: CustomText(
                                textAlign: TextAlign.center,
                                title: AppLocalizations.of(context)!
                                    .dontHaveAccount,
                                textColor: const Color(0xff212C34),
                                fontSize: 14,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(50, 0, 50, 16),
                              child: InkWell(
                                onTap: () {
                                  final String step = bloc.box.get(
                                          DatabaseFieldConstant
                                              .registrationStep) ??
                                      "0";
                                  final int stepNum = int.parse(step);

                                  final bottomsheet =
                                      RegisterInfoBottomSheetsUtil(
                                          context: context);
                                  bottomsheet.infoBottomSheet(
                                      step: stepNum,
                                      openNext: () {
                                        switch (stepNum) {
                                          case 2:
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(RoutesConstants
                                                    .registerfaze2Screen);
                                            break;
                                          case 3:
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(RoutesConstants
                                                    .registerfaze3Screen);
                                            break;
                                          case 4:
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(RoutesConstants
                                                    .registerfaze4Screen);
                                            break;
                                          case 5:
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(RoutesConstants
                                                    .registerfaze5Screen);
                                            break;
                                          case 6:
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(RoutesConstants
                                                    .registerfaze6Screen);
                                            break;
                                          case 7:
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(RoutesConstants
                                                    .registerfinalfazeScreen);
                                            break;
                                          default:
                                            bottomsheet.termsBottomSheet(
                                                openNext: () {
                                              bloc.box.put(
                                                  DatabaseFieldConstant
                                                      .registrationStep,
                                                  "2");
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pushNamed(RoutesConstants
                                                      .registerfaze2Screen);
                                            });
                                            break;
                                        }
                                      });
                                },
                                child: CustomText(
                                  textAlign: TextAlign.center,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  title: AppLocalizations.of(context)!
                                      .registerAccount,
                                  textColor: const Color(0xff0059FF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              }),
        ),
      ),
    );
  }
}
