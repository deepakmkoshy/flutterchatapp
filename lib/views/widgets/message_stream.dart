import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/views/widgets/choose_content.dart';
import 'package:flutter/material.dart';

class MessageStream extends StatefulWidget {
  final List<MessageModel> messageModels;
  MessageStream({Key? key, required this.messageModels}) : super(key: key);

  @override
  State<MessageStream> createState() => _MessageStreamState();
}

class _MessageStreamState extends State<MessageStream> {
  final ScrollController _scrollController = ScrollController();

  List<ChooseContent> createChatWidgets() {
    final messages = widget.messageModels;
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

  // Method to scroll to end when a new message arrives
  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    List<ChooseContent> messageWidgets = createChatWidgets();
    WidgetsBinding.instance?.addPostFrameCallback((_) => _scrollToEnd());
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      children: messageWidgets,
    );
  }
}
