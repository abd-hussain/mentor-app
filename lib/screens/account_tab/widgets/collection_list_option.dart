import 'package:flutter/material.dart';
import 'package:mentor_app/models/profile_options.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

class CollectionListOptionView extends StatelessWidget {
  final double containerHight;
  final List<ProfileOptions> listOfOptions;
  const CollectionListOptionView({super.key, required this.containerHight, required this.listOfOptions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHight,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, 0.1),
          ),
        ],
      ),
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listOfOptions.length,
          separatorBuilder: (BuildContext context, int index) => const Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Divider(),
              ),
          itemBuilder: (ctx, index) {
            return InkWell(
              onTap: () => listOfOptions[index].onTap(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      listOfOptions[index].icon,
                      size: 20,
                      color: listOfOptions[index].iconColor,
                    ),
                    const SizedBox(width: 8),
                    CustomText(
                        title: listOfOptions[index].name,
                        fontSize: 16,
                        textColor: listOfOptions[index].nameColor,
                        fontWeight: FontWeight.w500),
                    Expanded(child: Container()),
                    listOfOptions[index].selectedItem != ""
                        ? CustomText(
                            title: listOfOptions[index].selectedItem,
                            fontSize: 14,
                            textColor: const Color(0xffFFA200),
                          )
                        : Container(),
                    listOfOptions[index].selectedItemImage != null
                        ? listOfOptions[index].selectedItemImage!
                        : Container(),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 12,
                      color: Color(0xffBFBFBF),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
