import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/versioning_model.dart';
import 'package:mentor_app/screens/versioning/widgets/shimmer_versions.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VersionsList extends StatefulWidget {
  final ValueNotifier<List<VersioningData>?> versionsListNotifier;

  const VersionsList({super.key, required this.versionsListNotifier});

  @override
  State<VersionsList> createState() => _VersionsListState();
}

class _VersionsListState extends State<VersionsList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<VersioningData>?>(
        valueListenable: widget.versionsListNotifier,
        builder: (context, data, child) {
          return data == null
              ? const ShimmerVersionsView()
              : widget.versionsListNotifier.value!.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx, index) {
                        return versionTile(context, data[index], index);
                      })
                  : Center(
                      child: CustomText(
                        title: AppLocalizations.of(context)!.noitem,
                        fontSize: 16,
                        textColor: const Color(0xff444444),
                      ),
                    );
        });
  }

  Widget versionTile(BuildContext context, VersioningData item, int index) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Column(
                children: [
                  CustomText(
                    title: "{ ${item.number} }",
                    fontSize: 16,
                    textColor: const Color(0xff444444),
                  ),
                  CustomText(
                    title: item.isForced! ? "forced" : "optinal",
                    fontSize: 13,
                    textColor: const Color(0xff444444),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomText(
                  title: item.content!,
                  fontSize: 14,
                  textColor: const Color(0xff444444),
                  maxLins: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
