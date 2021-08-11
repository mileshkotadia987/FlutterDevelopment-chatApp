import 'package:chatapp/helper/HelperFunction.dart';
import 'package:chatapp/helper/auth_choice.dart';
import 'package:chatapp/views/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState()async{
    await HelperFunction.getUserLoggedIn().then((val){
      setState(() {
        userIsLoggedIn=val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat App',
      theme: ThemeData(
        primarySwatch: Colors.teal[800],
      ),
      home: (userIsLoggedIn ?? false) ? HomeScreen() : AuthChoice(),
    );
  }
}

