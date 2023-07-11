import 'dart:typed_data';

import 'package:chat_firebase/widget/auth/pick_image.dart';
import 'package:flutter/material.dart';

class AuthCard extends StatefulWidget {
  AuthCard(this.myfunc, this.isLoading);
  bool isLoading;

  final void Function(String username, String email, String password, bool isLogin,
      BuildContext context, Uint8List file) myfunc;

  // final void Function(Uint8List file) myFile;

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  String _email = '';
  String _username = '';
  String _password = '';
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  Uint8List _file = Uint8List(0);

  void _trySubmit() {
    final bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.myfunc(_username.trim(), _email.trim(), _password.trim(), isLogin, context, _file);
    }
  }

  pickImage(Uint8List file) {
    _file = file;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  !isLogin
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PickImage(pickImage),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        )
                      : Container(),
                  TextFormField(
                    key: ValueKey('email'),
                    onSaved: (value) {
                      _email = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please valid input';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  if (!isLogin)
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          key: ValueKey('username'),
                          onSaved: (value) {
                            _username = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty || value.length < 2) {
                              return 'Your input is less than 6 character';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      ],
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    onSaved: (value) {
                      _password = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Your input is less than 6 character ';
                      }

                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(isLogin ? 'Login' : 'Register'),
                    ),
                  TextButton(
                      onPressed: () {
                        isLogin = !isLogin;
                        setState(() {});
                      },
                      child: Text(isLogin ? 'Don\'t have account?' : 'I have an account'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
