import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mentor_app/models/authentication_models.dart';
import 'package:mentor_app/screens/login_screen/login_bloc.dart';
import 'package:mentor_app/screens/register_screen/widgets/info_bottom_sheet.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
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
    bloc.handleListeners();
    bloc.initBiometric(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  //TODO: handle biometrics

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(15, 4, 3, 3),
                            spreadRadius: 0.1,
                            blurRadius: 0.1,
                            offset: Offset(0.1, 2),
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        CustomTextField(
                          controller: bloc.emailController,
                          hintText: AppLocalizations.of(context)!.emailaddress,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(45),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: bloc.passwordController,
                          hintText: AppLocalizations.of(context)!.password,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(45),
                          ],
                        ),
                        CustomButton(
                          buttonTitle: AppLocalizations.of(context)!.login,
                          enableButton: true, //TODO : Handle Validation
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            //TODO : Handle Validation
                            //TODO : Handle Login
                            bloc.doLoginCall(
                              context: context,
                              userName: bloc.emailController.text.trim(),
                              password: bloc.passwordController.text,
                            );
                          },
                        ),
                        ValueListenableBuilder<AuthenticationBiometricType>(
                            valueListenable: bloc.biometricResultNotifier,
                            builder: (context, snapshot, child) {
                              return (snapshot.isAvailable && bloc.biometricStatus)
                                  ? biometricButton(context, snapshot.type)
                                  : const SizedBox();
                            }),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 16, 50, 5),
                  child: CustomText(
                    textAlign: TextAlign.center,
                    title: AppLocalizations.of(context)!.dontHaveAccount,
                    textColor: const Color(0xff212C34),
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 16),
                  child: InkWell(
                    onTap: () {
                      final String step = bloc.box.get(DatabaseFieldConstant.registrationStep) ?? "0";
                      final int stepNum = int.parse(step);

                      final bottomsheet = RegisterInfoBottomSheetsUtil(context: context);
                      bottomsheet.infoBottomSheet(
                          step: stepNum,
                          openNext: () {
                            if (stepNum == 0) {
                              bottomsheet.termsBottomSheet(openNext: () {
                                bloc.box.put(DatabaseFieldConstant.registrationStep, "1");
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(RoutesConstants.registerfaze2Screen);
                              });
                            } else if (stepNum == 1) {
                              Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.registerfaze2Screen);
                            } else if (stepNum == 2) {
                              Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.registerfaze2Screen);
                            }
                          });
                    },
                    child: CustomText(
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      title: AppLocalizations.of(context)!.registerAccount,
                      textColor: const Color(0xff0059FF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding biometricButton(BuildContext context, BiometricType? biometricType) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16, right: 16),
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Container(
                      height: 1,
                      color: const Color(0xffE8E8E8),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  color: Colors.white,
                  width: 30,
                  child: const Center(
                    child: CustomText(
                      title: 'OR',
                      fontSize: 12,
                      textColor: Color(0xff8F8F8F),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: const BorderSide(
                      color: Color(0xffE8E8E8),
                    ),
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: CustomText(
                      title: 'Login_Biometric',
                      textColor: Color(0xff191C1F),
                      fontSize: 14,
                    ),
                  ),
                  Image.asset(
                    (biometricType == BiometricType.face) ? 'assets/images/face_id.png' : 'assets/images/touch_id.png',
                    height: 30,
                    color: const Color(0xff191C1F),
                    alignment: Alignment.center,
                  ),
                ],
              ),
              onPressed: () async {
                if (!bloc.isBiometricAppeared) {
                  await bloc.box.get(DatabaseFieldConstant.biometricStatus) == 'true'
                      ? await bloc.tryToAuthintecateUserByBiometric(context)
                      : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Login_BiometricMssage_BiometricLoginIsDisabled"),
                        ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
