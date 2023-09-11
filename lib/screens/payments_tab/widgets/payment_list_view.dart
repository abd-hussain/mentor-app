import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mentor_app/models/https/payments_response.dart';
import 'package:mentor_app/shared_widget/appointment_details_view.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentListView extends StatelessWidget {
  final List<PaymentResponseData> list;
  final Function(PaymentResponseData) onReportPressed;
  const PaymentListView(
      {required this.list, super.key, required this.onReportPressed});

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? Padding(
            padding:
                const EdgeInsets.only(top: 0, right: 8, left: 8, bottom: 0),
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
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _buildExpandableTile(context, list[index], (item) {
                    onReportPressed(item);
                  });
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

  Widget _buildExpandableTile(BuildContext context, PaymentResponseData item,
      Function(PaymentResponseData) onReportPressed) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime parsedDate =
        DateTime.parse(item.dBMentorPayments!.createdAt!);

    return ExpansionTile(
      title: Row(
        children: [
          Icon(
            Ionicons.receipt_outline,
            color: item.dBMentorPayments!.status! == 1
                ? Colors.orange
                : item.dBMentorPayments!.status! == 2
                    ? Colors.green
                    : Colors.red,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: "ID : ${item.dBMentorPayments!.id!}",
                fontSize: 12,
                textColor: const Color(0xff444444),
              ),
              CustomText(
                title: formatter.format(parsedDate),
                fontSize: 12,
                textColor: const Color(0xff444444),
              ),
            ],
          ),
          Expanded(child: Container()),
          CustomText(
            title: "\$${item.dBMentorPayments!.amount!}",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textColor: const Color(0xff444444),
          ),
        ],
      ),
      children: <Widget>[
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.type,
          desc: item.dBMentorPayments!.type == 1
              ? AppLocalizations.of(context)!.debit
              : AppLocalizations.of(context)!.credit,
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingduration,
          desc:
              "${item.dBMentorPayments!.durations!} ${AppLocalizations.of(context)!.min}",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventdesc,
          desc: item.dBMentorPayments!.descriptions!,
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.note,
          desc: item.dBMentorPayments!.notes ?? "",
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: item.reportMessage != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        title:
                            AppLocalizations.of(context)!.alreadyreportpayment,
                        fontSize: 10,
                        textAlign: TextAlign.center,
                        maxLins: 2,
                        fontWeight: FontWeight.bold,
                        textColor: const Color(0xff444444),
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () => onReportPressed(item),
                    child: CustomText(
                      title: AppLocalizations.of(context)!.reportproblem,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      textColor: Colors.red,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
