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
  final auth = FirebaseAuth.instance;
  final CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('messages');
  final Stream<QuerySnapshot> snapshot =
      FirebaseFirestore.instance.collection('messages').snapshots();

  late String messageText;

  @override
  void initState() {
    super.initState();
  }
  // void getMessages() async {
  //   final QuerySnapshot<Map<String, dynamic>> messages= await users.get();
  //   for( QueryDocumentSnapshot<Map<String, dynamic>> message in messages.docs){
  //    print(message.data);
  //    print('data ');
  //   }
  //}

  void messagesStream() async {
    await for (var snapshot
        in FirebaseFirestore.instance.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data);
        print('data ');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                messagesStream();
                //getMessages();
                // auth.signOut();
                // Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           MessagesStream(),
           Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      users.add({
                        'text': messageText,
                        'sender': auth.currentUser?.email,
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

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('messages').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                  final messages = snapshot.data?.docs;
                  List<MessageBubble> messageBubbles = [];
                  for (var message in messages!) {
                    final messageText = message.data()['text'];
                    final messageSender = message.data()['sender'];
                    
                    final messageBubble = MessageBubble(
                    sender: messageSender,
                    text: messageText);
                        
                    messageBubbles.add(messageBubble);
                  }
                  return Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      children: messageBubbles,
                    ),
                  );
                //return SizedBox();
             },
            );
  }
}

  class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, 
   this.sender,
   this.text});
  final String? sender;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(sender.toString(),style: const TextStyle(color: Colors.black54,fontSize: 12,),),
          Material(
            borderRadius: BorderRadius.circular(20.0),
            elevation: 5.0,
            color: Colors.lightBlueAccent,
            child:  Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Text( text.toString(),
              style:const TextStyle(fontSize: 10,color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}