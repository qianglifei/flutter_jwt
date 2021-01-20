import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:jwt/entity/pcs_fwz_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlManager{
  static const _VERSION = 1;
  static const _DATABASE_NAME = "你的世界我曾经来过";
  static Database _database;
  static List _list = [];

  ///初始化数据库
  static init() async{
    var databasePath = await getDatabasesPath();
    String path = join(databasePath,_DATABASE_NAME);
    _database = await openDatabase(path,version: _VERSION,onCreate: (Database db,int version){});
  }

  ///判断表是否存在
   static isTableExits(String tableName) async {
      await getCurrentDatabase();
      var res = await _database.rawQuery("select * from Sqlite_master where type = 'table' and name = '$tableName'");
      return res != null && res.length > 0;
   }

  ///获取当前数据库对象
  static getCurrentDatabase() async{
    if(_database == null){
      await init();
    }
    return _database;
  }

  ///关闭数据库
  static close() async{
    ///?. 操作符当对象不为空时调用后面的属性或方法： foo？.a 类似于 if（foo ！= null f.a）
    _database ?.close();
    _database = null;
  }

  ///将flutter路径下的db文件，copy到Android/ios的 缓存目录下
  static copyDbFileToCacheDocument() async{
    var databasesPath = await getDatabasesPath();
    print(databasesPath);
    var path = join(databasesPath,"local_database.db");
    // check  if database exists
    var exists = await databaseExists(path);
    if(!exists){
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");
      //make sure the parent directory exists
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_){}
      // copy from assets
      var data = await rootBundle.load(join('assets', 'local_database.db'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }else{
      print("opening existing database");
    }
    _database = await openDatabase(path,readOnly: true);
  }

  //查询派出所数据
  static Future<List> queryPCSData() async {
    // open the database
    _list = await _database.rawQuery('select Distinct pcsbh,pcsmc FROM PCSFWZDID_ONLY');
    List pcsList = [];
    print('list $_list');
    _list.forEach((item){
      print('Map $item');
      Map map = item;
      PcsFwzEntity bean = new PcsFwzEntity();
      map.forEach((key,value){
        if(key == "PCSMC"){
          bean.key = value;
        }else if(key == "PCSBH"){
          bean.value = value;
        }
      });
      pcsList.add(bean);
    });
    return pcsList ?? [];
  }

  static queryFWZData() async{

    await _database.close();
  }

  openJsonFile() async{
    var data = await rootBundle.load(join('assets','local_database.db'));
    print("--->data:$data");
  }
}