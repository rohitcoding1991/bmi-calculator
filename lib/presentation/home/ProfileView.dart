import 'package:bmi_calculator/components/appWidgets/dialog/FailureMessageDialog.dart';
import 'package:bmi_calculator/presentation/auth/LoginCtrl.dart';
import 'package:bmi_calculator/utils/AppExtenstions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/appWidgets/AppBar2.dart';
import '../../components/constant/AppFonts.dart';
import '../../components/constant/TextStyles.dart';
import '../../components/coreComponents/AppButton.dart';
import '../../components/coreComponents/EditText.dart';
import 'ProfileCtrl.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}
final profCtrl = Get.find<ProfileCtrl>();

class _ProfileViewState extends State<ProfileView> with ViewStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar2(
              title: 'Profile',
              titleStyle: TextStyles.semiBold16Black,
              onLeadTap: context.pop,
            ),

            Padding(
              padding: const EdgeInsets.all(AppFonts.s20),
              child: Column(
                children: [
                   EditText(
                      hint: 'Your Full Name',
                      controller: profCtrl.nameCtrl,
                    ),
                  EditText(
                    hint: 'Email Address',
                    controller: profCtrl.emailCtrl,
                    readOnly: true,
                    margin: const EdgeInsets.only(top: AppFonts.s16, bottom: AppFonts.s40),
                  ),
                  AppButton(
                    label: 'Update',
                    onTap: (){
                      load();
                      profCtrl.updateProfile().then((value){
                        stopLoad();
                        if(value){
                          context.pop();
                        }
                      }).catchError((error){
                        stopLoad();
                        onError(error);
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void load() {
    context.load;
  }

  @override
  void onError(String error) {
    context.openDialog(FailureMessageDailog(
        message: error,
      onTap: stopLoad,
      dismiss: stopLoad,
    ));
  }

  @override
  void stopLoad() {
    context.stopLoader;
  }
}
