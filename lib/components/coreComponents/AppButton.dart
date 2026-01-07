import 'package:flutter/material.dart';

import '../constant/AppColors.dart';
import '../constant/AppFonts.dart';
import '../constant/TextStyles.dart';
import 'TapWidget.dart';
import 'TextView.dart';

class AppButton extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final Function()? onTap;
  final double? radius;
  final Color? buttonColor;
  final Color? buttonBorderColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool fillWidth;
  final Widget? child;
  const AppButton({super.key, this.label, this.onTap, this.radius, this.labelStyle, this.buttonColor, this.buttonBorderColor, this.padding, this.margin, this.fillWidth = true, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Stack(
        children: [
          Container(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: AppFonts.s20, vertical: AppFonts.s20),
            width: fillWidth ? double.maxFinite : null,
            decoration: BoxDecoration(
              color: buttonColor ?? AppColors.primaryGreen,
              borderRadius: BorderRadius.circular(radius ??AppFonts.s10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(text: label ?? '',textStyle:  labelStyle ?? TextStyles.medium14White,),
                child ?? const SizedBox()
              ],
            ),
          ),
          Positioned.fill(child: TapWidget(onTap: onTap,))
        ],
      ),
    );
  }
}
