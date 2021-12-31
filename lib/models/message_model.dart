enum Content { media, text, voice }

class MessageModel {
  String senderId;
  DateTime sentTime;
  Content content;
  String contentUri;
  //Here contentUri would be the 
  //message in text,
  //Audio path in voice,
  //Image/Video path in media

  MessageModel(
      {required this.senderId,
      required this.sentTime,
      required this.content,
      required this.contentUri});
}

class ParseModel {
  final MessageModel messageModel;
  final String currentUserId;
  const ParseModel({required this.messageModel, required this.currentUserId});
}
