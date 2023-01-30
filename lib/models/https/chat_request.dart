import 'package:mentor_app/utils/mixins.dart';

class ChatRequest implements Model {
  int messageId;
  String message;

  ChatRequest({
    required this.messageId,
    required this.message,
  });

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['message_id'] = messageId;
    data['message'] = message;
    return data;
  }
}
