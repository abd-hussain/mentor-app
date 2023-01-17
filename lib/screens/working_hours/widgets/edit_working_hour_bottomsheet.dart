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
      required List<WorkingHour> listOfWorkingHour,
      required Function(List<WorkingHour>) onSave}) {
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
                          onSave(listOfWorkingHour);
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
}
