import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<bool> showHidePasswordClearNotifier;
  final String hintText;
  final Function() onchange;
  final Function() onClear;
  const PasswordField(
      {super.key,
      required this.controller,
      required this.showHidePasswordClearNotifier,
      required this.onchange,
      this.hintText = "",
      required this.onClear});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> showHidePasswordNotifier = ValueNotifier<bool>(true);

    void showHidePassword() {
      showHidePasswordNotifier.value = !showHidePasswordNotifier.value;
    }

    return SizedBox(
      height: 50,
      child: ValueListenableBuilder<bool>(
          valueListenable: showHidePasswordNotifier,
          builder: (context, showHidePasswordSnapshot, child) {
            return CustomTextField(
              controller: controller,
              hintText: hintText == "" ? AppLocalizations.of(context)!.password : hintText,
              obscureText: showHidePasswordSnapshot,
              inputFormatters: [
                LengthLimitingTextInputFormatter(45),
              ],
              suffixWidget: Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ValueListenableBuilder<bool>(
                        valueListenable: showHidePasswordClearNotifier,
                        builder: (context, snapshot, child) {
                          return snapshot
                              ? IconButton(
                                  onPressed: () => onClear(),
                                  icon: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.grey[500],
                                  ),
                                )
                              : Container();
                        }),
                    IconButton(
                      onPressed: () {
                        showHidePassword();
                      },
                      icon: Icon(
                        showHidePasswordSnapshot ? Icons.visibility : Icons.visibility_off,
                        size: 20,
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                ),
              ),
              onChange: (text) => onchange(),
            );
          }),
    );
  }
}
