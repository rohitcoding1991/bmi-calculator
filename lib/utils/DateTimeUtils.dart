import 'package:intl/intl.dart';

class DateTimeUtils{

  //get time stamp of length 13...
  static int get getCurrentTimeStamp => DateTime.now().millisecondsSinceEpoch;

  // convert timeStamp to format string ....
  static String stampToPattern(int timeStamp, String pattern)=> dateTimeToPattern(stampToDateTime(timeStamp),pattern);

  // convert time stamp to dateTime .....
  static DateTime stampToDateTime(int timeStamp)=> DateTime.fromMillisecondsSinceEpoch(timeStamp);

  // convert string to dateTime .... returns DateTime
  static DateTime patternToDateTime(String value, String pattern)=> DateFormat(pattern).parse(value);

  // convert dateTime to string pattern .... returns String
  static String dateTimeToPattern(DateTime dTime, String pattern)=> DateFormat(pattern).format(dTime);
}


class DateTimePattern{
  static const String ddMMyyyy_HHss = 'dd-MM-yyyy HH:ss';//08-12-2023 12:00
  static const String ddMMyyyy = 'dd-MM-yyyy';//08-12-2023
  static const String HHss = 'HH:ss';//12:00
}


// Extension
extension StampToPatternExtension on int{
  String get ddMMyyyy_HHss =>DateTimeUtils.stampToPattern(this, DateTimePattern.ddMMyyyy_HHss);
  String get ddMMyyyy =>DateTimeUtils.stampToPattern(this, DateTimePattern.ddMMyyyy);
  String get HHss =>DateTimeUtils.stampToPattern(this, DateTimePattern.HHss);
}