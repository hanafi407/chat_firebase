import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
