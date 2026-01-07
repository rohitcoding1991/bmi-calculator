
import 'package:flutter/material.dart';
import '../../model/KidsBmiModel.dart';

enum GenderEnum {male,female}
enum WeightEnum {kg,lbs}
enum HeightEnum {inch,cm}

enum BmiRemarksEnum {Underweight,Normal,Overweight,Obese}

List bmiStatusColors = [Colors.blueAccent,Colors.greenAccent, Colors.orangeAccent, Colors.redAccent];

class Height{
  static final List<int> feet = List.generate(9, (index) => index);
  static final List<int> inches = List.generate(12, (index) => index);
  static final List<int> cms = List.generate(211, (index) => index + 35);
}

class Weight{
  static final List<int> kg = List.generate(148, (index) => index + 3);
  static final List<int> lbs = List.generate(325, (index) => index + 6);
}

class Age{
  static final List<int> age = List.generate(120, (index) => index + 1);
}

List<KidsBmiModel> boyPercentileList= [
  KidsBmiModel(age: 1,per3: 14.5,per5: 14.7,per10: 15.1,per25:15.7 ,per50: 16.6,per75: 17.6,per85:18.1 ,per90: 18.6,per97: 19.8),
  KidsBmiModel(age: 2,per3: 14.5,per5:14.7 ,per10: 15.1,per25:15.7 ,per50: 16.6,per75: 17.6,per85:18.1 ,per90: 18.6,per97: 19.8),
  KidsBmiModel(age: 3,per3: 14.1,per5:14.3 ,per10: 14.7,per25: 15.3,per50: 16.0,per75: 16.8,per85:17.3 ,per90: 17.7,per97: 18.6),
  KidsBmiModel(age: 4,per3: 13.8,per5:14.0 ,per10: 14.4,per25: 14.9,per50: 15.6,per75: 16.4,per85:16.9 ,per90: 17.3,per97: 18.4),
  KidsBmiModel(age: 5,per3: 13.7,per5:13.6 ,per10: 14.1,per25: 14.7,per50: 15.4,per75: 16.3,per85:16.8 ,per90: 17.2,per97: 18.2),
  KidsBmiModel(age: 6,per3: 13.6,per5:13.7 ,per10: 14.0,per25: 14.6,per50: 15.4,per75: 16.3,per85:17.0 ,per90: 17.5,per97: 19.1),
  KidsBmiModel(age: 7,per3: 13.5,per5:13.9 ,per10: 14.0,per25: 14.7,per50: 15.5,per75: 16.6,per85:17.4 ,per90: 18.0,per97: 20.0),
  KidsBmiModel(age: 8,per3: 13.6,per5:13.9 ,per10: 14.1,per25: 14.8,per50: 15.8,per75: 17.0,per85:17.9 ,per90: 18.7,per97: 21.2),
  KidsBmiModel(age: 9,per3: 13.7,per5:14.0 ,per10: 14.3,per25: 15.1,per50: 16.2,per75: 17.6,per85:18.6 ,per90: 19.4,per97: 22.4),
  KidsBmiModel(age: 10,per3: 14.0,per5:14.2 ,per10: 14.6,per25: 15.5,per50: 16.8,per75: 18.2,per85:18.4 ,per90: 20.3,per97: 23.7),
  KidsBmiModel(age: 11,per3: 14.3,per5:14.5 ,per10: 15.0,per25: 15.9,per50: 17.2,per75: 18.9,per85:20.2 ,per90: 21.2,per97: 24.9),
  KidsBmiModel(age: 12,per3: 14.7,per5:15.0 ,per10: 15.4,per25: 16.4,per50: 17.8,per75: 19.7,per85:21.0 ,per90: 22.1,per97: 26.0),
  KidsBmiModel(age: 13,per3: 15.1,per5:15.4 ,per10: 16.0,per25: 17.0,per50: 18.4,per75: 20.4,per85:21.8 ,per90: 23.0,per97: 27.0),
  KidsBmiModel(age: 14,per3: 15.6,per5:16.0 ,per10: 16.5,per25: 17.6,per50: 19.1,per75: 21.2,per85:22.6 ,per90: 23.8,per97: 27.8),
  KidsBmiModel(age: 15,per3: 16.2,per5:16.5 ,per10: 17.1,per25: 18.2,per50: 19.8,per75: 21.9,per85:23.4 ,per90: 24.6,per97: 28.6),
  KidsBmiModel(age: 16,per3: 16.7,per5:17.1 ,per10: 17.7,per25: 18.9,per50: 20.5,per75: 22.7,per85:24.2 ,per90: 25.4,per97: 29.3),
  KidsBmiModel(age: 17,per3: 17.3,per5:17.7 ,per10: 18.3,per25: 19.5,per50: 21.2,per75: 23.4,per85:24.9 ,per90: 26.1,per97: 29.9),
  KidsBmiModel(age: 18,per3: 17.8,per5:18.2 ,per10: 18.9,per25: 20.1,per50: 21.9,per75: 24.1,per85:25.6 ,per90: 26.8,per97: 30.6),
  KidsBmiModel(age: 19,per3: 18.3,per5:18.7 ,per10: 19.4,per25: 20.7,per50: 22.5,per75: 24.8,per85:26.4 ,per90: 27.6,per97: 31.4),
  KidsBmiModel(age: 20,per3: 18.7,per5:19.1 ,per10: 19.8,per25: 21.2,per50: 23.0,per75: 25.4,per85:27.0 ,per90: 28.3,per97: 32.3),
];

List<KidsBmiModel> girlPercentileList= [
  KidsBmiModel(age: 1,per3: 14.1,per5:14.4 ,per10: 14.8,per25:15.5 ,per50: 16.4,per75: 17.4,per85:18.0 ,per90: 18.4,per97: 19.5),
  KidsBmiModel(age: 2,per3: 14.1,per5:14.4 ,per10: 14.8,per25:15.5 ,per50: 16.4,per75: 17.4,per85:18.0 ,per90: 18.4,per97: 19.5),
  KidsBmiModel(age: 3,per3: 13.8,per5:14.0 ,per10: 12.5,per25: 13.4,per50: 14.2,per75: 15.5,per85:17.2 ,per90: 16.8,per97: 18.0),
  KidsBmiModel(age: 4,per3: 13.1,per5:13.7 ,per10: 14.3,per25: 14.9,per50: 15.7,per75: 16.6,per85:16.8 ,per90: 17.6,per97: 19.7),
  KidsBmiModel(age: 5,per3: 13.3,per5:13.5 ,per10: 13.8,per25: 14.4,per50: 15.2,per75: 16.1,per85:16.8 ,per90: 17.3,per97: 19.0),
  KidsBmiModel(age: 6,per3: 13.2,per5:13.4 ,per10: 13.8,per25: 14.4,per50: 15.2,per75: 16.3,per85:17.1 ,per90: 17.7,per97: 19.7),
  KidsBmiModel(age: 7,per3: 13.2,per5:13.4 ,per10: 13.8,per25: 14.5,per50: 15.4,per75: 16.7,per85:17.6 ,per90: 18.3,per97: 20.7),
  KidsBmiModel(age: 8,per3: 13.3,per5:13.6 ,per10: 13.9,per25: 14.7,per50: 15.8,per75: 17.3,per85:18.3 ,per90: 19.1,per97: 21.9),
  KidsBmiModel(age: 9,per3: 13.5,per5:13.8 ,per10: 14.2,per25: 15.1,per50: 16.3,per75: 17.9,per85:19.1 ,per90: 20.0,per97: 23.2),
  KidsBmiModel(age: 10,per3: 13.7,per5:14.0 ,per10: 14.5,per25: 15.5,per50: 16.8,per75: 18.7,per85:20.0 ,per90: 21.0,per97: 24.6),
  KidsBmiModel(age: 11,per3: 14.1,per5:14.4 ,per10: 14.9,per25: 16.0,per50: 17.4,per75: 19.4,per85:20.8 ,per90: 22.0,per97: 26.9),
  KidsBmiModel(age: 12,per3: 14.5,per5:14.8 ,per10: 15.4,per25: 16.5,per50: 18.1,per75: 20.2,per85:21.7 ,per90: 22.9,per97: 27.1),
  KidsBmiModel(age: 13,per3: 14.9,per5:15.3 ,per10: 15.9,per25: 17.1,per50: 18.7,per75: 20.9,per85:22.5 ,per90: 23.9,per97: 28.3),
  KidsBmiModel(age: 14,per3: 15.4,per5:15.8 ,per10: 16.4,per25: 17.6,per50: 19.3,per75: 21.7,per85:23.3 ,per90: 24.7,per97: 29.4),
  KidsBmiModel(age: 15,per3: 15.9,per5:16.3 ,per10: 16.9,per25: 18.2,per50: 19.9,per75: 22.3,per85:24.0 ,per90: 25.4,per97: 30.3),
  KidsBmiModel(age: 16,per3: 16.4,per5:16.7 ,per10: 17.4,per25: 18.7,per50: 20.4,per75: 22.9,per85:24.6 ,per90: 26.1,per97: 31.2),
  KidsBmiModel(age: 17,per3: 16.8,per5:17.2 ,per10: 17.8,per25: 19.1,per50: 20.9,per75: 23.4,per85:25.2 ,per90: 26.7,per97: 32.1),
  KidsBmiModel(age: 18,per3: 17.1,per5:17.5 ,per10: 18.2,per25: 19.4,per50: 21.3,per75: 23.8,per85:25.7 ,per90: 27.2,per97: 33.0),
  KidsBmiModel(age: 19,per3: 17.4,per5:17.7 ,per10: 18.4,per25: 19.7,per50: 21.5,per75: 24.1,per85:26.1 ,per90: 27.7,per97: 34.0),
  KidsBmiModel(age: 20,per3: 17.4,per5:17.8 ,per10: 18.5,per25: 19.8,per50: 21.7,per75: 24.4,per85:26.5 ,per90: 28.2,per97: 35.0),
];