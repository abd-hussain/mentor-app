import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/models/https/categories_model.dart';
import 'package:mentor_app/shared_widget/bottom_sheet_util.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryField extends StatelessWidget {
  final TextEditingController controller;
  final bool isEnable;
  final EdgeInsets padding;
  final List<Category> listOfCategory;
  final Function(Category) selectedCategory;
  const CategoryField(
      {required this.controller,
      this.padding = const EdgeInsets.only(left: 16, right: 16),
      required this.listOfCategory,
      required this.selectedCategory,
      this.isEnable = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomTextField(
          readOnly: true,
          enabled: isEnable,
          controller: controller,
          hintText: AppLocalizations.of(context)!.selectCategory,
          padding: padding,
          keyboardType: TextInputType.name,
          inputFormatters: [
            LengthLimitingTextInputFormatter(45),
          ],
        ),
        InkWell(
          onTap: isEnable
              ? () async {
                  await BottomSheetsUtil().categoryBottomSheet(context, listOfCategory, (categorySelected) {
                    controller.text = categorySelected.name!;
                    selectedCategory(categorySelected);
                  });
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55,
            ),
          ),
        ),
      ],
    );
  }
}
