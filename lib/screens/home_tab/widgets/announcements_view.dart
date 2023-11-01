import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/notifications_response.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnnouncementsView extends StatelessWidget {
  final List<NotificationsResponseData> notificationsList;

  const AnnouncementsView({super.key, required this.notificationsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notificationsList.length,
        itemBuilder: (context, index) {
          return item(
            context: context,
            item: notificationsList[0],
          );
        });
  }

  Widget item(
      {required BuildContext context,
      required NotificationsResponseData item}) {
    var parsedDate = DateTime.parse(item.createdAt!);
    var dateLocal = parsedDate.toLocal();
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.notifications,
                    color: Color(0xff444444),
                  ),
                  const SizedBox(width: 5),
                  CustomText(
                    title: AppLocalizations.of(context)!.announcements,
                    fontSize: 16,
                    textColor: const Color(0xff444444),
                  ),
                  Expanded(child: Container()),
                  CustomText(
                    title:
                        "${dateLocal.year}/${dateLocal.month}/${dateLocal.day}",
                    fontSize: 12,
                    textColor: const Color(0xff444444),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomText(
                  title: item.title!,
                  fontSize: 18,
                  textColor: const Color(0xff444444),
                  maxLins: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomText(
                    title: item.content!,
                    fontSize: 14,
                    textColor: const Color(0xff444444),
                    maxLins: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
