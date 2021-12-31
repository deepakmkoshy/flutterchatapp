import 'package:chatapp/constants/initial_message_list.dart';
import 'package:flutter/cupertino.dart';

import '../models/message_model.dart';

class MessageProvider extends ChangeNotifier {
  List<MessageModel> messageModels = messageList;
  String currentUser = 'user1';

  void addMessage(MessageModel messageModel) {
    messageModels.add(messageModel);
    notifyListeners();
  }
}
