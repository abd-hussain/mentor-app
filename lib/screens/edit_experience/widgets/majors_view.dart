import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MajorsView extends StatefulWidget {
  final List<CheckBox> listOfMajors;
  final Function(List<CheckBox>) selectedMajors;

  const MajorsView(
      {super.key, required this.listOfMajors, required this.selectedMajors});

  @override
  State<MajorsView> createState() => _MajorsViewState();
}

class _MajorsViewState extends State<MajorsView> {
  List<String> listOfSelectedMajors = [];

  @override
  void initState() {
    for (CheckBox item in widget.listOfMajors) {
      if (item.isEnable) {
        listOfSelectedMajors.add(item.value);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await majorsBottomSheet(
            context: context,
            listOfMajors: widget.listOfMajors,
            onSave: (selected) {
              setState(() {
                listOfSelectedMajors = [];
                for (CheckBox item in selected) {
                  if (item.isEnable) {
                    listOfSelectedMajors.add(item.value);
                  }
                }
                widget.selectedMajors(selected);
              });
            });
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffE8E8E8)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: listOfSelectedMajors.length,
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
                      title: listOfSelectedMajors[index],
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

Future majorsBottomSheet(
    {required BuildContext context,
    required List<CheckBox> listOfMajors,
    required Function(List<CheckBox>) onSave}) {
  StreamController<bool> valueListenable = StreamController<bool>.broadcast();

  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                CustomText(
                  title: AppLocalizations.of(context)!.majors,
                  textColor: Colors.black,
                  fontSize: 18,
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: InkWell(
                    onTap: () {
                      onSave(listOfMajors);
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: listOfMajors.length,
                  itemBuilder: ((context, index) {
                    return Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: CustomText(
                            title: listOfMajors[index].value,
                            textColor: Colors.black,
                            fontSize: 15,
                            maxLins: 3,
                          ),
                        ),
                        Expanded(child: Container()),
                        StreamBuilder<bool>(
                            stream: valueListenable.stream,
                            builder: (context, snapshot) {
                              return Checkbox(
                                  value: listOfMajors[index].isEnable,
                                  onChanged: (va) {
                                    listOfMajors[index].isEnable =
                                        !listOfMajors[index].isEnable;
                                    valueListenable.sink.add(true);
                                  });
                            }),
                      ],
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}
