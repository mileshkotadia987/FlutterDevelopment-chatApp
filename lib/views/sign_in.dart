import 'package:chatapp/helper/HelperFunction.dart';
import 'package:chatapp/services/authentication.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/home_screen.dart';
import 'package:chatapp/widget/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthMethods authMethods = AuthMethods();
  bool isLoading = false;
  DatabaseMethods databaseMethods = DatabaseMethods();
  QuerySnapshot userSnapShot;
  signMeIn() {
    if (_formKey.currentState.validate()) {
      HelperFunction.saveUserEmail(email.text);
      databaseMethods.getUserByUserEmail(email.text).then((val) {
        userSnapShot = val;
        HelperFunction.saveUserName(userSnapShot.documents[0].data["name"]);
      });
      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailPassword(email.text, password.text)
          .then((val) {
        if (val != null) {
          setState(() {
            isLoading = false;
          });
          HelperFunction.saveUserLoggedIn(true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: appBarMain(context),
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: 600,
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (val) {
                              return val.isEmpty ? "enter email" : null;
                            },
                            controller: email,
                            decoration: InputDecoration(hintText: "email"),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            validator: (val) {
                              return val.isEmpty ? "enter password" : null;
                            },
                            controller: password,
                            decoration: InputDecoration(hintText: "password"),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Forget password ?",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          signMeIn();
                        },
                        child: button(context, "Sign In")),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
//              padding: EdgeInsets.symmetric(vertical: 30),
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        borderSide:
                            BorderSide(width: 3.0, color: Colors.teal[800]),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "Sign in with Google",
                            style: TextStyle(
                                color: Colors.teal[800], fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have account?",
                          style: TextStyle(fontSize: 15.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 15.0,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
