import 'package:mentor_app/models/https/chat.dart';
import 'package:mentor_app/models/https/chat_request.dart';
import 'package:mentor_app/models/https/messages.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';
import 'package:mentor_app/utils/repository/method_name_constractor.dart';

class MessagesService with Service {
  Future<MessagesList> listOfMessages() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.messages,
    );
    return MessagesList.fromJson(response);
  }

  Future<ChatList> listOfChats(int messageId) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.chat,
      queryParam: {"message_id": messageId},
    );
    return ChatList.fromJson(response);
  }

  Future<dynamic> sendMessage({required ChatRequest data}) async {
    return await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.messages,
      postBody: data,
    );
  }
}
