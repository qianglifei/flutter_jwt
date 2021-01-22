import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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
    //delete existing if any
    await deleteDatabase(path);
    // Make sure the parent directory exists
    try{
      await Directory(dirname(path)).create(recursive: true);
    }catch(_){}

    var data = await rootBundle.load(join('assets', 'local_database.db'));
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);

    //从缓存目录读取db文件里面的数据
    queryData();
  }

  //从缓存目录读取db文件里面的数据
  static Future<List> queryData() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'local_database.db');
    // open the database
    var db = await openDatabase(path);

    // Our database as a single table with a single element
    _list = await db.rawQuery('SELECT * FROM PCSFWZDID_ONLY');
    print('list $_list');
    await db.close();
    return _list;
  }

  openJsonFile() async{
    var data = await rootBundle.load(join('assets','local_database.db'));
    print("--->data:$data");
  }
}