import 'package:chatapp/constants/palette.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/provider/audio_provider.dart';
import 'package:chatapp/provider/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../services/random_string.dart';

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
    return Container(
      decoration: BoxDecoration(
          color: Palette.backgroundColor,
          borderRadius: BorderRadius.circular(32.0)),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions),
            onPressed: () {
              print('Implement emoji picker here');
            },
          ),
          Consumer<MessageProvider>(
            builder: (context, value, child) => IconButton(
              icon: const Icon(Icons.add_photo_alternate),
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

                if (image == null) {
                  return;
                }

                final appDir = await getApplicationDocumentsDirectory();
                final fileName = p.basename(image.path);
                
                    await image.saveTo('${appDir.path}/$fileName');

                MessageModel newMessage = MessageModel(
                    senderId: context.read<MessageProvider>().currentUser,
                    sentTime: DateTime.now(),
                    content: Content.media,
                    contentUri: '${appDir.path}/$fileName',
                    decibelList: []);

                value.addMessage(newMessage);
                // setState(() {});
              },
            ),
          ),
          Expanded(
            child: TextField(
              cursorColor: Palette.secondaryColor,
              controller: _chatEditingController,
              decoration: InputDecoration(
                  hintText: 'Type your Comment',
                  focusColor: Palette.secondaryColor,
                  border: InputBorder.none),
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
                splashColor: Palette.secondaryColor,
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
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.mic,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
