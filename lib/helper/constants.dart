import 'package:chatapp/helper/HelperFunction.dart';

class Constants{
  static String myName;
static getName()async{
    myName=await HelperFunction.getUserName();
}
}
