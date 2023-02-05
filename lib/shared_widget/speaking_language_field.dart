import 'package:flutter/material.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/shared_widget/bottom_sheet_util.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

class SpeakingLanguageField extends StatefulWidget {
  final List<CheckBox> listOfLanguages;
  final Function(List<CheckBox>) selectedLanguage;

  const SpeakingLanguageField({required this.listOfLanguages, required this.selectedLanguage, super.key});

  @override
  State<SpeakingLanguageField> createState() => _SpeakingLanguageFieldState();
}

class _SpeakingLanguageFieldState extends State<SpeakingLanguageField> {
  @override
  Widget build(BuildContext context) {
    List<String> listOfSelectedLanguages = [];

    for (CheckBox item in widget.listOfLanguages) {
      if (item.isEnable) {
        listOfSelectedLanguages.add(item.value);
      }
    }

    return InkWell(
      onTap: () async {
        await BottomSheetsUtil().speakingLanguageBottomSheet(context, widget.listOfLanguages, (languageSelected) {
          widget.selectedLanguage(languageSelected);
        });
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE8E8E8)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: listOfSelectedLanguages.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xffE8E8E8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: CustomText(
                      title: listOfSelectedLanguages[index],
                      fontSize: 14,
                      textColor: const Color(0xff444444),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
