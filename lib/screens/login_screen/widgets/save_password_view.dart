import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SavePasswordLoginView extends StatefulWidget {
  final bool initialValue;
  final Function(bool) selectedStatus;
  const SavePasswordLoginView({super.key, required this.selectedStatus, required this.initialValue});

  @override
  State<SavePasswordLoginView> createState() => _SavePasswordLoginViewState();
}

class _SavePasswordLoginViewState extends State<SavePasswordLoginView> {
  ValueNotifier<bool> boxSelectedNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    boxSelectedNotifier.value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ValueListenableBuilder<bool>(
              valueListenable: boxSelectedNotifier,
              builder: (context, snapshot, child) {
                return Checkbox(
                    tristate: false,
                    checkColor: Colors.white,
                    activeColor: const Color(0xff034061),
                    value: snapshot,
                    onChanged: (val) {
                      boxSelectedNotifier.value = val!;
                      widget.selectedStatus(val);
                    });
              }),
          CustomText(
            title: AppLocalizations.of(context)!.saveemailandpasswordfornextlogin,
            fontSize: 12,
            textColor: const Color(0xff444444),
          )
        ],
      ),
    );
  }
}
