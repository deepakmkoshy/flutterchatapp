enum Content { media, text, voice }

class MessageModel {
  final String senderId;
  final DateTime sentTime;
  final Content content;
  final String contentUri;
  final List<double>? decibelList;
  String duration;
  //Here contentUri would be the
  //message in text,
  //Audio path in voice,
  //Image/Video path in media

  MessageModel(
      {required this.senderId,
      required this.sentTime,
      required this.content,
      required this.contentUri,
      required this.decibelList,
      this.duration=''});
}

class ParseModel {
  final MessageModel messageModel;
  final String currentUserId;
  const ParseModel({required this.messageModel, required this.currentUserId});
}
