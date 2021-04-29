import 'dart:convert';
import 'package:flutter_app/Database/Home_Screen_Database.dart';
import 'package:flutter_app/Model/Home_Screen_Model.dart';
import 'package:http/http.dart'as http;


class home_screen_provider{

  Future<List<HomeScreen>> getAllData() async{
    print("kkkkkkkkkkkkkkkkkkkk");

    var response = await http.get( "https://reqres.in/api/users?page=1");
    print(response);
   if(response.statusCode==200){
     Map<String, dynamic> map = json.decode(response.body);
     Home_Screen.mdd.deleteMaterialDetails();
     var activities= map["Result"] as List;
     for (var activity in activities) {
       HomeScreen actData = HomeScreen.fromMap(activity);
       Home_Screen.mdd.createMaterialDetails(actData);
       print("Inserted Database");
     }
   }else{
     print("Error");
   }
  }
}