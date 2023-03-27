import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
   //User? loggedInUser;
   //CollectionReference
  final auth = FirebaseAuth.instance;
  final  users = FirebaseFirestore.instance.collection('messages');
   
  late String messageText;

  @override
  void initState() {
    super.initState();
    //users;
    //getCurrentUser();
    //addUser();
  }

  // void getCurrentUser() async {
  //   try {
  //     final User? user =  auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user;
  //       print(loggedInUser?.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  
//  Future<void> addUser() {
//       // Call the user's CollectionReference to add a new user
//       return users
//           .add({
//             'text': messageText, // John Doe
//             'sender': loggedInUser.email, // Stokes and Sons
            
//           })
//           .then((value) => print("User Added"))
//           .catchError((error) => print("Failed to add user: $error"));
//     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        messageText=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      
                      users.add({
                        'text':messageText,
                        'sender':auth.currentUser?.email,
                      });
                      print('send message to firebase');
                      print(auth.currentUser?.email);
                       },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
