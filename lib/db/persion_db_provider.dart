
import 'dart:html';

import 'package:jwt/db/base_db_provider.dart';
import 'package:jwt/entity/user_entity.dart';
import 'package:sqflite/sqflite.dart';

class PersonDBProvider extends BaseDBProvider{
  final String name = "PersonInfo";
  final String columnId = "id";
  final String columnMobile = "18612937836";
  final String columnHeadImage = "headImage";

  PersonDBProvider();

  @override
  createTableString() {
    // TODO: implement createTableString
    return '''
        create table $name (
        $columnId integer primary key,$columnHeadImage text not null,
        $columnMobile text not null)
      ''';
  }

  @override
  tableName() {
    // TODO: implement tableName
    return name;
  }


  ///查询数据库
  Future _getPersonProvider(Database db,int id) async{
    Database database = await getDatabase();
    List<Map<String,dynamic>> list =
        await db.rawQuery("select * from $name where $columnId = $id");
    return list ?? new List();
  }


  ///插入数据库
  Future insert(UserModel userModel) async{
    Database db = await getDatabase();
//    var userProvider  = await _getPersonProvider(db, userModel);
//    if (userProvider != null) {
      ///删除数据
//      await db.delete(name, where: "$columnId = ?", whereArgs: [model.id]);
//    }
//    return await db.rawInsert("insert into $name ($columnId,$columnMobile,$columnHeadImage) values (?,?,?)",[model.id,model.mobile,model.headImage]);
  }

  ///更新数据库
  Future<void> update(UserModel model) async {
    Database database = await getDatabase();
//    await database.rawUpdate(
//        "update $name set $columnMobile = ?,$columnHeadImage = ? where $columnId= ?",[model.mobile,model.headImage,model.id]);

  }


  ///获取事件数据
  Future<UserModel> getPersonInfo(int id) async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> maps  = await _getPersonProvider(db, id);
//    if (maps.length > 0) {
//      return UserModel.fromJson(maps[0]);
//    }
    return null;
  }
}