import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/chat.dart';
import 'package:mentor_app/screens/notifications/widgets/shimmer_notifications.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatList extends StatefulWidget {
  final ValueNotifier<List<ChatListData>?> chatListNotifier;

  const ChatList({super.key, required this.chatListNotifier});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ChatListData>?>(
      valueListenable: widget.chatListNotifier,
      builder: (context, data, child) {
        return data == null
            ? const ShimmerNotificationsView()
            : widget.chatListNotifier.value!.isNotEmpty
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (ctx, index) {
                      return messageTile(
                        item: data[index],
                      );
                    })
                : Center(
                    child: CustomText(
                      title: AppLocalizations.of(context)!.noitem,
                      fontSize: 16,
                      textColor: const Color(0xff444444),
                    ),
                  );
      },
    );
  }

  Widget messageTile({required ChatListData item}) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: (item.sendit == 2 ? Alignment.topLeft : Alignment.topRight),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (item.sendit == 2 ? Colors.grey.shade200 : Colors.blue[200]),
            ),
            padding: const EdgeInsets.all(16),
            child: CustomText(
              title: item.message!,
              fontSize: 14,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
