import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

class PaymentHeaderView extends StatelessWidget {
  const PaymentHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            item("Total Recived Payment", "215 JD"),
            const SizedBox(width: 16),
            item("Total Pending Payment", "124 JD"),
          ],
        ),
      ),
    );
  }

  Widget item(String title, String amount) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: title,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                textColor: const Color(0xff444444),
              ),
              const SizedBox(height: 8),
              CustomText(
                title: amount,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                textColor: const Color(0xff444444),
              )
            ],
          ),
        ),
      ),
    );
  }
}
