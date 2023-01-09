import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/screens/login_screen/login_bloc.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = LoginBloc();
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
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(45),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: bloc.passwordController,
                          hintText: "Password",
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(45),
                          ],
                        ),
                        CustomButton(
                          enableButton: true,
                          onTap: () {},
                        ),
                        // ValueListenableBuilder<AuthenticationBiometricType>(
                        //     valueListenable: widget.bloc.biometricResultNotifier,
                        //     builder: (context, snapshot, child) {
                        //       return (snapshot.isAvailable && widget.bloc.biometricStatus)
                        //           ? biometricButton(context, snapshot.type)
                        //           : Container();
                        //     }),
                        // const SizedBox(height: 25),
                        // StreamBuilder<String?>(
                        //     initialData: '',
                        //     stream: widget.bloc.errorPasswordMessageController.stream,
                        //     builder: (context, snapshot) {
                        //       if (snapshot.data == 'incorrect') {
                        //         return Padding(
                        //           padding: const EdgeInsets.only(bottom: 25),
                        //           child: Center(
                        //             child: InkWell(
                        //               child: CustomText(
                        //                 title: 'Login_Card_ForgotPassword',
                        //                 style: locator<CustomTextStyle>().medium(
                        //                     color: locator<ColorManager>().color(ColorConstants.l_0xff0059FF_d_0xff0059FF),
                        //                     size: 14),
                        //                 shouldFit: false,
                        //               ),
                        //               onTap: () {
                        //                 Navigator.of(context, rootNavigator: true)
                        //                     .pushNamed(RoutesConstants.resetPasswordScreen)
                        //                     .then((value) async {
                        //                   if (value != null) {
                        //                     widget.onStartCallBack!();
                        //                     widget.bloc.biometricStatus = false;
                        //                     widget.bloc.buildController.sink.add(true);
                        //                   }
                        //                 });
                        //               },
                        //             ),
                        //           ),
                        //         );
                        //       } else {
                        //         return const SizedBox();
                        //       }
                        //     }),
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
                    //TODO    // onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.createNewAccount),
                    child: CustomText(
                      textAlign: TextAlign.center,
                      fontSize: 14,
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
}
