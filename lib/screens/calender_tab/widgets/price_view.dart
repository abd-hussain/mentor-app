import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';

class PriceView extends StatelessWidget {
  final double priceBeforeDiscount;
  final double priceAfterDiscount;

  const PriceView({super.key, required this.priceBeforeDiscount, required this.priceAfterDiscount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          CustomText(
            title: AppLocalizations.of(context)!.price,
            fontSize: 14,
            textColor: const Color(0xff554d56),
          ),
          Expanded(child: Container()),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '$priceBeforeDiscount ${getCurrency()} ',
                  style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                TextSpan(
                  text: "$priceAfterDiscount ${getCurrency()}",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getCurrency() {
    final box = Hive.box(DatabaseBoxConstant.userInfo);

    String currency = "JD";
    if (box.get(DatabaseFieldConstant.language) != "en") {
      currency = "د.أ";
    }
    return currency;
  }
}
