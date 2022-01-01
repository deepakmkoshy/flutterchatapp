import 'package:chatapp/constants/palette.dart';
import 'package:chatapp/views/views.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'provider/audio_provider.dart';
import 'provider/message_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MessageProvider()),
        ChangeNotifierProvider(create: (context) => AudioProvider())
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Palette.primaryColor,
        iconTheme: IconThemeData(color: Palette.primaryColor),
        appBarTheme: AppBarTheme(backgroundColor: Palette.backgroundColor),
        fontFamily: GoogleFonts.jost().fontFamily,
        textTheme: GoogleFonts.jostTextTheme(),
        
      ),
      home: const ChatScreen(),
    );
  }
}
