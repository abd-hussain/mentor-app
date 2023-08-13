import 'package:flutter/material.dart';
import 'package:mentor_app/screens/edit_experience/edit_experience_bloc.dart';
import 'package:mentor_app/screens/register_screen/widgets/certificate_view.dart';
import 'package:mentor_app/shared_widget/category_field.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/file_holder_field.dart';
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
    bloc.getUserExperiance();
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
          child: SingleChildScrollView(
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
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          CategoryField(
                            controller: bloc.categoryController,
                            isEnable: false,
                            listOfCategory: const [],
                            selectedCategory: (p0) {},
                          ),
                          const SizedBox(height: 8),
                          FileHolderField(
                            title: AppLocalizations.of(context)!.cv,
                            width: MediaQuery.of(context).size.width,
                            onAddFile: (file) {
                              bloc.cv = file;
                              bloc.validateFields();
                            },
                            onRemoveFile: () {
                              bloc.cv = null;
                              bloc.validateFields();
                            },
                          ),
                          const SizedBox(height: 8),
                          CertificateView(
                            width: 128,
                            certificatesListCallBack: (p0) {
                              bloc.listOfCertificates = p0;
                              bloc.validateFields();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: bloc.enableSaveButton,
                    builder: (context, snapshot, child) {
                      return CustomButton(
                          enableButton: snapshot,
                          onTap: () {
                            //TODO
                            Navigator.of(context).pop();
                          });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
