
import 'package:bmi_calculator/presentation/auth/LoginView.dart';
import 'package:bmi_calculator/services/localData/AppData.dart';
import 'package:bmi_calculator/utils/AppExtenstions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/repository/authRepo/AuthRepoImplementation.dart';

class LoginCtrl extends GetxController {
  final _authRepo = AuthRepoImplementation();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  final RxString _emailEr = RxString('');
  final RxString _passwordEr = RxString('');

  String get emailEr => _emailEr.value;
  String get passwordEr => _passwordEr.value;

  Future<bool>onLogin() async{
    bool status = false;
    _clearEr();
    final email = emailCtrl.text.trim();
    final password = passCtrl.text.trim();

    if(email.isEmail && password.isPassword){
      try{
         await _authRepo.login(
            email: email,
            password: password
        ).then((value) {
          status = true;
          clearData();
        });
      }catch(e){
        rethrow;
      }

    }else{
      if(!email.isEmail){
        _emailEr.value = 'Please enter valid email address';
      }

      if(!password.isPassword){
        _passwordEr.value = 'Please enter valid password';
      }
    }
    return status;
  }


  void _clearEr(){
    _emailEr.clear;
    _passwordEr.clear;
  }


  void clearData(){
    _clearEr();
    emailCtrl.clear();
    passCtrl.clear();
  }

}



mixin ViewStateMixin{
  void load();
  void stopLoad();
  void onError(String error);
}


