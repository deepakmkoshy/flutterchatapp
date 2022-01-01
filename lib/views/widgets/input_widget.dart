import 'package:chatapp/provider/audio_provider.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/provider/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputWidget extends StatefulWidget {
  InputWidget({Key? key}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final TextEditingController _chatEditingController = TextEditingController();
  bool sendButtonVisible = false;
  bool recordButtonVisible = true;

  @override
  void didChangeDependencies() {
    Provider.of<AudioProvider>(context, listen: false).initRec();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _chatEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions),
            onPressed: () {
              print('Implement emoji picker here');
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: () {
              print('Implement photo picker here');
            },
          ),
          Expanded(
            child: TextField(
              controller: _chatEditingController,
              decoration: const InputDecoration(hintText: 'Type your Comment'),
              onChanged: (value) {
                setState(() {
                  if (value == '') {
                    sendButtonVisible = false;
                    recordButtonVisible = true;
                  } else {
                    sendButtonVisible = true;
                    recordButtonVisible = false;
                  }
                });
                // messageText = value;
              },
            ),
          ),
          Consumer<MessageProvider>(
            builder: (context, value, child) => Visibility(
              visible: sendButtonVisible,
              child: IconButton(
                onPressed: () {
                  MessageModel newMessage = MessageModel(
                      senderId: context.read<MessageProvider>().currentUser,
                      sentTime: DateTime.now(),
                      content: Content.text,
                      contentUri: _chatEditingController.text,
                      decibelList: []);
                  context.read<MessageProvider>().addMessage(newMessage);
                  _chatEditingController.clear();
                  recordButtonVisible = true;
                  sendButtonVisible = false;
                  setState(() {});
                  print('Message Sent');
                },
                icon: const Icon(Icons.send),
              ),
            ),
          ),
          Consumer<MessageProvider>(
            builder: (context, msg, child) => Consumer<AudioProvider>(
              builder: (context, value, child) => Visibility(
                visible: recordButtonVisible,
                child: GestureDetector(
                  onLongPress: () async {
                    sendButtonVisible = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Recording... Release to sent'),
                      ),
                    );
                    value.record();
                  },
                  onLongPressEnd: (longPressEndDetails) async {
                    await value.stopRecorder();
                    MessageModel newMessage = MessageModel(
                      senderId: context.read<MessageProvider>().currentUser,
                      sentTime: DateTime.now(),
                      content: Content.voice,
                      contentUri: value.mPath,
                      decibelList: List.from(value.decibelList),
                    );
                    
                    msg.addMessage(newMessage);
                    print('Voice Note Sent');
                  },
                  child: const Icon(Icons.mic),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
