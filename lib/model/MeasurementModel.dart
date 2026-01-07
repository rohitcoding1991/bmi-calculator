// To parse this JSON data, do
//
//     final measurementModel = measurementModelFromJson(jsonString);

import 'dart:convert';

import 'package:bmi_calculator/components/constant/constants.dart';
import 'package:flutter/material.dart';

MeasurementModel measurementModelFromJson(String str) =>
    MeasurementModel.fromJson(json.decode(str));

String measurementModelToJson(MeasurementModel data) =>
    json.encode(data.toJson());

class MeasurementModel {
  String? id;
  String? gender;
  int? heightCm;
  int? heightFeet;
  int? heightInch;
  String? heightUnit;
  int? weightKg;
  int? weightLbs;
  String? weightUnit;
  int? age;
  String? uid;
  int? timeStamp;
  double? bmiValue;
  String? bmiRemarks;

  MeasurementModel(
      {this.id,
      this.gender,
      this.heightCm,
      this.heightFeet,
      this.heightInch,
      this.heightUnit,
      this.weightKg,
      this.weightLbs,
      this.weightUnit,
      this.age,
      this.uid,
      this.timeStamp,
      this.bmiValue,
      this.bmiRemarks});

  GenderEnum get genderValue =>
      gender == GenderEnum.female.name ? GenderEnum.female : GenderEnum.male;

  HeightEnum get heightUnitValue =>
      heightUnit == HeightEnum.cm.name ? HeightEnum.cm : HeightEnum.inch;

  WeightEnum get weightUnitValue =>
      weightUnit == WeightEnum.lbs.name ? WeightEnum.lbs : WeightEnum.kg;

  int get heightInMeter {
    if (heightUnitValue == HeightEnum.cm) {
      return 100 * (heightCm ?? 0);
    } else {
      final feetInch = (heightFeet ?? 0) * 12;
      return ((feetInch + (heightInch ?? 0)) * 0.0254).round();
    }
  }

  int get weightInKg {
    if (weightUnitValue == WeightEnum.lbs) {
      return (0.453592 * (weightLbs ?? 0)).round();
    } else {
      return weightKg ?? 0;
    }
  }

  String get showWeight {
    if (weightUnitValue == WeightEnum.lbs) {
      return '${weightLbs ?? 0} lbs';
    } else {
      return '${weightKg ?? 0} Kg';
    }
  }

  String get showHeight {
    if (heightUnitValue == HeightEnum.cm) {
      return '${heightCm ?? 0} cm';
    } else {
      return "${heightFeet ?? 0}' ${heightInch ?? 0}''";
    }
  }

  Color get bmiStatusColor {
    Color color = bmiStatusColors[0];
    if(bmiRemarks == BmiRemarksEnum.Normal.name){
      color = bmiStatusColors[1];
    }else  if(bmiRemarks == BmiRemarksEnum.Overweight.name){
      color = bmiStatusColors[2];
    }else  if(bmiRemarks == BmiRemarksEnum.Obese.name){
      color = bmiStatusColors[3];
    }
    return color;
  }

  factory MeasurementModel.fromJson(Map<String, dynamic> json) =>
      MeasurementModel(
        id: json["id"],
        gender: json["gender"],
        heightCm: json["heightCm"],
        heightFeet: json["heightFeet"],
        heightInch: json["heightInch"],
        heightUnit: json["heightUnit"],
        weightKg: json["weightKg"],
        weightLbs: json["weightLbs"],
        weightUnit: json["weightUnit"],
        age: json["age"],
        uid: json["uid"],
        timeStamp: json["timeStamp"],
        bmiValue: json["bmiValue"]?.toDouble(),
        bmiRemarks: json["bmiRemarks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender": gender,
        "heightCm": heightCm,
        "heightFeet": heightFeet,
        "heightInch": heightInch,
        "heightUnit": heightUnit,
        "weightKg": weightKg,
        "weightLbs": weightLbs,
        "weightUnit": weightUnit,
        "age": age,
        "uid": uid,
        "timeStamp": timeStamp,
        "bmiValue": bmiValue,
        "bmiRemarks": bmiRemarks,
      };
}
