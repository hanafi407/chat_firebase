import 'package:chat_firebase/widget/chat/message_bubles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key, required this.catchUidUserAndChat});

  final void Function(String userUid, String chatUid) catchUidUserAndChat;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, chatSnapshot) {
        var chatDocs = chatSnapshot.data?.docs;

        if (chatDocs == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) {
            String chatUid = chatDocs[index]['id'];
            String userUid = FirebaseAuth.instance.currentUser!.uid;

            catchUidUserAndChat(userUid, chatUid);

            return MessageBubles(
              username: chatDocs[index]['username'] ?? '',
              text: chatDocs[index]['text'] ,
              isMe: chatUid == userUid,
              key: ValueKey(chatDocs[index].id),
            );
          },
        );
      },
    );
  }
}
