class ChatList {
  List<ChatListData>? data;
  String? message;

  ChatList({this.data, this.message});

  ChatList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChatListData>[];
      json['data'].forEach((v) {
        data!.add(ChatListData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class ChatListData {
  int? id;
  int? messageId;
  int? sendit;
  String? message;
  String? createdAt;

  ChatListData({this.id, this.messageId, this.sendit, this.message, this.createdAt});

  ChatListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageId = json['message_id'];
    sendit = json['sendit'];
    message = json['message'];
    createdAt = json['created_at'];
  }
}
