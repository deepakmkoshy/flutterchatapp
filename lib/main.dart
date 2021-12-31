import 'package:chatapp/views/views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/audio_service.dart';
import 'provider/message_provider.dart';

void main() {
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create:  (context) => MessageProvider()),
      ChangeNotifierProvider(create:  (context) => AudioProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const ChatScreen(),
    );
  }
}
