import 'package:audio_wave/audio_wave.dart';
import 'package:chatapp/constants/palette.dart';
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
          Consumer<AudioProvider>(
            builder: (context, value, child) => Material(
              elevation: 1,
              borderRadius: BorderRadius.only(
                topRight: isMe() ? Radius.zero : const Radius.circular(30),
                topLeft: isMe() ? const Radius.circular(30) : Radius.zero,
                bottomLeft: const Radius.circular(30),
                bottomRight: const Radius.circular(30),
              ),
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
                          ? const Icon(Icons.stop)
                          : const Icon(Icons.play_arrow),
                    ),
                    // (value.isPlaying &&
                    //         value.tUrl ==
                    //             widget.parseModel.messageModel.contentUri)
                    // ?
                    // AudioWave(
                    //   beatRate: const Duration(milliseconds: 300),
                    //   width: 100,
                    //   height: 70,
                    //   animationLoop: 0,
                    //   bars: waves(widget.parseModel.messageModel.decibelList!,
                    //       Palette.secondaryColor),
                    // ),

                    Stack(
                      children: [
                        AudioWave(
                          animation: false,
                          animationLoop: 0,
                          beatRate: const Duration(milliseconds: 300),
                          width: findWidth(
                              widget.parseModel.messageModel.decibelList!),
                          height: 80,
                          bars: waves(
                              widget.parseModel.messageModel.decibelList!,
                              Colors.grey),
                        ),
                        if (value.isPlaying &&
                            value.tUrl ==
                                widget.parseModel.messageModel.contentUri) ...[
                          AudioWave(
                            animation: true,
                            animationLoop: 0,
                            beatRate: const Duration(milliseconds: 300),
                            width: findWidth(
                                widget.parseModel.messageModel.decibelList!),
                            height: 80,
                            bars: waves(
                                widget.parseModel.messageModel.decibelList!,
                                Palette.secondaryColor),
                          ),
                        ],
                      ],
                    ),

                    // if (value.isPlaying &&
                    //     value.tUrl ==
                    //         widget.parseModel.messageModel.contentUri) ...[
                    //   AudioWave(
                    //     animation: true,
                    //     animationLoop: 0,
                    //     beatRate: const Duration(milliseconds: 300),
                    //     width: findWidth(
                    //         widget.parseModel.messageModel.decibelList!),
                    //     height: 80,
                    //     bars: waves(widget.parseModel.messageModel.decibelList!,
                    //         Palette.secondaryColor),
                    //   ),
                    // ] else ...[
                    //   AudioWave(
                    //     animation: false,
                    //     beatRate: const Duration(milliseconds: 300),
                    //     width: findWidth(
                    //         widget.parseModel.messageModel.decibelList!),
                    //     height: 80,
                    //     bars: waves(widget.parseModel.messageModel.decibelList!,
                    //         Colors.grey),
                    //   ),
                    // ],
                    // AudioWave(
                    //   animation: false,
                    //   beatRate: const Duration(milliseconds: 300),
                    //   width: findWidth(
                    //       widget.parseModel.messageModel.decibelList!),
                    //   height: 80,
                    //   bars: waves(widget.parseModel.messageModel.decibelList!),
                    // ),
                    const SizedBox(width: 4),
                    Text(widget.parseModel.messageModel.duration)
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
