import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  static String userLoggedInKey="ISLOGGEDIN";
  static String userNameKey="USERNAMEKEY";
  static String userEmailKey="USEREMAILKEY";

  static Future<bool> saveUserLoggedIn(bool isUserLoggedIn)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserName(String username)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.setString(userNameKey, username);
  }

  static Future<bool> saveUserEmail(String email)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.setString(userEmailKey, email);
  }

  static Future<bool> getUserLoggedIn()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getBool(userLoggedInKey);
  }

  static Future<String> getUserName()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getString(userNameKey);
  }

  static Future<String> getUserEmail()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getString(userEmailKey);
  }
}