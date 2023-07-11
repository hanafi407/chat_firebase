import 'package:chat_firebase/utils/utils.dart';
import 'package:chat_firebase/widget/auth/auth_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;

  _submitAuthForm(
    String username,
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
    Uint8List file,
  ) async {
    var auth = FirebaseAuth.instance;
    UserCredential result;

    try {
     if (mounted) {
        setState(() {
          isLoading = true;
        });
      }

      if (isLogin) {
        print('sign in');

        result = await auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        print('sign up/register');

        result = await auth.createUserWithEmailAndPassword(email: email, password: password);

        String photoUserUrl = await Utils.uploadStorage(file, 'photoUser');

        FirebaseFirestore.instance.collection('users').doc(result.user!.uid).set(
          {
            'email': email,
            'password': password,
            'username': username,
            'photoUserUrl': photoUserUrl
          },
        );

        print('success');
      }

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } on PlatformException catch (err) {
      String message = 'An error occur';

      if (err.message != null) {
        message = err.message ?? '';
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),
      );
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (err) {
      print(err);

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            err.toString(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),
      );

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthCard(_submitAuthForm, isLoading),
    );
  }
}
