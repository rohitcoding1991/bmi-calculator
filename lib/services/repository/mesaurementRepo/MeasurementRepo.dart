import '../../../model/MeasurementModel.dart';

abstract class MeasurementRepo {
  Future<Object> calculate({ required MeasurementModel doc});
  Future<Object> showResult();
  Future<Object> fetchHistory();
  Future<void> deleteHistoryItem({required String id});
}