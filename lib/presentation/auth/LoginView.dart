import 'package:bmi_calculator/components/appWidgets/dialog/FailureMessageDialog.dart';
import 'package:bmi_calculator/components/constant/AppFonts.dart';
import 'package:bmi_calculator/components/constant/TextStyles.dart';
import 'package:bmi_calculator/components/coreComponents/AppButton.dart';
import 'package:bmi_calculator/components/coreComponents/EditText.dart';
import 'package:bmi_calculator/components/coreComponents/TextView.dart';
import 'package:bmi_calculator/presentation/auth/LoginCtrl.dart';
import 'package:bmi_calculator/utils/AppExtenstions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/HomeView.dart';

class LoginView extends StatefulWidget{
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();

}

class _LoginViewState extends State<LoginView> with ViewStateMixin {
  final loginController = Get.put(LoginCtrl());

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        minimum: const EdgeInsets.all(AppFonts.s20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextView(text: 'Login', textStyle: TextStyles.semiBold30P_Green,
              margin: EdgeInsets.only(bottom: AppFonts.s40 * 1.5),
            ),

            Obx(
                  ()=> EditText(
                hint: 'Enter your email address',
                controller: loginController.emailCtrl,
                error: loginController.emailEr,
              ),
            ),

            Obx(
                  ()=> EditText(
                hint: 'Enter your password',
                controller: loginController.passCtrl,
                error: loginController.passwordEr,
                margin: const EdgeInsets.only(top: AppFonts.s16, bottom: AppFonts.s40,),
                    isPassword: true,
              ),
            ),

            AppButton(
              label: 'LOGIN',
              onTap: () {
                load();
                loginController.onLogin().then((value){
                  stopLoad();
                  if(value){
                    context.pushAndClearNavigator(const HomeView());
                  }
                }).catchError((error){
                  stopLoad();
                  onError(error);
                });
              },
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
    context.openDialog(FailureMessageDailog(message: error,
      onTap: stopLoad,
      dismiss: stopLoad,
    ));
  }

  @override
  void stopLoad() {
    context.stopLoader;
  }

}
