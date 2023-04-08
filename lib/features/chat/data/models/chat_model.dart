class ChatModel {
  ChatModel({this.provider, this.user, this.id, this.messages});
  ChatModel.fromJson(Map<String, dynamic> json) {
    provider = json['provider'] as String;
    user = json['user'] as String;
    id = json['id'] as String;
    if (json['messages'] != null) {
      messages = <Messages>[];
      for (final v in json['messages'] as List<dynamic>) {
        messages!.add(Messages.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? provider;
  String? user;
  String? id;
  List<Messages>? messages;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['provider'] = provider;
    data['user'] = user;
    data['id'] = id;

    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  Messages({
    this.senderType,
    this.senderId,
    this.chat,
    this.text,
    this.id,
    required this.time,
  });
  factory Messages.fromJson(
    Map<String, dynamic> json,
  ) {
    return Messages(
      senderType: json['senderType'] as String,
      senderId: json['senderId'] as String,
      chat: json['chat'] == null
          ? json['chatId'] as String?
          : json['chat'] as String,
      text: json['text'] as String,
      id: json['id'] as String,
      time: DateTime.parse(json['time'] as String),
    );
    //createdAt
  }
  String? senderType;
  String? senderId;
  String? chat;
  String? text;
  String? id;
  final DateTime time;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['senderType'] = senderType;
    data['senderId'] = senderId;
    data['chat'] = chat;
    data['text'] = text;
    data['time'] = time;

    data['id'] = id;
    return data;
  }
}
