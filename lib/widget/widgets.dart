import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return Text("ChatApp",style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 22.0
  ),);
}


Widget button(BuildContext context,String label){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(vertical: 18.0),
    decoration: BoxDecoration(
      color: Colors.teal[800],
      borderRadius: BorderRadius.circular(30.0),
    ),
    width: MediaQuery.of(context).size.width,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 20.0),
    ),
  );
}