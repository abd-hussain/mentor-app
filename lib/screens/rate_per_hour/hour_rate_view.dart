import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/screens/rate_per_hour/calculation_hours_view.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';

class HourRateView extends StatefulWidget {
  final TextEditingController controller;
  final Function() onTapPlus;
  final Function() onTapMinus;

  const HourRateView({super.key, required this.controller, required this.onTapPlus, required this.onTapMinus});

  @override
  State<HourRateView> createState() => _HourRateViewState();
}

class _HourRateViewState extends State<HourRateView> {
  double recumendedRatePerHour = 22.0;
  ValueNotifier<String> valueEntered = ValueNotifier<String>("22.0");

  @override
  void initState() {
    widget.controller.addListener(() {
      valueEntered.value = widget.controller.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomText(
              title: AppLocalizations.of(context)!.rateperhourdesc1,
              fontSize: 14,
              maxLins: 3,
              textColor: const Color(0xff444444),
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            CustomText(
              title: AppLocalizations.of(context)!.rateperhourdesc2,
              fontSize: 14,
              maxLins: 3,
              textAlign: TextAlign.center,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            CustomText(
              title: AppLocalizations.of(context)!.rateperhourdesc3,
              fontSize: 14,
              textAlign: TextAlign.center,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            CustomText(
              title: "$recumendedRatePerHour \$",
              fontSize: 16,
              textAlign: TextAlign.center,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[200],
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => widget.onTapMinus(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CustomTextField(
                    controller: widget.controller,
                    hintText: AppLocalizations.of(context)!.rateperhour,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                    ],
                    fontSize: 18,
                    textAlign: TextAlign.center,
                    padding: const EdgeInsets.all(0),
                    onEditingComplete: () {
                      if (widget.controller.text.isEmpty) {
                        widget.controller.text = "0.0";
                      }
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[200],
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => widget.onTapPlus(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<String>(
                valueListenable: valueEntered,
                builder: (context, snapshot, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        title: "Calculatoins",
                        fontSize: 14,
                        textAlign: TextAlign.start,
                        textColor: Color(0xff444444),
                        fontWeight: FontWeight.bold,
                      ),
                      CalculationHoursView(
                        timing: "1/4",
                        value: calculateQuarter(snapshot),
                        textColor: const Color(0xff444444),
                        onPress: () {},
                      ),
                      CalculationHoursView(
                        timing: "2/4",
                        value: calculateHalf(snapshot),
                        textColor: const Color(0xff444444),
                        onPress: () {},
                      ),
                      CalculationHoursView(
                        timing: "3/4",
                        value: calculate3Quarter(snapshot),
                        textColor: const Color(0xff444444),
                        onPress: () {},
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  String calculateHalf(String value) {
    double val = double.parse(value == "" ? "0" : value);
    val = val / 2;
    return "$val";
  }

  String calculateQuarter(String value) {
    double val = double.parse(value == "" ? "0" : value);
    val = val / 4;
    return "$val";
  }

  String calculate3Quarter(String value) {
    double val = double.parse(value == "" ? "0" : value);
    val = val / 4 * 3;
    return "$val";
  }
}
