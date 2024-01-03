import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

class CalculationHoursView extends StatelessWidget {
  final String timing;
  final String value;
  final Color textColor;
  final Function() onPress;

  const CalculationHoursView(
      {required this.value,
      super.key,
      this.textColor = const Color(0xff444444),
      required this.onPress,
      required this.timing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 20,
            height: 10,
            decoration: BoxDecoration(
              color: const Color(0xffE4E9EF),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(width: 10),
          CustomText(
            title: timing,
            textColor: textColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            maxLins: 4,
          ),
          CustomText(
            title: " Hour will be: ",
            textColor: textColor,
            fontSize: 12,
          ),
          CustomText(
            title: "$value \$",
            textColor: const Color(0xffFFA200),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textColor != const Color(0xff444444)
              ? IconButton(
                  onPressed: () => onPress(),
                  icon: Icon(
                    Icons.arrow_circle_right,
                    color: textColor,
                  ))
              : const SizedBox(
                  width: 20,
                  height: 20,
                )
        ],
      ),
    );
  }
}
