import 'dart:io';

import 'package:chatapp/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatMediaWidget extends StatelessWidget {
  final ParseModel parseModel;
  const ChatMediaWidget({required this.parseModel});

  bool isMe() {
    return parseModel.messageModel.senderId == parseModel.currentUserId;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.only(
        topRight: isMe() ? Radius.zero : Radius.circular(30),
        topLeft: isMe() ? Radius.circular(30) : Radius.zero,
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      color: Colors.grey[200],
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Image.file(
          File(parseModel.messageModel.contentUri),

          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
