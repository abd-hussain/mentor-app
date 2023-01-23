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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
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
                FileHolderField(onAddImage: (file) {
                  bloc.profileImage = file;
                  bloc.validateFieldsForFaze3();
                }, onDeleteImage: () {
                  bloc.profileImage = null;
                  bloc.profileImageUrl = "";
                  bloc.validateFieldsForFaze3();
                }),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
