import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/models/gender_model.dart';
import 'package:mentor_app/shared_widget/bottom_sheet_util.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderField extends StatelessWidget {
  final TextEditingController controller;
  const GenderField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          CustomTextField(
            controller: controller,
            readOnly: true,
            hintText: AppLocalizations.of(context)!.gender,
            padding: const EdgeInsets.only(left: 16, right: 8),
            keyboardType: TextInputType.text,
            inputFormatters: [
              LengthLimitingTextInputFormatter(45),
            ],
            onChange: (text) => {},
          ),
          InkWell(
            onTap: () async {
              await BottomSheetsUtil().genderBottomSheet(context, genderList(context), (selectedGender) {
                controller.text = selectedGender.name;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 16),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 55,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Gender> genderList(BuildContext context) {
    return [
      Gender(
        name: AppLocalizations.of(context)!.gendermale,
        icon: const Icon(Icons.male, color: Color(0xff444444)),
      ),
      Gender(
        name: AppLocalizations.of(context)!.genderfemale,
        icon: const Icon(Icons.female, color: Color(0xff444444)),
      ),
      Gender(
          name: AppLocalizations.of(context)!.genderother,
          icon: const Icon(Icons.align_horizontal_center, color: Color(0xff444444)))
    ];
  }
}