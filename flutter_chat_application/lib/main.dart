import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';

void main() => runApp(const FlashChat());

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(color: Colors.black54),
      //   ),
      // ),
      home: WelcomeScreen(),
    );
  }
}