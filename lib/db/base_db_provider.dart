import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt/db/sql_manager.dart';
import 'package:sqflite/sqflite.dart';

///创建一个父类 主要应用于 获取表名 ，判断表是否存在等
abstract class BaseDBProvider {
  bool isTableExist = false;

  createTableString();

  tableName();

  ///创建表sql语句
  tableBaseString(String sql){
    return sql;
  }

  ///获取数据库
  Future<Database> getDatabase() async{
    return await open();
  }

  @mustCallSuper
  open() async{
    if(!isTableExist){
      await prepare(tableName(),createTableString());
    }
    return await SqlManager.getCurrentDatabase();
  }

  @mustCallSuper
  prepare(tableName,String createSql) async{
    isTableExist = SqlManager.isTableExits(tableName);
    if(!isTableExist){
       Database database = await SqlManager.getCurrentDatabase();
       return await database.execute(createSql);
    }
  }

}