import 'package:flutter/material.dart';
import 'package:mentor_app/screens/forgot_password/forgot_password_bloc.dart';
import 'package:mentor_app/shared_widget/background_container.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/email_field.dart';
import 'package:mentor_app/shared_widget/loading_view.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final bloc = ForgotPasswordBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Forgot Password init Called ...');
    bloc.maincontext = context;
    bloc.handleListeners();
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
      appBar: customAppBar(title: AppLocalizations.of(context)!.forgotpassword),
      body: ValueListenableBuilder<LoadingStatus>(
          valueListenable: bloc.loadingStatusNotifier,
          builder: (context, snapshot, child) {
            return snapshot == LoadingStatus.inprogress
                ? const LoadingView()
                : GestureDetector(
                    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                    child: Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: BackgroundContainer(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 35, right: 16, bottom: 25),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: CustomText(
                                  maxLins: 2,
                                  title: AppLocalizations.of(context)!
                                      .resetpasswordtitle,
                                  fontSize: 14,
                                  textAlign: TextAlign.center,
                                  textColor: const Color(0xff191C1F),
                                ),
                              ),
                              const SizedBox(height: 20),
                              EmailFieldLogin(
                                controller: bloc.emailFieldController,
                                onClear: () {
                                  bloc.emailFieldController.clear();
                                  bloc.showHideEmailClearNotifier.value = false;
                                  bloc.fieldsValidations.value = false;
                                },
                                onchange: () => bloc.fieldValidation(),
                                showHideEmailClearNotifier:
                                    bloc.showHideEmailClearNotifier,
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
                                      enableButton: snapshot,
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        bloc.doForgotPasswordCall();
                                      },
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
