import 'package:flutter/material.dart';
import 'package:mentor_app/screens/payments/payments_bloc.dart';
import 'package:mentor_app/screens/payments/widgets/bottom_payment.dart';
import 'package:mentor_app/screens/payments/widgets/tab_header.dart';
import 'package:mentor_app/screens/payments/widgets/tab_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/utils/logger.dart';
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
    logDebugMessage(message: 'Payments init Called ...');

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F5),
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        title: AppLocalizations.of(context)!.payments,
        actions: [
          IconButton(
            onPressed: () {
              PaymentBottomSheetsUtil().paymentsBottomSheet(context);
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabHeaderView(
              selectedTab: (index) {},
            ),
            TabView(
              list: bloc.listOfPayments,
            ),
          ],
        ),
      ),
    );
  }
}
