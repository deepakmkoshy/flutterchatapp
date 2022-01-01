import 'package:chatapp/constants/palette.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/services/find_photoURL.dart';
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundImage:
                    NetworkImage(getPhotoURL(parseModel.messageModel.senderId)),
              ),
              const SizedBox(width: 10),
              Text(
                getName(parseModel.messageModel.senderId),
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          SizedBox(height: 8),
          Material(
            elevation: 2,
            borderRadius: BorderRadius.only(
              topRight: isMe() ? Radius.zero : Radius.circular(30),
              topLeft: isMe() ? Radius.circular(30) : Radius.zero,
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            // color: isMe() ? Colors.grey : Colors.white,
            color: Palette.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                parseModel.messageModel.contentUri,
                style: TextStyle(color: Colors.black87, fontSize: 15),
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
