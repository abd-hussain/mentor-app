import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/categories_model.dart';
import 'package:mentor_app/screens/register_screen/register_bloc.dart';
import 'package:mentor_app/shared_widget/category_field.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/file_holder_field.dart';

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
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFieldsForFaze3();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                        maxLines: 5,
                        maxLength: 200,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FileHolderField(
                  title: AppLocalizations.of(context)!.cv,
                  onAddFile: (file) {
                    bloc.cv = file;
                    bloc.validateFieldsForFaze3();
                  },
                  onRemoveFile: () {
                    bloc.cv = null;
                    bloc.validateFieldsForFaze3();
                  },
                ),
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
                  child: ValueListenableBuilder<int>(
                      valueListenable: bloc.countOfCertifictes,
                      builder: (context, snapshot, child) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: bloc.countOfCertifictes.value,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  FileHolderField(
                                    title: "Certificate (${index + 1})",
                                    onAddFile: (file) {
                                      bloc.certificatesList.add(file);
                                      bloc.validateFieldsForFaze3();
                                    },
                                    onRemoveFile: () {
                                      bloc.certificatesList.removeAt(index);
                                      bloc.validateFieldsForFaze3();
                                    },
                                  ),
                                  const Expanded(child: SizedBox()),
                                  IconButton(
                                      onPressed: () {
                                        bloc.certificatesList = [];
                                        if (index == 0) {
                                          bloc.countOfCertifictes.value = bloc.countOfCertifictes.value + 1;
                                        } else {
                                          bloc.countOfCertifictes.value = bloc.countOfCertifictes.value - 1;
                                        }
                                      },
                                      icon: Container(
                                        width: 100,
                                        height: 100,
                                        color: index == 0 ? Colors.green[200] : Colors.red[200],
                                        child: Icon(
                                          index == 0 ? Icons.add : Icons.remove,
                                          color: const Color(0xff444444),
                                        ),
                                      ))
                                ],
                              ),
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
