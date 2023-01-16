import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabHeaderView extends StatelessWidget {
  final Function(int) selectedTab;
  const TabHeaderView({required this.selectedTab, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        overlayColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return const Color(0xff4CB6EA);
          }

          return Colors.transparent;
        }),
        indicatorPadding: const EdgeInsets.all(5),
        indicator: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xff034061),
        ),
        physics: const BouncingScrollPhysics(),
        onTap: (int index) => selectedTab(index),
        tabs: [
          Tab(icon: const Icon(Ionicons.layers_outline), child: Text(AppLocalizations.of(context)!.pending)),
          Tab(icon: const Icon(Ionicons.sync), text: AppLocalizations.of(context)!.inprogress),
          Tab(icon: const Icon(Icons.done), text: AppLocalizations.of(context)!.compleated),
        ],
      ),
    );
  }
}
