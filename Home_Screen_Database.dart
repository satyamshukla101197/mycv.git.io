import 'dart:io';

import 'package:flutter_app/Model/Home_Screen_Model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class Home_Screen{
  String categoryId;
  static Database _database;
  static final Home_Screen mdd=Home_Screen._();
  Home_Screen._();

  Future<Database> get database async{
    if(_database !=null){
      return _database;
    }
    _database =await initDB();

    return _database;
  }

  initDB() async{
    Directory documentdirectory=await getApplicationDocumentsDirectory();
    final path=join(documentdirectory.path,'Home_Screen.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE HOME_SCREEN('
              'page INTEGER,'
              'per_page INTEGER,'
              'total INTEGER,'
              'total_pages INTEGER,'
              'id INTEGER,'
              'email TEXT,'
              'first_name TEXT,'
              'last_name TEXT,'
              'avatar TEXT,'
              'url TEXT,'
              'text TEXT'


              ')');
        });
  }
  // inser data in table
  createMaterialDetails(HomeScreen newhomeScreen)async{
    final db=await database;
    final res=await db.insert('HOME_SCREEN', newhomeScreen.toMap());
    print('dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
    return res;

  }
  // delete data from table

  Future<int> deleteMaterialDetails()async{
    final db=await database;
    final res=db.rawDelete('DELETE FROM HOME_SCREEN');
    return res;

  }
// Retrive data from database
  Future<List<HomeScreen>> getdatafromdb()async{
    final db=await database;
    final res=await db.rawQuery('SELECT * FROM HOME_SCREEN');
    print(res);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    //List<Material> list=res.isNotEmpty ?res.map((d) => Material.fromJson(d)).toList():[];
   // return list;
  }
}