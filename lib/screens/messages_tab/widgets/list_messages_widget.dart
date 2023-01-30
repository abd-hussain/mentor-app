import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/messages.dart';
import 'package:mentor_app/screens/notifications/widgets/shimmer_notifications.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/utils/constants/constant.dart';

class MessagesList extends StatefulWidget {
  final ValueNotifier<List<MessagesListData>?> messagesListNotifier;

  final Function(MessagesListData) onOpen;

  const MessagesList({super.key, required this.messagesListNotifier, required this.onOpen});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<MessagesListData>?>(
        valueListenable: widget.messagesListNotifier,
        builder: (context, data, child) {
          return data == null
              ? const ShimmerNotificationsView()
              : widget.messagesListNotifier.value!.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx, index) {
                        return messageTile(
                          item: data[index],
                          onOpen: (item) {
                            widget.onOpen(item);
                          },
                        );
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

  Widget messageTile({required MessagesListData item, required Function(MessagesListData) onOpen}) {
    return InkWell(
      onTap: () => onOpen(item),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const SizedBox(width: 4),
                CircleAvatar(
                  backgroundColor: const Color(0xff034061),
                  radius: 25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: item.profileImg != ""
                        ? FadeInImage(
                            placeholder: const AssetImage("assets/images/avatar.jpeg"),
                            image: NetworkImage(AppConstant.imagesBaseURLForProfileImages + item.profileImg!, scale: 1),
                          )
                        : Image.asset(
                            'assets/images/avatar.jpeg',
                            width: 110.0,
                            height: 110.0,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                const SizedBox(width: 4),
                CustomText(
                  title: "${item.firstName!} ${item.lastName!}",
                  fontSize: 14,
                  textColor: const Color(0xff444444),
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
