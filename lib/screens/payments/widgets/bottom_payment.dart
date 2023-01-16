import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentBottomSheetsUtil {
  Future paymentsBottomSheet(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  title: AppLocalizations.of(context)!.paymentoption,
                  textColor: Colors.black,
                  fontSize: 16,
                ),
                const SizedBox(height: 20),
                item(
                  title: "Report Problem",
                  icon: Icons.report,
                  onTap: () {},
                ),
                Container(height: 1, color: const Color(0xff444444)),
                item(
                  title: "Transactions Way",
                  icon: Icons.money_off,
                  onTap: () {},
                ),
                const SizedBox(height: 27.0),
              ],
            ),
          );
        });
  }

  Widget item({required String title, required IconData icon, required Function() onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            SizedBox(width: 40, height: 40, child: Icon(icon)),
            const SizedBox(width: 8),
            Expanded(
              child: CustomText(
                title: title,
                fontSize: 16,
                textColor: const Color(0xff444444),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
