import 'package:chatapp/core/audio_service.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatVoiceWidget extends StatefulWidget {
  final ParseModel parseModel;
  const ChatVoiceWidget({required this.parseModel});

  @override
  State<ChatVoiceWidget> createState() => _ChatVoiceWidgetState();
}

class _ChatVoiceWidgetState extends State<ChatVoiceWidget> {
  bool isMe() {
    return widget.parseModel.messageModel.senderId ==
        widget.parseModel.currentUserId;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment:
            isMe() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Text(
          //   message.data()['name'],
          //   style: TextStyle(fontSize: 12, color: Colors.black54),
          // ),
          Consumer<AudioProvider>(
            builder: (context, value, child) => Material(
              elevation: 2,

              borderRadius: BorderRadius.only(
                topRight: isMe() ? Radius.zero : Radius.circular(30),
                topLeft: isMe() ? Radius.circular(30) : Radius.zero,
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              // color: isMe() ? Colors.grey : Colors.white,
              color: Colors.grey[200],
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            var stat = Provider.of<AudioProvider>(context,
                                listen: false);

                            if (stat.isPlaying) {
                              await stat.stopPlayer();
                              setState(() {});
                            } else {
                              await stat.play(
                                  widget.parseModel.messageModel.contentUri);
                              setState(() {});
                            }
                          },
                          icon: context.read<AudioProvider>().isPlaying
                              ? Icon(Icons.stop)
                              : Icon(Icons.play_arrow))
                    ],
                  )),
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
