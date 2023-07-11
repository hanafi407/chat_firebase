import 'package:flutter/material.dart';

class MessageBubles extends StatelessWidget {
  const MessageBubles(
      {required this.text, required this.isMe, required this.username, required this.key});

  final String text;
  final bool isMe;
  final String username;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
            color: isMe ? Colors.grey[300] : Theme.of(context).primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe ? Colors.black : Colors.white,
                ),
              ),
              Text(
                text,
                style: TextStyle(color: isMe ? Colors.black : Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
