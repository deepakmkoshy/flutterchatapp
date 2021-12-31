import 'package:chatapp/models/message_model.dart';
import 'package:flutter/material.dart';

import 'chat_widgets/chat_widgets.dart';

class ChooseContent extends StatelessWidget {
  final ParseModel parseModel;
  const ChooseContent({required this.parseModel});

  @override
  Widget build(BuildContext context) {
    if (parseModel.messageModel.content == Content.text) {
      return ChatTextWidget(parseModel: parseModel);
    } else if (parseModel.messageModel.content == Content.media) {
      return ChatMediaWidget(parseModel: parseModel);
    } else {

      return ChatVoiceWidget(parseModel: parseModel);
    }
  }
}
