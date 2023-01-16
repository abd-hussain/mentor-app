import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/payment_model.dart';
import 'package:mentor_app/screens/payments/widgets/sub_view.dart';

class TabView extends StatelessWidget {
  final List<Payment> list;
  const TabView({required this.list, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        physics: const BouncingScrollPhysics(),
        children: [
          SubView(
            type: SubViewType.pending,
            list: list.where((element) => element.status == "pending").toList(),
          ),
          SubView(
            type: SubViewType.progress,
            list: list.where((element) => element.status == "progress").toList(),
          ),
          SubView(
            type: SubViewType.compleated,
            list: list.where((element) => element.status == "compleated").toList(),
          ),
        ],
      ),
    );
  }
}
