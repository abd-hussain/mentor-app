import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/register_fase6_bloc.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/email_header.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/password_complexity.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:mentor_app/shared_widget/password_field.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterFaze6Screen extends StatefulWidget {
  const RegisterFaze6Screen({super.key});

  @override
  State<RegisterFaze6Screen> createState() => _RegisterFaze6ScreenState();
}

class _RegisterFaze6ScreenState extends State<RegisterFaze6Screen> {
  final bloc = Register6Bloc();

  @override
  void didChangeDependencies() {
    bloc.handleListeners();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (bloc.emailController.text.isEmpty) {
          bloc.validateEmail.value = "";
        } else {
          bloc.validateEmailMethod(context);
        }
      },
      child: Scaffold(
        appBar: customAppBar(title: ""),
        bottomNavigationBar: ValueListenableBuilder<bool>(
            valueListenable: bloc.enableNextBtn,
            builder: (context, snapshot, child) {
              return RegistrationFooterView(
                pageCount: 6,
                pageTitle: AppLocalizations.of(context)!.setuppassword,
                nextPageTitle: AppLocalizations.of(context)!.readytogo,
                enableNextButton: snapshot,
                nextPressed: () async {
                  final navigator = Navigator.of(context);
                  await bloc.box.put(TempFieldToRegistrtConstant.email,
                      bloc.emailController.text);
                  await bloc.box.put(TempFieldToRegistrtConstant.password,
                      bloc.passwordController.text);
                  await bloc.box
                      .put(DatabaseFieldConstant.registrationStep, "7");
                  navigator.pushNamed(RoutesConstants.registerfinalfazeScreen);
                },
              );
            }),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const EmailHeader(),
                CustomTextField(
                  controller: bloc.emailController,
                  hintText: AppLocalizations.of(context)!.emailaddress,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(35),
                  ],
                  onChange: (text) {
                    bloc.validateFieldsForFaze6();
                  },
                ),
                ValueListenableBuilder<String>(
                    valueListenable: bloc.validateEmail,
                    builder: (context, snapshot, child) {
                      if (snapshot == "") {
                        return Container();
                      } else {
                        return Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: CustomText(
                                title: snapshot == ""
                                    ? AppLocalizations.of(context)!
                                        .emailformatvalid
                                    : snapshot,
                                fontSize: 12,
                                textColor:
                                    snapshot == "" ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                const SizedBox(height: 30),
                PasswordField(
                  controller: bloc.passwordController,
                  showHidePasswordClearNotifier:
                      bloc.showHidePasswordClearNotifier,
                  onClear: () {
                    bloc.passwordController.clear();
                    bloc.showHidePasswordClearNotifier.value = false;
                  },
                  onchange: () => bloc.validateFieldsForFaze6(),
                ),
                const SizedBox(height: 20),
                PasswordField(
                  controller: bloc.confirmPasswordController,
                  hintText: AppLocalizations.of(context)!.confirmpassword,
                  showHidePasswordClearNotifier:
                      bloc.showHideConfirmPasswordClearNotifier,
                  onClear: () {
                    bloc.confirmPasswordController.clear();
                    bloc.showHideConfirmPasswordClearNotifier.value = false;
                  },
                  onchange: () => bloc.validateFieldsForFaze6(),
                ),
                const SizedBox(height: 20),
                PasswordComplexity(
                  passwordEquilConfirmPasswordNotifier:
                      bloc.passwordEquilConfirmPasswordNotifier,
                  passwordHaveNumberNotifier: bloc.passwordHaveNumberNotifier,
                  passwordMoreThan8CharNotifier:
                      bloc.passwordMoreThan8CharNotifier,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
