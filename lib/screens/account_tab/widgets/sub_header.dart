import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/utils/routes.dart';

class ProfileSubHeader extends StatelessWidget {
  const ProfileSubHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, 0.1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            optionButton(
              buttonTitle: AppLocalizations.of(context)!.payments,
              icon: Icons.payments_outlined,
              onTap: () {
                //TODO
              },
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: const Color(0xff4CB6EA), borderRadius: BorderRadius.circular(5)),
                  height: 10,
                  width: 10,
                ),
                Container(
                  color: const Color(0xff4CB6EA),
                  height: 3,
                  width: 50,
                ),
                Container(
                  decoration: BoxDecoration(color: const Color(0xff4CB6EA), borderRadius: BorderRadius.circular(5)),
                  height: 10,
                  width: 10,
                ),
              ],
            ),
            optionButton(
              buttonTitle: AppLocalizations.of(context)!.workinghour,
              icon: Icons.work_history_outlined,
              onTap: () => {
                //TODO
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget optionButton({required String buttonTitle, required IconData icon, required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              color: Color(0xff4CB6EA),
              borderRadius: BorderRadius.all(Radius.circular(27)),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CustomText(
            title: buttonTitle,
            fontSize: 10,
            textColor: const Color(0xff034061),
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
