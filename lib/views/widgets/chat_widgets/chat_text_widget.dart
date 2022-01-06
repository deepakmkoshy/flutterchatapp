import 'package:chatapp/constants/palette.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatTextWidget extends StatelessWidget {
  final ParseModel parseModel;
  const ChatTextWidget({Key? key, required this.parseModel}) : super(key: key);

  bool isMe() {
    return parseModel.messageModel.senderId == parseModel.currentUserId;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.only(
        topRight: isMe() ? Radius.zero : const Radius.circular(30),
        topLeft: isMe() ? const Radius.circular(30) : Radius.zero,
        bottomLeft: const Radius.circular(30),
        bottomRight: const Radius.circular(30),
      ),
      // color: isMe() ? Colors.grey : Colors.white,
      color: Palette.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Text(
          parseModel.messageModel.contentUri,
          style: const TextStyle(color: Colors.black87, fontSize: 15),
        ),
      ),
    );
    // const SizedBox(
    //   height: 3,
    // ),
  }
}
