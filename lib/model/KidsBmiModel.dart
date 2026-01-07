// To parse this JSON data, do
//
//     final kidsBmiModel = kidsBmiModelFromJson(jsonString);

import 'dart:convert';

import '../components/constant/constants.dart';

KidsBmiModel kidsBmiModelFromJson(String str) => KidsBmiModel.fromJson(json.decode(str));

String kidsBmiModelToJson(KidsBmiModel data) => json.encode(data.toJson());

class KidsBmiModel {
  int? age;
  double? per3;
  double? per5;
  double? per10;
  double? per25;
  double? per50;
  double? per75;
  double? per85;
  double? per90;
  double? per97;

  KidsBmiModel({
    this.age,
    this.per3,
    this.per5,
    this.per10,
    this.per25,
    this.per50,
    this.per75,
    this.per85,
    this.per90,
    this.per97,
  });

  factory KidsBmiModel.fromJson(Map<String, dynamic> json) => KidsBmiModel(
    age: json["age"],
    per3: json["per3"],
    per5: json["per5"],
    per10: json["per10"],
    per25: json["per25"],
    per50: json["per50"],
    per75: json["per75"],
    per85: json["per85"],
    per90: json["per90"],
    per97: json["per97"],
  );

  Map<String, dynamic> toJson() => {
    "age": age,
    "per3": per3,
    "per5": per5,
    "per10": per10,
    "per25": per25,
    "per50": per50,
    "per75": per75,
    "per85": per85,
    "per90": per90,
    "per97": per97,
  };
}
