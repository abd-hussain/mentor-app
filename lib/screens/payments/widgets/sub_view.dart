import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mentor_app/models/https/payment_model.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum SubViewType { pending, progress, compleated }

class SubView extends StatelessWidget {
  final SubViewType type;
  final List<Payment> list;
  const SubView({required this.type, required this.list, super.key});

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(
                          Ionicons.receipt_outline,
                          color: Color(0xff444444),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      title: "ID : ${list[index].id!}",
                                      fontSize: 12,
                                      textColor: const Color(0xff444444),
                                    ),
                                    Expanded(child: Container()),
                                    CustomText(
                                      title: list[index].date!,
                                      fontSize: 12,
                                      textColor: const Color(0xff444444),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    title: list[index].name!,
                                    fontSize: 16,
                                    textColor: const Color(0xff444444),
                                    maxLins: 5,
                                  ),
                                ),
                                CustomText(
                                  title: list[index].amount!.toString(),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  textColor: const Color(0xff444444),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: CustomText(
              title: AppLocalizations.of(context)!.nodatatoshow,
              fontSize: 14,
              textColor: const Color(0xff444444),
            ),
          );
  }
}
