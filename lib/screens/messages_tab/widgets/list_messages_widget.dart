import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/notifications_response.dart';
import 'package:mentor_app/screens/notifications/widgets/shimmer_notifications.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessagesList extends StatefulWidget {
  final ValueNotifier<List<NotificationsResponseData>?> messagesListNotifier;

  final Function(NotificationsResponseData) onDelete;

  const MessagesList({super.key, required this.messagesListNotifier, required this.onDelete});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<NotificationsResponseData>?>(
        valueListenable: widget.messagesListNotifier,
        builder: (context, data, child) {
          return data == null
              ? const ShimmerNotificationsView()
              : widget.messagesListNotifier.value!.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx, index) {
                        return messageTile(context, data[index], index);
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

  Widget messageTile(BuildContext context, NotificationsResponseData item, int index) {
    var parsedDate = DateTime.parse(item.createdAt!);
    var dateLocal = parsedDate.toLocal();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Dismissible(
        key: Key(item.title!),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          widget.onDelete(item);
        },
        background: Container(
          alignment: AlignmentDirectional.centerEnd,
          color: Colors.red,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
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
                    const Icon(
                      Icons.notifications,
                      color: Color(0xff444444),
                    ),
                    CustomText(
                      title: "${dateLocal.year}/${dateLocal.month}/${dateLocal.day}",
                      fontSize: 9,
                      textColor: const Color(0xff444444),
                    ),
                    CustomText(
                      title: "${dateLocal.hour}:${dateLocal.minute}",
                      fontSize: 9,
                      textColor: const Color(0xff444444),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: item.title!,
                      fontSize: 16,
                      textColor: const Color(0xff444444),
                      maxLins: 2,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: CustomText(
                        title: item.content!,
                        fontSize: 14,
                        textColor: const Color(0xff444444),
                        maxLins: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
