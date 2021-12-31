import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> getPermissions() async {
    var statusMic = await Permission.microphone.request();

    // Asking again for permission
    if (statusMic == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kindly allow mic access for sending voice messages'),
        ),
      );
      getPermissions();
    }
  }

  @override
  void initState() {
    getPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
