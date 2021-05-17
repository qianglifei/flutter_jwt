//该文件提供根据年月日计算岁数的功能函数，计算得出的函数是周岁，不满一周岁的年月会被忽略
class AgeUtils {

  ///输入格式19990131
  int getAgeFromBirthday(String dob) {
    int selectYear = int.parse(dob.substring(0, 4));
    int selectMonth = int.parse(dob.substring(4, 6));
    int selectDay = int.parse(dob.substring(6, 8));
    DateTime now = DateTime.now();
    int yearNow = now.year;
    int monthNow = now.month;
    int dayNow = now.day;
    // 用当前年减去出生年，例如2019-1-22 ，出生年日月是2011年-6-1
    //当前值是8
    int yearMinus = yearNow - selectYear;
    //当前值是-5，monthMinus大于0的情况下，证明满8周岁。等于0需要判断dayMinus，小于0的时候age-1
    int monthMinus = monthNow - selectMonth;
    //当前值是21，monthMinus大于0的情况下，配合monthMinus等于0的情况下，age等于原值。否则age等于age-1
    int dayMinus = dayNow - selectDay;
    // 先大致赋值
    int age = yearMinus;
    if (age <= 0) {
      return 0;
    }
    if (monthMinus == 0) {
      if (dayMinus <= 0) {
        age = age - 1;
      }
    } else if (monthMinus < 0) {
      age = age - 1;
    }
    return age;
  }

  ///输入格式1999-03-05
  int getAgeFromBirthdayWithSep(String dob) {
    List<String> list = dob.split("-");
    return getAgeFromBirthday("${list[0]}${list[1]}${list[2]}");
  }

  /// 获取出生日期

  String getBirthday(String idCard){
    if(idCard == null){
      return "";
    }
    String selectYear = idCard.substring(6, 10);
    String selectMonth = idCard.substring(10, 12);
    String selectDay = idCard.substring(12, 14);
    return selectYear + "-" +selectMonth + "-"+ selectDay;
  }
}