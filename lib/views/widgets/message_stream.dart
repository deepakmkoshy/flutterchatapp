import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/views/widgets/choose_content.dart';
import 'package:flutter/material.dart';

class MessageStream extends StatelessWidget {
  final List<MessageModel> messageModels;

  const MessageStream({Key? key, required this.messageModels})
      : super(key: key);

  List<ChooseContent> createChatWidgets() {
    final messages = messageModels;
    List<ChooseContent> messageWidgets = [];
    for (var message in messages) {
      ChooseContent messageWidget = ChooseContent(
        parseModel: ParseModel(currentUserId: 'user1', messageModel: message),
      );
      messageWidgets.add(messageWidget);
    }

    // Sorting according to message sent time
    messageWidgets.sort((a, b) => a.parseModel.messageModel.sentTime
        .compareTo(b.parseModel.messageModel.sentTime));
    return messageWidgets;
  }

  @override
  Widget build(BuildContext context) {
    List<ChooseContent> messageWidgets = createChatWidgets();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      children: messageWidgets,
    );
  }
}
