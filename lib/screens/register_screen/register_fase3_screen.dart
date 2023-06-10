import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/categories_model.dart';
import 'package:mentor_app/screens/register_screen/register_bloc.dart';
import 'package:mentor_app/screens/register_screen/widgets/certificate_view.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/category_field.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/file_holder_field.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/routes.dart';

class RegisterFaze3Screen extends StatefulWidget {
  const RegisterFaze3Screen({super.key});

  @override
  State<RegisterFaze3Screen> createState() => _RegisterFaze3ScreenState();
}

class _RegisterFaze3ScreenState extends State<RegisterFaze3Screen> {
  final bloc = RegisterBloc();

  @override
  void didChangeDependencies() {
    bloc.getlistOfCategories();
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
              pageTitle: "Experiences",
              nextPageTitle: "Working Hours",
              enableNextButton: snapshot,
              nextPressed: () async {
                final navigator = Navigator.of(context);
                await bloc.box.put(TempFieldToRegistrtConstant.bio, bloc.bioController.text);
                await bloc.box.put(TempFieldToRegistrtConstant.category, bloc.selectedCategory!.id.toString());
                await bloc.box.put(TempFieldToRegistrtConstant.cv, bloc.cv.toString());
                await bloc.box.put(TempFieldToRegistrtConstant.certificates, bloc.listOfCertificates.toString());
                await bloc.box.put(DatabaseFieldConstant.registrationStep, "3");
                navigator.pushNamed(RoutesConstants.registerfaze4Screen);
              },
            );
          }),
      body: GestureDetector(
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
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffe0e0e0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: bloc.bioController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.biohint,
                          hintMaxLines: 2,
                          hintStyle: const TextStyle(fontSize: 15),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        onChanged: (text) => bloc.validateFieldsForFaze3(),
                        maxLines: 5,
                        maxLength: 200,
                      ),
                    ),
                  ),
                ),
                FileHolderField(
                  title: AppLocalizations.of(context)!.cv,
                  width: MediaQuery.of(context).size.width,
                  onAddFile: (file) {
                    bloc.cv = file;
                    bloc.validateFieldsForFaze3();
                  },
                  onRemoveFile: () {
                    bloc.cv = null;
                    bloc.validateFieldsForFaze3();
                  },
                ),
                const SizedBox(height: 8),
                CertificateView(
                  certificatesListCallBack: (p0) {
                    bloc.listOfCertificates = p0;
                    bloc.validateFieldsForFaze3();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
