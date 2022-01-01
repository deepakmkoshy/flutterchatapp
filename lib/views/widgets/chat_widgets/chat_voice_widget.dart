import 'package:audio_wave/audio_wave.dart';
import 'package:chatapp/provider/audio_provider.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/services/generate_waves.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatVoiceWidget extends StatefulWidget {
  final ParseModel parseModel;
  const ChatVoiceWidget({Key? key, required this.parseModel}) : super(key: key);

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
              elevation: 1,

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
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        var stat =
                            Provider.of<AudioProvider>(context, listen: false);

                        if (stat.isPlaying) {
                          await stat.stopPlayer();
                          setState(() {});
                        } else {
                          await stat
                              .play(widget.parseModel.messageModel.contentUri);
                          setState(() {});
                        }
                      },
                      icon: (value.isPlaying &&
                              value.tUrl ==
                                  widget.parseModel.messageModel.contentUri)
                          ? Icon(Icons.stop)
                          : Icon(Icons.play_arrow),
                    ),
                    // (value.isPlaying &&
                    //         value.tUrl ==
                    //             widget.parseModel.messageModel.contentUri)
                    //     ? AudioWave(
                    //         beatRate: const Duration(milliseconds: 300),
                    //         width: 100,
                    //         height: 70,
                    //         animationLoop: 0,
                    //         bars: waves(),
                    //       ):
                    AudioWave(
                      animation: false,
                      beatRate: const Duration(milliseconds: 300),
                      width: 100,
                      height: 80,
                      animationLoop: 0,
                      bars: waves(widget.parseModel.messageModel.decibelList!),
                    ),
                  ],
                ),
              ),
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
