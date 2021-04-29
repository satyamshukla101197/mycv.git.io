import 'package:flutter_app/Model/registration.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Registration_database {
  //Create a private constructor
  Registration_database._();

  Registration_database();

  static const databaseName = 'registration.db';
  static final Registration_database instance = Registration_database._();
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE registration(username Text, firstName TEXT, lastName TEXT,password Text)");
        });
  }

   insertregistration(registration registration) async{
      final db=await database;
      final res=await db.insert('registration', registration.toMap());
      return res;
   }



  Future<registration> checkLogin(String userName, String password) async {
    final dbClient = await database;
    var res = await dbClient.rawQuery(
        "SELECT * FROM $registration WHERE username = '$userName' and password = '$password'");
  }
}
