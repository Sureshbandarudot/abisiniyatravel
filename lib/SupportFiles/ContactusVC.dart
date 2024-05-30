import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:tourstravels/Auth/ForgotPassword.dart';
import 'package:tourstravels/Auth/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:tourstravels/shared_preferences.dart';
import 'package:tourstravels/Auth/forgotpwdemailVerify.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/UserDashboard_Screens/newDashboard.dart';

import '../ApartVC/Apartment.dart';
import '../ServiceDasboardVC.dart';
class ContactUsScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<ContactUsScreen> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String tokenvalue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.white, Colors.green]),
            ),
          ),
          actions: <Widget>[
          ],
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          title: Text('Contact US',textAlign: TextAlign.center,
              style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

        ),
        body: Column(
          children: <Widget>[
            Container(color: Colors.white, height: 50),
            Expanded(
              child: Container(
                color: Colors.white,
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              Container(
                                  height: 450.0,
                                  width: 325.0,
                                  decoration: const BoxDecoration(
                                    //color: Color(0xFFffffff),
                                    color: Colors.white70,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blueGrey,
                                        blurRadius: 15.0, // soften the shadow
                                        spreadRadius: 5.0, //extend the shadow
                                        offset: Offset(
                                          5.0, // Move to right 5  horizontally
                                          5.0, // Move to bottom 5 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 125,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 60.0,
                                            child: Image.asset(
                                                "images/logo2.png",
                                                height: 100.0,
                                                width: 125.0,
                                                fit: BoxFit.fill
                                            ),
                                          )
                                      ),
                                      Text(
                                        "Zimbabwe",
                                        textAlign: TextAlign.center ,
                                        style: TextStyle(
                                            color: Colors.green,fontWeight: FontWeight.bold,fontSize: 26),),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(

                                        children: [
                                          Text(
                                            "  Phone:-",
                                            textAlign: TextAlign.center ,
                                            style: TextStyle(
                                                color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18),),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text('+263 777 223 158',  style: TextStyle(
                                              color: Colors.black54,fontWeight: FontWeight.normal,fontSize: 16),),
                                        ],
                                      ),


                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "  Address:-",
                                            textAlign: TextAlign.center ,
                                            style: TextStyle(
                                                color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18),),
                                          SizedBox(
                                            width: 0,
                                          ),
                                          Text('Cnr Prince,' '\n''Edward and Lezard,' '\n' 'Milton park',  style: TextStyle(
                                              color: Colors.black54,fontWeight: FontWeight.normal,fontSize: 16),),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "  Location:-",
                                            textAlign: TextAlign.center ,
                                            style: TextStyle(
                                                color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18),),
                                          SizedBox(
                                            width: 0,
                                          ),
                                          Text('Harare, Zimbabwe',  style: TextStyle(
                                              color: Colors.black54,fontWeight: FontWeight.normal,fontSize: 16),),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "  Email:-",
                                            textAlign: TextAlign.center ,
                                            style: TextStyle(
                                                color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18),),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text('info@abisiniya.com',  style: TextStyle(
                                              color: Colors.black54,fontWeight: FontWeight.normal,fontSize: 16),),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "  Web:-",
                                            textAlign: TextAlign.center ,
                                            style: TextStyle(
                                                color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 20),),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text('www.abisiniya.com',  style: TextStyle(
                                              color: Colors.black54,fontWeight: FontWeight.normal,fontSize: 16),),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                              // middle widget goes here
                              Expanded(
                                child: Container(),
                              ),
                              SizedBox(height: 50,),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      height: 300.0,
                                      width: 325.0,
                                      decoration: const BoxDecoration(
                                        //color: Color(0xFFffffff),
                                        color: Colors.white70,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blueGrey,
                                            blurRadius: 15.0, // soften the shadow
                                            spreadRadius: 5.0, //extend the shadow
                                            offset: Offset(
                                              5.0, // Move to right 5  horizontally
                                              5.0, // Move to bottom 5 Vertically
                                            ),
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "South Africa",
                                            textAlign: TextAlign.center ,
                                            style: TextStyle(
                                                color: Colors.green,fontWeight: FontWeight.bold,fontSize: 26),),
                                              Row(

                                                children: [
                                                  Text(
                                                    "  Phone:-",
                                                    textAlign: TextAlign.center ,
                                                    style: TextStyle(
                                                        color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18),),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('+27 65 532 6408',  style: TextStyle(
                                                      color: Colors.black54,fontWeight: FontWeight.normal,fontSize: 16),),
                                                ],
                                              ),


                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "  Loc:-",
                                                textAlign: TextAlign.center ,
                                                style: TextStyle(
                                                    color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18),),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Text('Add 28 Mint Road,' '\n''3rd Floor, Fordsburg,' '\n' 'Johannesburg,' '\n''South Africa',  style: TextStyle(
                                                  color: Colors.black54,fontWeight: FontWeight.normal,fontSize: 16),),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "  Email:-",
                                                textAlign: TextAlign.center ,
                                                style: TextStyle(
                                                    color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18),),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text('info@abisiniya.com',  style: TextStyle(
                                                  color: Colors.black54,fontWeight: FontWeight.normal,fontSize: 16),),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "  Web:-",
                                                textAlign: TextAlign.center ,
                                                style: TextStyle(
                                                    color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18),),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text('www.abisiniya.com',  style: TextStyle(
                                                  color: Colors.black54,fontWeight: FontWeight.normal,fontSize: 16),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
    );
  }
}