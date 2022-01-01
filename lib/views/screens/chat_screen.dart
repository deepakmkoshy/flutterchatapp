import 'package:chatapp/constants/initial_message_list.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/provider/message_provider.dart';
import 'package:chatapp/services/get_permission.dart';
import 'package:chatapp/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        centerTitle: true,
        title: Text(
          'Chat',
          style: Theme.of(context).textTheme.headline5,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<MessageProvider>(
                builder: (context, value, child) => MessageStream(
                  messageModels: value.messageModels,
                ),
              ),
            ),
            InputWidget()
          ],
        ),
      ),
    );
  }
}
