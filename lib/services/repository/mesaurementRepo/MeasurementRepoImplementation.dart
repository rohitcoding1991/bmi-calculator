import 'package:bmi_calculator/components/constant/constants.dart';
import 'package:bmi_calculator/model/MeasurementModel.dart';
import 'package:bmi_calculator/services/firebase/FirebaseDBService.dart';
import 'package:bmi_calculator/services/localData/AppData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/KidsBmiModel.dart';
import 'MeasurementRepo.dart';

class MeasurementRepoImplementation implements MeasurementRepo {
  final _collection = FirebaseDBService('data', 'measurement');

  @override
  Future<String> calculate({required MeasurementModel doc}) async {
    try {
      return await _collection.setDoc(doc.id!, doc.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteHistoryItem({required String id}) async {
    return await _collection.delete(id);
  }

  @override
  Future<List<MeasurementModel>> fetchHistory() async {
    try {
      final snapShot = await _collection.documentsWithOrderWhere(
          compareField: 'uid',
          compareValue: AppData.uid,
          sortField: 'timeStamp',
          descending: true);
      if (snapShot.size > 0) {
        List<MeasurementModel> ll = List<MeasurementModel>.from(snapShot.docs
            .map((doc) =>
                MeasurementModel.fromJson(doc.data() as Map<String, dynamic>)));
        ll.sort(
          (a, b) => b.timeStamp!.compareTo(a.timeStamp!),
        );
        return ll;
      } else {
        return [];
      }
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Object> showResult() {
    // TODO: implement showResult
    throw UnimplementedError();
  }
}

MeasurementModel generateBMI(MeasurementModel data) {
  final gender = data.genderValue;
  final height = data.heightInMeter;
  final weight = data.weightInKg;
  final age = data.age ?? 0;

  final bmi = weight / (height * height);
  data.bmiValue = bmi;
  BmiRemarksEnum remarks = BmiRemarksEnum.Underweight;
  if (age > 19) {
    if (gender == GenderEnum.male) {
      if (bmi < 18.5) {
        remarks = BmiRemarksEnum.Underweight;
      } else if (bmi >= 18.5 && bmi < 25.0) {
        remarks = BmiRemarksEnum.Normal;
      } else if (bmi >= 25.0 && bmi < 30.0) {
        remarks = BmiRemarksEnum.Overweight;
      } else {
        remarks = BmiRemarksEnum.Obese;
      }
    } else {
      if (bmi < 18.5) {
        remarks = BmiRemarksEnum.Underweight;
      } else if (bmi >= 18.5 && bmi < 25.0) {
        remarks = BmiRemarksEnum.Normal;
      } else if (bmi >= 25.0 && bmi < 30.0) {
        remarks = BmiRemarksEnum.Overweight;
      } else {
        remarks = BmiRemarksEnum.Obese;
      }
    }
  } else {
    // get percentile for kids according to their bmi....
    if (gender == GenderEnum.male) {
      final percentileData =
          boyPercentileList.firstWhere((element) => element.age == age);
      remarks = getRemarksByPercentile(percentileData, bmi);
    } else {
      final percentileData =
          girlPercentileList.firstWhere((element) => element.age == age);
      remarks = getRemarksByPercentile(percentileData, bmi);
    }
  }

  data.bmiRemarks = remarks.name;

  return data;
}

BmiRemarksEnum getRemarksByPercentile(KidsBmiModel data, double bmi) {
  BmiRemarksEnum remarks = BmiRemarksEnum.Underweight;
  if (bmi < data.per5!) {
    remarks = BmiRemarksEnum.Underweight;
  } else if (bmi >= data.per5! && bmi < data.per85!) {
    remarks = BmiRemarksEnum.Normal;
  } else if (bmi >= data.per85! && bmi < data.per97!) {
    remarks = BmiRemarksEnum.Overweight;
  } else {
    remarks = BmiRemarksEnum.Obese;
  }
  return remarks;
}
