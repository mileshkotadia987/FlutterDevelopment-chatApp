import 'package:chatapp/views/sign_in.dart';
import 'package:chatapp/views/sign_up.dart';
import 'package:flutter/material.dart';

class AuthChoice extends StatefulWidget {
  @override
  _AuthChoiceState createState() => _AuthChoiceState();
}

class _AuthChoiceState extends State<AuthChoice> {
  bool isSignedIn=true;
  void toggle(){
    setState(() {
      isSignedIn = !isSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignedIn ? SignIn(toggle)
    : SignUp(toggle);
  }
}
