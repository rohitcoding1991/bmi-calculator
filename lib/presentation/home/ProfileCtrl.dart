import 'package:bmi_calculator/services/repository/authRepo/AuthRepoImplementation.dart';
import 'package:bmi_calculator/utils/AppExtenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileCtrl extends GetxController{
  final _authRepo = AuthRepoImplementation();

  final RxString _name = RxString('');
  String get name => _name.value;
  final RxString _email = RxString('');
  String get email => _email.value;

  final emailCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  final RxString _nameEr = RxString('');
  String get nameEr => _nameEr.value;

  Future getProfile() async {
    try{
     await _authRepo.getProfile().then((value){
       _name.value = value['name'] ?? '';
       _email.value = value['email'] ?? '';
       emailCtrl.text = email;
       nameCtrl.text = name;
       return;
      });
    }catch(e){
      rethrow;
    }
  }


  Future<bool> updateProfile() async{
    _clearEr();
    final nameValue = nameCtrl.text.trim();
    if(nameValue.isNotEmpty){
      try{
        final result =  await _authRepo.updateProfile(name: nameValue);
        if(result){
          _name.value = nameValue;
          return true;
        }else{
          throw 'Failed to update';
        }
      }catch(e){
        rethrow;
      }
    }else{
      if(nameValue.isEmpty){
        _nameEr.value = 'Please enter your name';
      }
      return false;
    }

  }

  void onLogout(){
    _authRepo.logout();
    clearData();
  }

  void _clearEr(){
    _nameEr.clear;
  }

  void clearData(){
    _clearEr();
    _name.clear;
    _email.clear;
    emailCtrl.clear();
    nameCtrl.clear();
  }
}