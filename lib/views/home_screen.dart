import 'package:chatapp/helper/HelperFunction.dart';
import 'package:chatapp/helper/auth_choice.dart';
import 'package:chatapp/services/authentication.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/conversation_screen.dart';
import 'package:chatapp/views/search.dart';
import 'package:chatapp/widget/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
String _myName;
class _HomeScreenState extends State<HomeScreen> {
  AuthMethods authMethods=AuthMethods();
DatabaseMethods databaseMethods=DatabaseMethods();
Stream chatRoomStream;


Widget chatRoomList(){
  return StreamBuilder(
    stream: chatRoomStream,
    builder: (context,snapshot){
      return snapshot.hasData ? ListView.builder(
        itemCount: snapshot.data.documents.length,
          itemBuilder: (context,index){
          return ChatRoomTile(
            snapshot.data.documents[index].data["chatroomid"].toString()
                .replaceAll("_", "").replaceAll(_myName, ""),
              snapshot.data.documents[index].data["chatroomid"]
          );
          }):Container();
    },
  );
}


  getUserInfo()async{
    _myName=await HelperFunction.getUserName();
    databaseMethods.getChatRooms(_myName).then((val){
      setState(() {
        chatRoomStream=val;
      });
    });
    setState(() {
    });
  }

  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: appBarMain(context),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context){
                    return AuthChoice();
                  }));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[800],
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return SearchScreen();
              }));
          },
      child: Icon(Icons.search),),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String username;
  final String chatRoomId;
  ChatRoomTile(this.username,this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return ConversationScreen(chatRoomId);
            }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 4,color: Colors.yellow[500]),
                  color: Colors.teal[500],
                  borderRadius: BorderRadius.circular(40)
                ),
                child: Text(username.substring(0,1).toUpperCase(),style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),),
              ),
              SizedBox(width: 22,),
              Text(username,style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 17
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
