import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditWorkingHourBottomSheetsUtil {
  StreamController<bool> valueListenable = StreamController<bool>.broadcast();
  Future workingHour(
      {required BuildContext context,
      required String dayname,
      required List<CheckBox> listOfWorkingHour,
      required Function(List<int>) onSave}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    const Expanded(child: SizedBox()),
                    Column(
                      children: [
                        CustomText(
                          title: AppLocalizations.of(context)!.editworkingHour,
                          textColor: Colors.black,
                          fontSize: 18,
                        ),
                        CustomText(
                          title: dayname,
                          textColor: Colors.black,
                          fontSize: 18,
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: InkWell(
                        onTap: () {
                          List<int> listOfSelectedHour = [];

                          for (CheckBox item in listOfWorkingHour) {
                            if (item.isEnable) {
                              listOfSelectedHour.add(convertHourStringToInt(item.value));
                            }
                          }

                          onSave(listOfSelectedHour);
                          Navigator.pop(context);
                        },
                        child: const CustomText(
                          title: "Save",
                          textColor: Color(0xff444444),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                      itemCount: listOfWorkingHour.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              title: listOfWorkingHour[index].value,
                              textColor: Colors.black,
                              fontSize: 18,
                            ),
                            StreamBuilder<bool>(
                                stream: valueListenable.stream,
                                builder: (context, snapshot) {
                                  return Checkbox(
                                      value: listOfWorkingHour[index].isEnable,
                                      onChanged: (va) {
                                        listOfWorkingHour[index].isEnable = !listOfWorkingHour[index].isEnable;
                                        valueListenable.sink.add(true);
                                      });
                                }),
                          ],
                        );
                      }),
                )
              ],
            ),
          );
        });
  }

  int convertHourStringToInt(String value) {
    if (value == "1:00 pm") {
      return 1;
    } else if (value == "2:00 pm") {
      return 2;
    } else if (value == "3:00 pm") {
      return 3;
    } else if (value == "4:00 pm") {
      return 4;
    } else if (value == "5:00 pm") {
      return 5;
    } else if (value == "6:00 pm") {
      return 6;
    } else if (value == "7:00 pm") {
      return 7;
    } else if (value == "8:00 pm") {
      return 8;
    } else if (value == "9:00 pm") {
      return 9;
    } else if (value == "10:00 pm") {
      return 10;
    } else if (value == "11:00 pm") {
      return 11;
    } else if (value == "12:00 pm") {
      return 12;
    } else if (value == "1:00 am") {
      return 13;
    } else if (value == "2:00 am") {
      return 14;
    } else if (value == "3:00 am") {
      return 15;
    } else if (value == "4:00 am") {
      return 16;
    } else if (value == "5:00 am") {
      return 17;
    } else if (value == "6:00 am") {
      return 18;
    } else if (value == "7:00 am") {
      return 19;
    } else if (value == "8:00 am") {
      return 20;
    } else if (value == "9:00 am") {
      return 21;
    } else if (value == "10:00 am") {
      return 22;
    } else if (value == "11:00 am") {
      return 23;
    } else {
      return 0;
    }
  }
}
