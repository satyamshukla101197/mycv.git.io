import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Api_provider/Home_Screen_Api_Provider.dart';
import 'package:flutter_app/Database/registration_database.dart';
import 'package:flutter_app/Model/registration.dart';
import 'package:flutter_app/View/registration_screen.dart';

import 'View/Home_Screen.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  final username = TextEditingController();
  final password = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,

              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2)),
                  biild_LoginForm(),
                ],
              )
            ],
          ),
        ));
  }



  Widget biild_LoginForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.58,
            width: MediaQuery.of(context).size.width * 0.92,
            decoration: BoxDecoration(
              //border: Border.all(width: 2.0,color: Colors.black),
                color: Colors.white),
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "Login",
                    style:
                    TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 3.0, color: Color(0xFF000000)),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03)),
                Text(
                  "Enter your email and password",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015)),
                Form(
                  key: _formKey,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: username,
                          //cursorHeight: 35.0,
                          validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal)),
                              hintText: "Username",
                              prefixIcon: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child:Icon(Icons.email)
                              )),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.04)),

                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return ' Please enter valid Password';
                            }
                            return null;
                          },
                          controller: password,
                          // cursorHeight: 35.0,obscureText: !_passwordVisible,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal)),
                              hintText: "Password",
                              suffixIcon: GestureDetector(
                                onLongPress: () {
                                  setState(() {
                                    _passwordVisible = true;
                                  });
                                },
                                onLongPressUp: () {
                                  setState(() {
                                    _passwordVisible = false;
                                  });
                                },
                                child: Icon(
                                    _passwordVisible ? Icons.visibility : Icons.visibility_off),
                              ),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child:Icon(Icons.lock)
                              )),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () {
                              setState(() {
                                var isvalid = _formKey.currentState.validate();
                                if(!isvalid){
                                  return ;
                                }else{
                                  _loaddata(context);
                                  loadDataFromApi();

                                }
                              });
                        },
                        color: const Color(0xff303e9f),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: "New Registration ?",
                            style: TextStyle(
                              color: const Color(0xff303e9f),
                            ),
                          recognizer: TapGestureRecognizer()..onTap=(){
                           setState(() {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>registration_screen()));
                           });
                          }
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

   loadDataFromApi()async {
    var api_Provider=home_screen_provider();
    await api_Provider.getAllData();
   }

   _loaddata(BuildContext context)async {
     if(username.text !="" && password.text !=""){
       var database=Registration_database();
       registration test=await database.checkLogin(username.text, password.text);
       Navigator.push(context, MaterialPageRoute(builder: (context)=>home_screen()));
     }
     else{
       print("Error");
     }
   }


}
