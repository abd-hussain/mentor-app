import 'package:flutter/material.dart';
import 'package:mentor_app/screens/register_screen/register_fase_7/register_fase7_bloc.dart';
import 'package:mentor_app/screens/register_screen/register_fase_7/widgets/password_complexity.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/password_field.dart';

class RegisterFaze7Screen extends StatefulWidget {
  const RegisterFaze7Screen({super.key});

  @override
  State<RegisterFaze7Screen> createState() => _RegisterFaze7ScreenState();
}

class _RegisterFaze7ScreenState extends State<RegisterFaze7Screen> {
  final bloc = Register7Bloc();

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
        bloc.validateFieldsForFaze7();
      },
      child: Scaffold(
        appBar: customAppBar(title: ""),
        bottomNavigationBar: ValueListenableBuilder<bool>(
            valueListenable: bloc.enableNextBtn,
            builder: (context, snapshot, child) {
              return RegistrationFooterView(
                pageCount: 7,
                pageTitle: "Setup Password",
                nextPageTitle: "You will be ready to go",
                enableNextButton: snapshot,
                nextPressed: () async {},
              );
            }),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            bloc.validateFieldsForFaze7();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  PasswordField(
                    controller: bloc.passwordController,
                    showHidePasswordClearNotifier: bloc.showHidePasswordClearNotifier,
                    onClear: () {
                      bloc.passwordController.clear();
                      bloc.showHidePasswordClearNotifier.value = false;
                    },
                    onchange: () => bloc.validateFieldsForFaze7(),
                  ),
                  const SizedBox(height: 20),
                  PasswordField(
                    controller: bloc.confirmPasswordController,
                    hintText: "Confirm Password",
                    showHidePasswordClearNotifier: bloc.showHideConfirmPasswordClearNotifier,
                    onClear: () {
                      bloc.confirmPasswordController.clear();
                      bloc.showHideConfirmPasswordClearNotifier.value = false;
                    },
                    onchange: () => bloc.validateFieldsForFaze7(),
                  ),
                  const SizedBox(height: 20),
                  PasswordComplexity(
                    passwordEquilConfirmPasswordNotifier: bloc.passwordEquilConfirmPasswordNotifier,
                    passwordHaveNumberNotifier: bloc.passwordHaveNumberNotifier,
                    passwordMoreThan8CharNotifier: bloc.passwordMoreThan8CharNotifier,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
