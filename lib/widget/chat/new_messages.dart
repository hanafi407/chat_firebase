import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  String _enteredMessage = '';
  TextEditingController _controller = TextEditingController();

  _sendMessage() async {
    FocusScope.of(context).unfocus();

    _controller.clear();

    var uid = FirebaseAuth.instance.currentUser!.uid;
    var userChat = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    Map<String, dynamic> userData = userChat.data()!;

    print(userData);

    await FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        'id': uid,
        'username': userData['username'],
        'photoUrl': userData['photoUserUrl']
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Send a message...',
              ),
              onChanged: (value) {
                _enteredMessage = value;
                setState(() {});
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
