import 'package:bmi_calculator/components/appWidgets/dialog/FailureMessageDialog.dart';
import 'package:bmi_calculator/components/coreComponents/TapWidget.dart';
import 'package:bmi_calculator/presentation/auth/LoginCtrl.dart';
import 'package:bmi_calculator/presentation/home/HistoryView.dart';
import 'package:bmi_calculator/presentation/home/ProfileView.dart';
import 'package:bmi_calculator/presentation/home/ResultView.dart';
import 'package:bmi_calculator/utils/AppExtenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/constant/AppColors.dart';
import '../../components/constant/AppFonts.dart';
import '../../components/constant/AppIcons.dart';
import '../../components/constant/TextStyles.dart';
import '../../components/constant/constants.dart';
import '../../components/coreComponents/AppButton.dart';
import '../../components/coreComponents/ImageView.dart';
import '../../components/coreComponents/TextView.dart';
import 'MeasurementCtrl.dart';

class MeasurementsView extends StatefulWidget {
  const MeasurementsView({super.key});

  @override
  State<MeasurementsView> createState() => _MeasurementsViewState();
}

final weight1 = GlobalKey();
final weight2 = GlobalKey();

class _MeasurementsViewState extends State<MeasurementsView>
    with ViewStateMixin {
  final measCtrl = Get.put(MeasurementCtrl());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const UserView(),
          Obx(
            () => _GenderButton(
              value: measCtrl.gender,
              onTap: measCtrl.onSelectGender,
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Obx(
                () => _HeightView(
                  onTap: measCtrl.onSelectHeightType,
                  measureType: measCtrl.heightType,
                  cm: measCtrl.heightCm,
                  feet: measCtrl.heightFeet,
                  inch: measCtrl.heightInch,
                  onSelectCm: measCtrl.onSelectHeightCmValue,
                  onSelectFeet: measCtrl.onSelectHeightFeetValue,
                  onSelectInch: measCtrl.onSelectHeightInchValue,
                ),
              )),
              const SizedBox(
                width: AppFonts.s10,
              ),
              Expanded(
                  child: Obx(
                () => _WeightView(
                  onTap: measCtrl.onSelectWeightType,
                  measureType: measCtrl.weightType,
                  kg: measCtrl.weightKg,
                  lbs: measCtrl.weightLbs,
                  onSelectKg: measCtrl.onSelectWeightKgValue,
                  onSelectLbs: measCtrl.onSelectWeightLbsValue,
                  key: measCtrl.weightType == WeightEnum.kg ? weight1 : weight2,
                ),
              ))
            ],
          ),
          Obx(
            () => _AgeView(
              onSelect: measCtrl.onSelectAge,
              value: measCtrl.age,
            ),
          ),
          AppButton(
            label: 'Calculate',
            radius: AppFonts.s30,
            onTap: () {
              load();
              measCtrl.onCalculate().then((value) {
                stopLoad();
                context.pushNavigator(const ResultView());
              }).catchError((error) {
                stopLoad();
                onError(error.toString());
              });
            },
          ),
          AppButton(
            label: 'History',
            radius: AppFonts.s30,
            margin: const EdgeInsets.only(top: AppFonts.s20),
            onTap: () => context.pushNavigator(const HistoryView()),
          )
        ],
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

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(AppFonts.s16),
          margin: const EdgeInsets.only(top: AppFonts.s10, bottom: AppFonts.s30),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppFonts.s16)),
          child: Row(
            children: [
              const ImageView(
                url: AppIcons.user,
                size: AppFonts.s30,
                margin: EdgeInsets.only(right: AppFonts.s10),
              ),
              Expanded(
                  child: Obx(
                () => TextView(
                  text:
                      profCtrl.name.isNotEmpty ? profCtrl.name : profCtrl.email,
                  textStyle: TextStyles.medium16TextHint,
                ),
              ))
            ],
          ),
        ),
        Positioned.fill(
            child: TapWidget(
          onTap: () => context.pushNavigator(const ProfileView()),
        ))
      ],
    );
  }
}

class _GenderButton extends StatelessWidget {
  final GenderEnum value;
  final Function(GenderEnum) onTap;

  const _GenderButton({
    super.key,
    required this.value,
    required this.onTap,
  });

  Widget button(
      {required String icon, required bool status, required Function() onTap}) {
    return AppButton(
      fillWidth: false,
      buttonColor: status ? AppColors.primaryGreen : AppColors.transparent,
      padding: const EdgeInsets.symmetric(
          horizontal: AppFonts.s40, vertical: AppFonts.s10),
      onTap: onTap,
      radius: AppFonts.s20,
      child: ImageView(
        url: icon,
        size: AppFonts.s18,
        tintColor: status ? AppColors.white : AppColors.primaryGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            _header('Gender:'),
            Container(
              margin: const EdgeInsets.only(top: 3),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: AppColors.grey50),
                  borderRadius: BorderRadius.circular(AppFonts.s22)),
              child: Row(
                children: [
                  button(
                    icon: AppIcons.male,
                    status: GenderEnum.male == value,
                    onTap: () => onTap(GenderEnum.male),
                  ),
                  button(
                    icon: AppIcons.female,
                    status: GenderEnum.female == value,
                    onTap: () => onTap(GenderEnum.female),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeightView extends StatelessWidget {
  final HeightEnum measureType;
  final int cm;
  final int feet;
  final int inch;
  final Function(HeightEnum) onTap;
  final Function(int) onSelectCm;
  final Function(int) onSelectFeet;
  final Function(int) onSelectInch;

  const _HeightView(
      {super.key,
      required this.measureType,
      required this.onTap,
      required this.cm,
      required this.feet,
      required this.inch,
      required this.onSelectCm,
      required this.onSelectFeet,
      required this.onSelectInch});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppFonts.s30,
      ),
      padding: const EdgeInsets.all(AppFonts.s10),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppFonts.s10)),
      child: Column(
        children: [
          _header("Height"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                      top: AppFonts.s20, right: AppFonts.s10),
                  height: 100,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: AppColors.grey10,
                      borderRadius: BorderRadius.circular(AppFonts.s10)),
                  child: SizedBox(
                    child: measureType == HeightEnum.inch
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 45,
                                child: _Wheel(
                                  unit: "'",
                                  list: Height.feet,
                                  itemExtent: 30,
                                  onSelect: onSelectFeet,
                                  initialItemIndex: Height.feet
                                      .indexWhere((element) => element == feet),
                                ),
                              ),
                              SizedBox(
                                  width: 45,
                                  child: _Wheel(
                                    unit: "''",
                                    list: Height.inches,
                                    itemExtent: 30,
                                    onSelect: onSelectInch,
                                    initialItemIndex: Height.inches.indexWhere(
                                        (element) => element == inch),
                                  ))
                            ],
                          )
                        : SizedBox(
                            width: 90,
                            child: _Wheel(
                              unit: "cm",
                              list: Height.cms,
                              itemExtent: 30,
                              onSelect: onSelectCm,
                              initialItemIndex: Height.cms
                                  .indexWhere((element) => element == cm),
                            )),
                  ),
                ),
              ),
              SizedBox(
                width: 52,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buttonType('ft', measureType == HeightEnum.inch,
                        () => onTap(HeightEnum.inch),
                        fillWidth: true),
                    const SizedBox(
                      height: AppFonts.s10,
                    ),
                    _buttonType('cm', measureType == HeightEnum.cm,
                        () => onTap(HeightEnum.cm),
                        fillWidth: true),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _WeightView extends StatelessWidget {
  final WeightEnum measureType;
  final Function(WeightEnum) onTap;
  final int lbs;
  final int kg;
  final Function(int) onSelectLbs;
  final Function(int) onSelectKg;

  const _WeightView(
      {super.key,
      required this.measureType,
      required this.onTap,
      required this.lbs,
      required this.kg,
      required this.onSelectLbs,
      required this.onSelectKg});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppFonts.s40,
      ),
      padding: const EdgeInsets.all(AppFonts.s10),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppFonts.s10)),
      child: Column(
        children: [
          _header("Weight"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                      top: AppFonts.s20, right: AppFonts.s10),
                  height: 100,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: AppColors.grey10,
                      borderRadius: BorderRadius.circular(AppFonts.s10)),
                  child: SizedBox(
                      child: measureType == WeightEnum.kg
                          ? _Wheel(
                              unit: "kg",
                              list: Weight.kg,
                              itemExtent: 30,
                              onSelect: onSelectKg,
                              initialItemIndex: Weight.kg.indexWhere(
                                (element) => element == kg,
                              ))
                          : _Wheel(
                              unit: "lbs",
                              list: Weight.lbs,
                              itemExtent: 30,
                              onSelect: onSelectLbs,
                              initialItemIndex: Weight.lbs
                                  .indexWhere((element) => element == lbs))),
                ),
              ),
              SizedBox(
                width: 52,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buttonType('kg', measureType == WeightEnum.kg,
                        () => onTap(WeightEnum.kg),
                        fillWidth: true),
                    const SizedBox(
                      height: AppFonts.s10,
                    ),
                    _buttonType('lbs', measureType == WeightEnum.lbs,
                        () => onTap(WeightEnum.lbs),
                        fillWidth: true),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _AgeView extends StatelessWidget {
  final Function(int) onSelect;
  final int value;

  const _AgeView({
    super.key,
    required this.onSelect,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppFonts.s40 * 2,
      ),
      padding: const EdgeInsets.all(AppFonts.s10),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppFonts.s10)),
      child: Column(
        children: [
          _header("Age"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: AppFonts.s20),
                  height: 50,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: AppColors.grey10,
                      borderRadius: BorderRadius.circular(AppFonts.s10)),
                  child: _Wheel(
                    unit: "",
                    list: Age.age.reversed.toList(),
                    // reversed due to horizontal list
                    itemExtent: 70,
                    isHorizontal: true,
                    onSelect: onSelect,
                    initialItemIndex: Age.age.reversed
                        .toList()
                        .indexWhere((element) => element == value),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget _header(String title) => TextView(
      text: title,
      textStyle: TextStyles.medium16TextHint,
    );

Widget _buttonType(String label, bool status, Function() onTap,
    {bool fillWidth = false}) {
  return AppButton(
    onTap: onTap,
    label: label,
    labelStyle: status ? TextStyles.regular10White : TextStyles.regular10Black,
    fillWidth: fillWidth,
    buttonColor: status ? null : AppColors.grey20,
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: AppFonts.s16),
    radius: AppFonts.s20,
  );
}

class _Wheel extends StatelessWidget {
  final int initialItemIndex;
  final bool isHorizontal;
  final String unit;
  final List list;
  final double itemExtent;
  final Function(int) onSelect;

  const _Wheel({
    super.key,
    this.isHorizontal = false,
    required this.unit,
    required this.list,
    required this.itemExtent,
    required this.onSelect,
    required this.initialItemIndex,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: isHorizontal ? 1 : 0,
      child: CupertinoPicker(
        itemExtent: itemExtent,
        looping: true,
        diameterRatio: 100,
        squeeze: 1,
        scrollController: FixedExtentScrollController(
            initialItem: initialItemIndex > -1 ? initialItemIndex : 0),
        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
          background: Colors.transparent,
        ),
        onSelectedItemChanged: (int index) => onSelect(list[index]),
        children: List<Widget>.generate(
          list.length,
          (int index) {
            final value = '${list[index]} $unit'.trim();
            return Center(
              child: RotatedBox(
                quarterTurns: isHorizontal ? 3 : 0,
                child: TextView(
                  text: value,
                  textStyle: TextStyles.regular16Black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
