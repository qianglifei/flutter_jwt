import 'package:flutter/material.dart';

class URLConfig{
  static const  String IP = "jwb.beikongyun.com";
  static const  String BASE_URL = "http://jwb.beikongyun.com/";
  //static const  String BASE_URL = "http://130.10.7.94:8085/";
  //static const  String BASE_URL = "http://130.10.8.38:4085/";
  // 登陆
  static const  String LOGIN = BASE_URL + "jwb/yhdl/yhdlyz";
  // 修改密码接口
  static const String MODIFY_PASSWORD = BASE_URL + "jwb/yhxx/xgmm";
  // 首页数据总览
  static const String DATA_STATISTICS = BASE_URL + "jwb/sjzl/sjzlcx";
  // 首页数据概览
  static const String DATA_GL = BASE_URL + "jwb/sjgl/sjglcx";
  //1.派出所查询接口
  static const String pcscx = BASE_URL + "jwb/dmxx/pcscx";
  //2.服务站查询接口
  static const String fwzcx = BASE_URL + "jwb/dmxx/fwzcx";
  //核查详情查询接口
  static const String fwhcxq = BASE_URL + "jwb/fwhc/fwhcxq";
  //核查列表查询接口
  static const String fwhccx = BASE_URL + "jwb/fwhc/fwhccx";
  //核查统计查询接口
  static const String hctjcx = BASE_URL + "jwb/hctj/hctjcx";
  //人口核查记录 核查记录列表查询接口
  static const String rkhccx = BASE_URL + "jwb/rkhcjl/rkhccx";
  //房屋核查记录核查 记录列表查询接口
  static const String fwhcjl_fwhccx = BASE_URL + "jwb/fwhcjl/fwhccx";
  //人员核查
  static const String RYHC = BASE_URL + "jwb/rkhc/rkhccx";
  //人员核查提交
  static const String RYHCTJ = BASE_URL + "jwb/rkhc/rkhcbc";
  //列表人员详情
  static const String rkhcxq = BASE_URL + "jwb/rkhcjl/rkhcxq";
  //列表房屋详情 核查记录详情查询接口
  static const String fwhcjl_fwhcxq = BASE_URL + "jwb/fwhcjl/fwhcxq";
  //房屋核查提交接口
  static const String fwhctj = BASE_URL + "jwb/fwhc/fwhctj";
  //三、人口核查 1.核查查询接口
  static const String rkhc_rkhccx = BASE_URL + "jwb/rkhc/rkhccx";
  //监督核查 列表
  static const String jdhclbcx = BASE_URL + "jwb/jdhcjl/jdhclbcx";
  //监督核查 详情
  static const String jdhcxqcx = BASE_URL + "jwb/jdhcjl/jdhcxqcx";
  //监督核查 提交
  static const String jdhctj = BASE_URL + "jwb/jdhcjl/jdhctj";
}