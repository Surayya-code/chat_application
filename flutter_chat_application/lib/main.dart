import 'package:flutter/material.dart';
import 'package:flutter_chat_application/screens/chat_screen.dart';
import 'package:flutter_chat_application/screens/login_screen.dart';
import 'package:flutter_chat_application/screens/registr_screen.dart';

import 'screens/welcome_screen.dart';

void main() => runApp(const FlashChat());

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(color: Colors.black54),
      //   ),
      // ),
      initialRoute: WelcomeScreen.id ,
      routes: {
        WelcomeScreen.id:(context)=>  const WelcomeScreen(),
        LoginScreen.id:(context)=> const LoginScreen(),
        RegistrationScreen.id:(context)=> const RegistrationScreen(),
        ChatScreen.id:(context)=> const ChatScreen(),

      },
    );
  }
}