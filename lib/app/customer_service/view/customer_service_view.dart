import 'package:flutter/material.dart';
import 'package:wyca/imports.dart';



enum MessageType {
  Sender,
  Receiver,
}

class ChatMessage {
  final String content;
  final MessageType type;

  ChatMessage({required this.content, required this.type});
}

class CustomerService extends StatefulWidget {
  @override
  _CustomerServiceState createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  List<ChatMessage> messages = [
    ChatMessage(content: 'ahmed', type: MessageType.Sender),
    ChatMessage(content: 'kadry', type: MessageType.Receiver),
  ];

  TextEditingController messageController = TextEditingController();

  void sendMessage(String message) {
    setState(() {
      messages.add(ChatMessage(content: message, type: MessageType.Sender));
    });
    messageController.clear();
  }

  Widget buildMessageList() {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return Align(
          alignment: (message.type == MessageType.Sender)
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: (message.type == MessageType.Sender)
                  ? Colors.blue
                  : Colors.grey,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(8.0),
            child: Text(
              message.content,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildMessageList(),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      sendMessage(messageController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
