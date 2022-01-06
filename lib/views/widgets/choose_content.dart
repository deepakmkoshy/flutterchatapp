import 'package:chatapp/constants/palette.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/services/find_photoURL.dart';
import 'package:flutter/material.dart';

import 'chat_widgets/chat_widgets.dart';

class ChooseContent extends StatelessWidget {
  final ParseModel parseModel;
  const ChooseContent({Key? key, required this.parseModel}) : super(key: key);

  bool isMe() {
    return parseModel.messageModel.senderId == parseModel.currentUserId;
  }

  @override
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
                style: TextStyle(
                    fontWeight: FontWeight.w800, color: Palette.primaryColor),
              ),
              const SizedBox(width: 10),

              // TODO: Time interpolation to be moved to separate logic
              Text(
                parseModel.messageModel.sentTime.hour.toString() +
                    ':' +
                    ((parseModel.messageModel.sentTime.minute < 10)
                        ? '0${parseModel.messageModel.sentTime.minute}'
                        : parseModel.messageModel.sentTime.minute.toString()),
                style: TextStyle(fontSize: 12, color: Palette.primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (parseModel.messageModel.content == Content.text) ...[
            ChatTextWidget(parseModel: parseModel)
          ] else if (parseModel.messageModel.content == Content.media) ...[
            ChatMediaWidget(parseModel: parseModel)
          ] else ...[
            ChatVoiceWidget(parseModel: parseModel)
          ],
        ],
      ),
    );
  }
}
