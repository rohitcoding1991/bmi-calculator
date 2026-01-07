import 'package:bmi_calculator/components/coreComponents/AppDialog.dart';
import 'package:bmi_calculator/components/coreComponents/AppLoader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// extension for Build context
extension ContextExten on BuildContext{

  // navigate to next screen
  void  pushNavigator(Widget screen) => Navigator.push(this, MaterialPageRoute(builder: (context) => screen,));

  // push and replace ......
  void  replaceNavigator(Widget screen) => Navigator.pushReplacement(this, MaterialPageRoute(builder: (context) => screen,));

  // clear stack and navigate to screen....
  void  pushAndClearNavigator(Widget screen) =>
      Navigator.pushAndRemoveUntil(this, MaterialPageRoute(builder: (context) => screen,), (route) => false);

  //pop back...
  void  pop() => Navigator.pop(this);

  // show progress loader....
  void get load => appLoader(this);

  // close progressLoader or dialog .....
  void get  stopLoader => Navigator.of(this,rootNavigator: false).pop('dialog');

  // show popup dialog ....
  void openDialog(Widget child) => appDialog(this, child);

  // check whether is portrait mode state ...
  bool get isPortraitMode => MediaQuery.of(this).orientation == Orientation.portrait;

}



// extension for String
extension StringExten on String{

  // password condition check....
  bool get isPassword{
    return length > 6 && length< 25;
  }

  // clear string data...
  String get clear => '';

  // capital first letter of string ....
  String get capitalFirst {
    if (isEmpty) {
      return '';
    }
    return substring(0,1).toUpperCase() + substring(1).toLowerCase();
  }
}


// extension for RxString
extension RxStringExten on RxString{

  // clear string data ....
  void get clear => value = '';
}


