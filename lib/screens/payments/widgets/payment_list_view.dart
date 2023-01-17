import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mentor_app/models/https/payment_model.dart';
import 'package:mentor_app/shared_widget/appointment_details_view.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentListView extends StatelessWidget {
  final List<Payment> list;
  const PaymentListView({required this.list, super.key});

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 0, right: 8, left: 8, bottom: 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xff444444)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _buildExpandableTile(context, list[index]);
                },
              ),
            ),
          )
        : Center(
            child: CustomText(
              title: AppLocalizations.of(context)!.nodatatoshow,
              fontSize: 14,
              textColor: const Color(0xff444444),
            ),
          );
  }

  Widget _buildExpandableTile(BuildContext context, Payment item) {
    return ExpansionTile(
      title: Row(
        children: [
          const Icon(
            Ionicons.receipt_outline,
            color: Color(0xff444444),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              CustomText(
                title: "ID : ${item.id!}",
                fontSize: 12,
                textColor: const Color(0xff444444),
              ),
              CustomText(
                title: item.date!,
                fontSize: 12,
                textColor: const Color(0xff444444),
              ),
            ],
          ),
          Expanded(child: Container()),
          CustomText(
            title: "${item.amount!} JD",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textColor: const Color(0xff444444),
          ),
        ],
      ),
      children: <Widget>[
        AppointmentDetailsView(
          title: "Date",
          desc: item.date!,
        ),
        AppointmentDetailsView(
          title: "Time",
          desc: item.date!,
        ),
        AppointmentDetailsView(
          title: "Day Name",
          desc: item.date!,
        ),
        AppointmentDetailsView(
          title: "Durations",
          desc: item.date!,
        ),
        AppointmentDetailsView(
          title: "Status",
          desc: item.date!,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
                onPressed: () {},
                child: CustomText(
                  title: AppLocalizations.of(context)!.reportproblem,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.red,
                )),
          ),
        ),
      ],
    );
  }
}
