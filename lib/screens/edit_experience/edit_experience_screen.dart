import 'package:flutter/material.dart';
import 'package:mentor_app/screens/edit_experience/edit_experience_bloc.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:mentor_app/utils/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditExperienceScreen extends StatefulWidget {
  const EditExperienceScreen({super.key});

  @override
  State<EditExperienceScreen> createState() => _EditExperienceScreenState();
}

class _EditExperienceScreenState extends State<EditExperienceScreen> {
  final bloc = EditExperienceBloc();
  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Edit Experience init Called ...');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF3F4F5),
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(title: AppLocalizations.of(context)!.editprofileeinexperiances),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                        offset: const Offset(0, 0.1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: TextEditingController(),
                          hintText: "Latest C.V",
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: TextEditingController(),
                          hintText: "City",
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: TextEditingController(),
                          hintText: "Current Job Title",
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: TextEditingController(),
                          hintText: "Experiance in Years",
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: TextEditingController(),
                          hintText: "ID",
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: TextEditingController(),
                          hintText: "category",
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: TextEditingController(),
                          hintText: "tags of mentors",
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: TextEditingController(),
                          hintText: "Cirtificates",
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              CustomButton(
                  enableButton: bloc.enableSaveButton,
                  onTap: () {
                    //TODO
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
