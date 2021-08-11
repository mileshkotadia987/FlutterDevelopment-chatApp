import 'package:chatapp/helper/HelperFunction.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/conversation_screen.dart';
import 'package:chatapp/widget/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search=TextEditingController();
  DatabaseMethods databaseMethods=DatabaseMethods();
  QuerySnapshot searchSnapShot;

  initiateSearch(){
    databaseMethods.getUserByUserName(search.text).then((val){
      setState(() {
        searchSnapShot=val;
      });
    });
  }

  Widget showList(){
    return searchSnapShot != null ? ListView.builder(
        shrinkWrap: true,
        itemCount: searchSnapShot.documents.length,
        itemBuilder: (context,index){
          return userTile(
            username: searchSnapShot.documents[index].data["name"],
            email: searchSnapShot.documents[index].data["email"],
          );
        }): Container();
  }

  Widget userTile({String username,String email}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(username),
              SizedBox(
                height: 5.0,
              ),
              Text(email)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoom(username: username);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22,vertical: 16),
              decoration: BoxDecoration(
                  color: Colors.teal[800],
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Text("Message",style: TextStyle(
                  color: Colors.white
              ),),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: appBarMain(context),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.teal[300],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: search,
                    style: TextStyle(color: Colors.white,
                    fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search User",
                        hintStyle: TextStyle(color: Colors.grey[300])),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    initiateSearch();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal[600],Colors.teal[400]]
                      ),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          showList()
        ],
      ),),
    );
  }

  createChatRoom({String username})async{
    String n=await HelperFunction.getUserName();
    if(username != n){
      String chatRoomId=getChatRoomId(username,n);
      List<String> users=[username,n];
      Map<String,dynamic> chatRoomMap={
        "users":users,
        "chatroomid":chatRoomId
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context){
            return ConversationScreen(chatRoomId);
          }));
    }else{
      print("you cant sent message");
    }
  }
}




getChatRoomId(String a,String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    print("hii");
    return "$b\_$a";
  }
  else{
    print("helo");
    return "$a\_$b";
  }
}