import 'package:chat_firebase/resources/auth_firestores.dart';
import 'package:chat_firebase/screen/profile_screen.dart';
import 'package:chat_firebase/widget/chat/messages.dart';
import 'package:chat_firebase/widget/chat/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var data = {};
  String _chatUid = '';
  String _userUid = '';

  String _username = '';

  catchUidUserAndChat(String userUid, String chatUid) async {
    if (chatUid == '' && userUid == '') {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // print("chatuid= ${chatUid == ''}");
    // print('useruid= $userUid');

    if (userUid != chatUid) {
      _chatUid = chatUid;
      _userUid = userUid;

      var getChatUid = await FirebaseFirestore.instance.collection('users').doc(chatUid).get();

      _username = getChatUid.data()!['username'];

      // if (mounted) {
      //   setState(() {
      //     _username = getChatUid.data()!['username'];
      //   });
      // }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    print('build ${count = count + 1}');
    print('chatuid= ${_chatUid.isEmpty}');
    print('useruid= $_userUid');
    print('username= $_username');

    // if (_chatUid.isEmpty && _userUid.isEmpty && _username.isEmpty) {
    //   Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    print('is=${_username.isNotEmpty}');

    if (_username.isNotEmpty) {}

    return Scaffold(
      appBar: AppBar(
        title: Text(_username),
        actions: [
          DropdownButton(
              underline: Container(),
              icon: const Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(
                  value: 'sign-out',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        Text('Sign out'),
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (value) {
                if (value == 'signOut') {}
                switch (value) {
                  case 'sign-out':
                    FirebaseAuth.instance.signOut();
                    break;
                  case 'username':
                    {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return ProfileScreen(
                              name: data['username'],
                            );
                          },
                        ),
                      );
                    }
                    break;
                }
              })
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Messages(
            catchUidUserAndChat: catchUidUserAndChat,
          )),
          NewMessages(),
        ],
      ),
    );
  }
}
