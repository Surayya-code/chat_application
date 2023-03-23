import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_application/components/rounded_button.dart';
import 'package:flutter_chat_application/screens/chat_screen.dart';

import '../constant.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                color: Colors.blueAccent,
                title: 'Register',
                onPressed: ()async  {
                  try {
                    // final newUser = await FirebaseAuth.instance
                    //     .createUserWithEmailAndPassword(
                    //   email: email,
                    //   password: password,
                    // );
                     final Future<UserCredential> newUser =  auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password);
                    //final userCredential =
                    // await FirebaseAuth.instance.signInWithCredential(credential);
                    //final user = userCredential.user;
                    //print(user?.uid);
                    // if (newUser!=null) {
                     
                    // }
                    Navigator.pushNamed(context, ChatScreen.id);
                    print(email);
                  } 
                    //on FirebaseAuthException catch (e) {
                    // if (e.code == 'weak-password') {
                    //   print('The password provided is too weak.');
                    // } else if (e.code == 'email-already-in-use') {
                    //   print('The account already exists for that email.');
                    // }
                    //} 
                  catch (e) {
                    print(e);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
