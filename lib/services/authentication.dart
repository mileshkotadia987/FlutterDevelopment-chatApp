import 'package:chatapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
  FirebaseAuth _auth=FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user !=null ? User(userId: user.uid) : null;
  }

  Future signInWithEmailPassword(String email,String password)async{
    try{
      AuthResult authResult=await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user= authResult.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
    }
  }

  Future signUpWithEmailPassword(String email,String password)async{
    try{
      AuthResult authResult=await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user=authResult.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
    }
  }

  Future resetPassword(String email)async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}