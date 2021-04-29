import 'package:flutter/material.dart';
import 'package:flutter_app/Database/Home_Screen_Database.dart';
class home_screen extends StatefulWidget {
  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
     child: Scaffold(
       appBar: AppBar(
         backgroundColor: const Color(0xff021962),
         centerTitle: true,
         title: Text("Home Screen"),
       ),
       body: SingleChildScrollView(
         child: FutureBuilder(
            future: Home_Screen.mdd.getdatafromdb(),
           builder: (BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else{
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount:  snapshot.data.length,
                    itemBuilder: (BuildContext context,int index){
                    return Card(
                      child:  Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: CircleAvatar(
                                backgroundImage: AssetImage("${snapshot.data[index].avatar}"),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Text("Hello")

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                    }
                );
              }
           },
         ),
       ),
     ),
    );
  }
}
