import 'package:intl/intl.dart';

class TimeUtils {

   static String getNowTime(){
    //将时间字符串转为时间对象
    String nowTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    return nowTime ?? "";
  }
}