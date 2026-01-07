import 'package:bmi_calculator/components/appWidgets/dialog/FailureMessageDialog.dart';
import 'package:bmi_calculator/components/constant/AppColors.dart';
import 'package:bmi_calculator/components/constant/AppFonts.dart';
import 'package:bmi_calculator/components/constant/AppIcons.dart';
import 'package:bmi_calculator/components/coreComponents/ImageView.dart';
import 'package:bmi_calculator/components/coreComponents/TextView.dart';
import 'package:bmi_calculator/model/MeasurementModel.dart';
import 'package:bmi_calculator/presentation/auth/LoginCtrl.dart';
import 'package:bmi_calculator/presentation/home/MeasurementCtrl.dart';
import 'package:bmi_calculator/presentation/home/ProfileView.dart';
import 'package:bmi_calculator/utils/AppExtenstions.dart';
import 'package:bmi_calculator/utils/DateTimeUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/appWidgets/AppBar2.dart';
import '../../components/constant/TextStyles.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> with ViewStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBar2(
              title: 'BMI History',
              titleStyle: TextStyles.semiBold16Black,
              onLeadTap: context.pop,
            ),
            Expanded(child: GetX<MeasurementCtrl>(
              initState: (state) {
                state.controller!.getHistoryList();
              },
              builder: (controller) {
                return SizedBox(
                  child: controller.historyList.isEmpty ?
                      const Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView(text: 'No record found!', textStyle: TextStyles.bold22Black,)
                        ],
                      ) :
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical:AppFonts.s20, horizontal: AppFonts.s16),
                    shrinkWrap: true,
                      itemBuilder: (context, index) => _Card(
                        data: controller.historyList[index],
                        name: profCtrl.name.trim().isNotEmpty ? profCtrl.name : profCtrl.email,
                        onRemove: (){
                          load();
                          controller.removeHistoryItem(index).then((value) {
                            stopLoad();
                          }).catchError((error){
                            stopLoad();
                            onError(error.toString());
                          });
                        },
                      ),
                      separatorBuilder: (context, index) => const SizedBox(height: AppFonts.s20,),
                      itemCount: controller.historyList.length),
                );
              }
            ))
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
      dismiss: stopLoad,
      onTap: stopLoad,
    ));
  }

  @override
  void stopLoad() {
    context.stopLoader;
  }
}



class _Card extends StatelessWidget {
  final MeasurementModel data;
  final String name;
  final Function() onRemove;
  const _Card({super.key, required this.onRemove, required this.data, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical:AppFonts.s16, horizontal: AppFonts.s12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppFonts.s10)
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    TextView(
                      text: '${data.bmiValue}',
                      textStyle: TextStyles.bold22Black,),
                    Expanded(child: TextView(text: data.timeStamp!.ddMMyyyy,textStyle: TextStyles.regular14TextGrey, textAlign: TextAlign.end,)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: AppFonts.s12,
                      height: AppFonts.s12,
                      decoration: BoxDecoration(
                        color: data.bmiStatusColor,
                        borderRadius: BorderRadius.circular(AppFonts.s12 /2)
                      ),
                    ),
                    TextView(text: '${data.bmiRemarks}',textStyle: TextStyles.regular14Black,),
                    Expanded(child: TextView(text: data.timeStamp!.HHss,textStyle: TextStyles.regular14TextGrey, textAlign: TextAlign.end,)),
                  ],
                ),
              ],
            ),
          ),
          ImageView(
            onTap: onRemove,
            url: AppIcons.remove,
            size: AppFonts.s20,
            margin: const EdgeInsets.only(left: AppFonts.s12),
          ),
        ],
      )
      ,
    );
  }
}