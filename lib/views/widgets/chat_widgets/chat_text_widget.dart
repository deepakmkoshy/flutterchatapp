import 'package:chatapp/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatTextWidget extends StatelessWidget {
  final ParseModel parseModel;
  const ChatTextWidget({required this.parseModel});

  bool isMe() {
    return parseModel.messageModel.senderId == parseModel.currentUserId;
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment:
            isMe() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Text(
          //   message.data()['name'],
          //   style: TextStyle(fontSize: 12, color: Colors.black54),
          // ),
          Material(
            elevation: 2,
            borderRadius: BorderRadius.only(
              topRight: isMe() ? Radius.zero : Radius.circular(30),
              topLeft: isMe() ? Radius.circular(30) : Radius.zero,
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            // color: isMe() ? Colors.grey : Colors.white,
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                parseModel.messageModel.contentUri,
                style: TextStyle(
                    color: isMe() ? Colors.white : Colors.black54,
                    fontSize: 15),
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
        ],
      ),
    );
  }
}
