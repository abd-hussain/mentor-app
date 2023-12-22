import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/categories_model.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/screens/edit_experience/widgets/experiance_since.dart';
import 'package:mentor_app/screens/edit_experience/widgets/majors_view.dart';
import 'package:mentor_app/screens/register_screen/register_fase_3/register_fase3_bloc.dart';
import 'package:mentor_app/screens/register_screen/widgets/certificate_view.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/bio_field.dart';
import 'package:mentor_app/shared_widget/category_field.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/file_holder_field.dart';
import 'package:mentor_app/shared_widget/loading_view.dart';
import 'package:mentor_app/shared_widget/speaking_language_field.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/push_notifications/firebase_cloud_messaging_util.dart';
import 'package:mentor_app/utils/routes.dart';

class RegisterFaze3Screen extends StatefulWidget {
  const RegisterFaze3Screen({super.key});

  @override
  State<RegisterFaze3Screen> createState() => _RegisterFaze3ScreenState();
}

class _RegisterFaze3ScreenState extends State<RegisterFaze3Screen> {
  final bloc = Register3Bloc();

  @override
  void didChangeDependencies() {
    bloc.getlistOfCategories();
    bloc.getListOfMajors();

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
      appBar: customAppBar(title: ""),
      bottomNavigationBar: ValueListenableBuilder<bool>(
          valueListenable: bloc.enableNextBtn,
          builder: (context, snapshot, child) {
            return RegistrationFooterView(
              pageCount: 3,
              pageTitle: AppLocalizations.of(context)!.experiences,
              nextPageTitle: AppLocalizations.of(context)!.workinghour,
              enableNextButton: snapshot,
              nextPressed: () async {
                final navigator = Navigator.of(context);
                await bloc.box.put(TempFieldToRegistrtConstant.bio, bloc.bioController.text);
                await bloc.box.put(TempFieldToRegistrtConstant.category, bloc.selectedCategory!.id.toString());
                await bloc.box.put(TempFieldToRegistrtConstant.experianceSince, bloc.experianceSinceController.text);

                await bloc.box.put(TempFieldToRegistrtConstant.cv, bloc.cv != null ? bloc.cv!.path : "");

                await bloc.box
                    .put(TempFieldToRegistrtConstant.certificates1, bloc.cert1 != null ? bloc.cert1!.path : "");
                await bloc.box
                    .put(TempFieldToRegistrtConstant.certificates2, bloc.cert2 != null ? bloc.cert2!.path : "");
                await bloc.box
                    .put(TempFieldToRegistrtConstant.certificates3, bloc.cert3 != null ? bloc.cert3!.path : "");
                await bloc.box.put(TempFieldToRegistrtConstant.speakingLanguages,
                    bloc.filterListOfSelectedLanguage(bloc.listOfSpeakingLanguageNotifier.value));
                await bloc.box.put(TempFieldToRegistrtConstant.majors,
                    bloc.filterListOfSelectedMajors(bloc.listOfMajorsNotifier.value));

                await bloc.box.put(DatabaseFieldConstant.registrationStep, "4");
                navigator.pushNamed(RoutesConstants.registerfaze4Screen);
              },
            );
          }),
      body: StreamBuilder<LoadingStatus>(
          initialData: LoadingStatus.inprogress,
          stream: bloc.loadingStatusController.stream,
          builder: (context, snapshot) {
            return snapshot.data == LoadingStatus.inprogress
                ? const LoadingView()
                : GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      bloc.validateFieldsForFaze3();
                    },
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            ValueListenableBuilder<List<Category>>(
                                valueListenable: bloc.listOfCategories,
                                builder: (context, snapshot, child) {
                                  return CategoryField(
                                    controller: bloc.categoryController,
                                    listOfCategory: bloc.listOfCategories.value,
                                    selectedCategory: (p0) {
                                      bloc.selectedCategory = p0;
                                      bloc.validateFieldsForFaze3();
                                    },
                                  );
                                }),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                              child: ExperianceSinceField(
                                controller: bloc.experianceSinceController,
                                padding: const EdgeInsets.all(0),
                                onSelected: () {
                                  bloc.validateFieldsForFaze3();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: BioField(
                                bioController: bloc.bioController,
                                onChanged: (text) => bloc.validateFieldsForFaze3(),
                              ),
                            ),
                            CustomText(
                              title: AppLocalizations.of(context)!.speakinglanguage,
                              fontSize: 12,
                              textColor: const Color(0xff444444),
                            ),
                            ValueListenableBuilder<List<CheckBox>>(
                                valueListenable: bloc.listOfSpeakingLanguageNotifier,
                                builder: (context, snapshot, child) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                                    child: SpeakingLanguageField(
                                      listOfLanguages: snapshot,
                                      selectedLanguage: (language) {
                                        bloc.listOfSpeakingLanguageNotifier.value = language;
                                        bloc.validateFieldsForFaze3();
                                      },
                                    ),
                                  );
                                }),
                            CustomText(
                              title: AppLocalizations.of(context)!.majors,
                              fontSize: 12,
                              textColor: const Color(0xff191C1F),
                            ),
                            ValueListenableBuilder<List<CheckBox>>(
                                valueListenable: bloc.listOfMajorsNotifier,
                                builder: (context, snapshot, child) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                                    child: MajorsView(
                                      listOfMajors: snapshot,
                                      selectedMajors: (major) {
                                        bloc.listOfMajorsNotifier.value = major;
                                        bloc.validateFieldsForFaze3();
                                      },
                                    ),
                                  );
                                }),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(height: 0.5, color: const Color(0xff444444)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FileHolderField(
                                    title: AppLocalizations.of(context)!.cv,
                                    height: 150,
                                    width: MediaQuery.of(context).size.width / 3,
                                    currentFile: null,
                                    onAddFile: (file) {
                                      bloc.cv = file;
                                      bloc.validateFieldsForFaze3();
                                    },
                                    onRemoveFile: () {
                                      bloc.cv = null;
                                      bloc.validateFieldsForFaze3();
                                    },
                                  ),
                                  CertificateView(
                                    width: MediaQuery.of(context).size.width / 2,
                                    height: 40,
                                    onChange: (cert1, cert2, cert3) {
                                      bloc.cert1 = cert1;
                                      bloc.cert2 = cert2;
                                      bloc.cert3 = cert3;

                                      bloc.validateFieldsForFaze3();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
