import 'package:chatapp/helper/HelperFunction.dart';
import 'package:chatapp/services/authentication.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/home_screen.dart';
import 'package:chatapp/widget/widgets.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey=GlobalKey<FormState>();
  TextEditingController username=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  AuthMethods authMethods=AuthMethods();
  DatabaseMethods databaseMethods=DatabaseMethods();
  bool isLoading=false;


  signMeUp(){
    if(_formKey.currentState.validate()){
      Map<String,String> userMap={
        "name":username.text,
        "email":email.text
      };
      HelperFunction.saveUserName(username.text);
      HelperFunction.saveUserEmail(email.text);


      setState(() {
        isLoading=true;
      });
      authMethods.signUpWithEmailPassword(email.text, password.text).then((val){
        if(val!=null){
          setState(() {
            isLoading=false;
          });


          databaseMethods.uploadUserInfo(userMap);
          HelperFunction.saveUserLoggedIn(true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context){
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
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              Spacer(),
              isLoading ? Container(
                child: Center(child: CircularProgressIndicator()),
              ) : Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val){return val.isEmpty ? "enter username" : null;},
                      controller: username,
                      decoration: InputDecoration(hintText: "username"),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (val){return val.isEmpty ? "enter email" : null;},
                      controller: email,
                      decoration: InputDecoration(hintText: "email"),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (val){return val.isEmpty ? "enter password" : null;},
                      controller: password,
                      decoration: InputDecoration(hintText: "password"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
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
                onTap: (){
                  signMeUp();
                },
                child: button(context, "Sign Up"),),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
//              padding: EdgeInsets.symmetric(vertical: 30),
                child: OutlineButton(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  borderSide: BorderSide(
                      width: 3.0,
                      color: Colors.teal[800]),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "Sign in with Google",
                      style: TextStyle(color: Colors.teal[800], fontSize: 20.0),
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
                  Text("Already have account?",style: TextStyle(fontSize: 15.0)),
                  GestureDetector(
                    onTap: (){
                      widget.toggle();
                    },
                      child: Text("Sign In",
                          style: TextStyle(fontSize: 15.0,
                              decoration: TextDecoration.underline),),),
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
