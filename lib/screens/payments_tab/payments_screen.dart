import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/payments_response.dart';
import 'package:mentor_app/screens/home_tab/widgets/header.dart';
import 'package:mentor_app/screens/home_tab/widgets/shimmer_notifications.dart';
import 'package:mentor_app/screens/payments_tab/payments_bloc.dart';
import 'package:mentor_app/screens/payments_tab/widgets/bottom_payment.dart';
import 'package:mentor_app/screens/payments_tab/widgets/payment_list_view.dart';
import 'package:mentor_app/screens/payments_tab/widgets/payment_header_view.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> with TickerProviderStateMixin {
  final bloc = PaymentsBloc();

  @override
  void didChangeDependencies() {
    bloc.getListOfPayments();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderHomePage(),
        Expanded(
          child: ValueListenableBuilder<List<PaymentResponseData>>(
              valueListenable: bloc.paymentListNotifier,
              builder: (context, snapshot, child) {
                return snapshot != []
                    ? Column(
                        children: [
                          PaymentHeaderView(
                            pendingAmount: bloc.pendingTotalAmount,
                            recivedAmount: bloc.recivedTotalAmount,
                            rejectedAmount: bloc.rejectedTotalAmount,
                            currency: bloc.currency,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                  title: AppLocalizations.of(context)!.detailspayments,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  textColor: const Color(0xff444444),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  PaymentBottomSheetsUtil().info(context);
                                },
                                icon: const Icon(
                                  Icons.info,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: PaymentListView(
                              list: snapshot,
                              onReportPressed: (item) {
                                _displayReportDialog(context, item.dBMentorPayments!.id!);
                              },
                            ),
                          ),
                        ],
                      )
                    : const ShimmerNotificationsView();
              }),
        ),
      ],
    );
  }

  Future<void> _displayReportDialog(BuildContext context, int itemId) async {
    TextEditingController controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: CustomText(
              title: AppLocalizations.of(context)!.reportanproblem,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              textColor: const Color(0xff444444),
            ),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: AppLocalizations.of(context)!.describeyourproblem),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: Text(AppLocalizations.of(context)!.submit),
                onPressed: () {
                  setState(() {
                    bloc.reportPayment(itemId, controller.text).whenComplete(() {
                      Navigator.pop(context);
                      bloc.getListOfPayments();
                    });
                  });
                },
              ),
            ],
          );
        });
  }
}
