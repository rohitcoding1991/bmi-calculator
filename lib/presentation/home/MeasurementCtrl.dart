import 'package:bmi_calculator/model/MeasurementModel.dart';
import 'package:bmi_calculator/services/repository/mesaurementRepo/MeasurementRepoImplementation.dart';
import 'package:get/get.dart';

import '../../components/constant/constants.dart';
import '../../services/localData/AppData.dart';
import '../../utils/DateTimeUtils.dart';

class MeasurementCtrl extends GetxController {
  final  _measurementRepo = MeasurementRepoImplementation();

  // by default gender value will be male...
  final Rx<GenderEnum> _gender = Rx<GenderEnum>(GenderEnum.male);
  GenderEnum get gender => _gender.value;



  //height.....
  final Rx<HeightEnum> _heightType = Rx<HeightEnum>(HeightEnum.inch);
  HeightEnum get heightType => _heightType.value;

  final Rx<int> _heightCm = Rx<int>(152);
  int get heightCm => _heightCm.value;

  final Rx<int> _heightFeet = Rx<int>(5);
  int get heightFeet => _heightFeet.value;

  final Rx<int> _heightInch = Rx<int>(0);
  int get heightInch => _heightInch.value;


  //weight.....
  final Rx<WeightEnum> _weightType = Rx<WeightEnum>(WeightEnum.kg);
  WeightEnum get weightType => _weightType.value;

  final Rx<int> _weightKg = Rx<int>(45);
  int get weightKg => _weightKg.value;

  final Rx<int> _weightLbs = Rx<int>(100);
  int get weightLbs => _weightLbs.value;


  //age......
  final Rx<int> _age = Rx<int>(20);
  int get age => _age.value;

  final RxList<MeasurementModel> _historyList = RxList<MeasurementModel>([]);
  List<MeasurementModel> get historyList => _historyList;


  final Rx<MeasurementModel?> _result = Rx<MeasurementModel?>(null);
  MeasurementModel? get result => _result.value;
  
  void onSelectGender(GenderEnum value) {
    _gender.value = value;
    _gender.refresh();
  }

  void onSelectHeightType(HeightEnum value) {
    _heightType.value = value;
    _heightType.refresh();
  }

  void onSelectWeightType(WeightEnum value) {
    _weightType.value = value;
    _weightType.refresh();
  }

  void onSelectHeightCmValue(int value) {
    _heightCm.value = value;
  }

  void onSelectHeightFeetValue(int value) {
    _heightFeet.value = value;
  }

  void onSelectHeightInchValue(int value) {
    _heightInch.value = value;
  }

  void onSelectWeightKgValue(int value) {
    _weightKg.value = value;
  }

  void onSelectWeightLbsValue(int value) {
    _weightLbs.value = value;
  }

  void onSelectAge(int value) {
    _age.value = value;
  }

  Future<String> onCalculate() async {
    try{
      final timeStamp = DateTimeUtils.getCurrentTimeStamp;

      // convert data to MeasurementModel , generated bmi value....
      final doc = generateBMI(MeasurementModel(
        id: timeStamp.toString(),
        age: age,
        gender: gender.name,
        heightCm: heightCm,
        heightFeet: heightFeet,
        heightInch: heightInch,
        heightUnit: heightType.name,
        timeStamp: timeStamp,
        uid: AppData.uid,
        weightKg: weightKg,
        weightLbs: weightLbs,
        weightUnit: weightType.name,
      ));

    //   gender: gender.name,
    // heightCm: heightType ==  HeightEnum.cm? heightCm : null,
    // heightFeet: heightType ==  HeightEnum.inch? heightFeet : null,
    // heightInch: heightType ==  HeightEnum.inch? heightInch : null,
    // heightUnit: heightType.name,
    // weightKg: weightType == WeightEnum.kg ?weightKg : null,
    // weightLbs: weightType == WeightEnum.lbs ? weightLbs : null,
    // weightUnit: weightType.name,
    // age: age

      String result = await _measurementRepo.calculate(doc: doc);
      _result.value = MeasurementModel.fromJson(doc.toJson());
      _result.refresh();
     return result;

    }catch(e){
      rethrow;
    }
  }

  Future<bool> getHistoryList({bool isInit = false}) async{
    try{
      final data = await _measurementRepo.fetchHistory();
      _historyList.assignAll(data);
      _historyList.refresh();

      // check whether history record present, if exist then update form with last record....
      if(isInit && historyList.isNotEmpty){
        final doc = historyList[0];
        _gender.value = doc.genderValue;
        _heightCm.value = doc.heightCm ?? heightCm;
        _heightInch.value = doc.heightInch ?? heightInch;
        _heightFeet.value = doc.heightFeet ?? heightFeet;
        _heightType.value = doc.heightUnitValue;
        _weightKg.value = doc.weightKg ?? weightKg;
        _weightLbs.value = doc.weightLbs ?? weightLbs;
        _weightType.value = doc.weightUnitValue;
        _age.value = doc.age ?? age;

        _gender.refresh();
        _heightType.refresh();
        _weightType.refresh();
        _heightFeet.refresh();
        _heightInch.refresh();
        update();
      }

      return true;
    }catch(e){
      rethrow;
    }
  }

  Future<void> removeHistoryItem(int index) async{
    try{
      final item = historyList[index];
      await _measurementRepo.deleteHistoryItem(id: item.id!);
      _historyList.remove(item);
      _historyList.refresh();
      return;
    }catch(e){
      rethrow;
    }
  }
}
