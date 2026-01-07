import 'package:bmi_calculator/presentation/home/MeasurementCtrl.dart';
import 'package:bmi_calculator/presentation/home/ProfileView.dart';
import 'package:bmi_calculator/utils/AppExtenstions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

import '../../components/appWidgets/AppBar2.dart';
import '../../components/constant/AppColors.dart';
import '../../components/constant/AppFonts.dart';
import '../../components/constant/TextStyles.dart';
import '../../components/coreComponents/TextView.dart';
import '../../model/MeasurementModel.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBar2(
              title: 'BMI Calculator',
              titleStyle: TextStyles.semiBold16Black,
              onLeadTap: context.pop,
            ),
            Expanded(child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppFonts.s20),
              child: GetBuilder<MeasurementCtrl>(
                builder: (controller) {
                  return Column(
                    children: [
                      const SizedBox(height: AppFonts.s40,),
                      Obx(()=> _meterView(data: controller.result!)),
                      Obx(()=> _detailView(data: controller.result!)),
                    ],
                  );
                }
              ),
            ))
          ],
        ),
      ),
    );
  }
}
Widget _meterView({required MeasurementModel data}){
  final value = data.bmiValue ?? 0;
  const max = 34;
  const sub = 10;
  final vv = value <= sub ? sub : (value > max ? max - sub : value - sub);

  return SpeedometerChart(
    dimension: 175,
    minValue: 0,
    maxValue: double.parse((max - sub).toString()),
    value: double.parse(vv.toString()),
    graphColor: const [Colors.blueAccent,Colors.greenAccent,Colors.greenAccent,  Colors.redAccent],
    pointerColor: Colors.black,
    animationDuration: 10,
    valueFixed: 2,
    rangeVisible: false,
    valueVisible: false,
  );
}

Widget _detailView({required MeasurementModel data}){
  return Container(
    margin: const EdgeInsets.only(top: AppFonts.s40),
    padding: const EdgeInsets.symmetric(vertical: AppFonts.s20),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppFonts.s10)
    ),
    child: Column(
      children: [
         TextView(text: profCtrl.name.trim().isNotEmpty ? profCtrl.name : profCtrl.email, textStyle: TextStyles.semiBold16Black,margin: const EdgeInsets.only(bottom: AppFonts.s16),),

         Row(
          children: [
           Expanded(child: Column(children: [
              const TextView(text: 'Your BMI is...', textStyle: TextStyles.medium14Black,),

              TextView(text: data.bmiValue!.toString(), textStyle: TextStyles.bold30Black,),
            ],)),
            Expanded(child: Column(children: [
             const TextView(text: 'Status', textStyle: TextStyles.medium14Black,),
              TextView(text: data.bmiRemarks!, textStyle: TextStyle(
                fontSize: TextStyles.semiBold16P_Green.fontSize,
                fontFamily: TextStyles.semiBold16P_Green.fontFamily,
                color: data.bmiStatusColor
              )),
            ],))
          ],
        ),
        const Divider(),
        IntrinsicHeight(
          child: Row(
            children: [
              _measureValueView(value: data.genderValue.name.capitalFirst),
              const VerticalDivider(),
              _measureValueView(value: '${data.age} yrs old'),
              const VerticalDivider(),
              _measureValueView(value: data.showWeight),
              const VerticalDivider(),
              _measureValueView(value: data.showHeight),
            ],
          ),
        )

      ],
    ),
  );
}

Widget _measureValueView({required String value}){
  return Expanded(child: TextView(text: value, textAlign: TextAlign.center, textStyle: TextStyles.regular14Black));
}
