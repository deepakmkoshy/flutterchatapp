import 'package:chatapp/constants/initial_message_list.dart';
import 'package:chatapp/core/get_permission.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/message_stream.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<MessageModel> messageModels;

  @override
  void initState() {
    getPermissions();
    messageModels = messageList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: MessageStream(messageModels: messageModels,),
            ),
            Container(
              child: InputWidget(),
            )
          ],
        ),
      ),
    );
  }
}
