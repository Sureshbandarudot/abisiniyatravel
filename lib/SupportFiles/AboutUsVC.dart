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
class AboutUsScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<AboutUsScreen> {
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
          title: Text('ABISINIYA',textAlign: TextAlign.center,
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
                                  height: 350.0,
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
                                        "About US",
                                        textAlign: TextAlign.center ,
                                        style: TextStyle(
                                            color: Colors.green,fontWeight: FontWeight.bold,fontSize: 26),),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text('We pride ourselves on our outstanding customer service.Let us take you across the world in easier and affordable ways.',
                                        textAlign: TextAlign.center ,
                                        style: TextStyle(
                                            color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),)
                                      // Container(
                                      //   margin: const EdgeInsets.all(00.0),
                                      //   padding: EdgeInsets.only(top: 05.0,
                                      //       left: 15.0,
                                      //       right: 05.0),
                                      //   //color: Colors.white30,
                                      //   color: Colors.white,
                                      //   width: 300.0,
                                      //   height: 40.0,
                                      //   child: TextField(
                                      //       controller: emailController,
                                      //       textAlign: TextAlign.left,
                                      //       autocorrect: false,
                                      //       decoration:
                                      //       //disable single line border below the text field
                                      //
                                      //       new InputDecoration.collapsed(
                                      //           hintText: 'Email/Phone number')),
                                      // ),
                                      //
                                      // SizedBox(height: 10,),
                                      // Container(
                                      //   margin: const EdgeInsets.all(00.0),
                                      //   padding: EdgeInsets.only(top: 05.0,
                                      //       left: 15.0,
                                      //       right: 05.0),
                                      //   //color: Colors.white30,
                                      //   color: Colors.white,
                                      //   width: 300.0,
                                      //   height: 40.0,
                                      //   child: TextField(
                                      //       obscureText: true,
                                      //       controller: passwordController,
                                      //       textAlign: TextAlign.left,
                                      //       autocorrect: false,
                                      //       decoration:
                                      //       //disable single line border below the text field
                                      //       new InputDecoration.collapsed(
                                      //           hintText: 'Password')),
                                      // ),
                                      //
                                      //
                                      // SizedBox(
                                      //   height: 15,
                                      // ),
                                      // Container(
                                      //   child:isLoading
                                      //       ? Center(child: CircularProgressIndicator())
                                      //       : TextButton(
                                      //     style: TextButton.styleFrom(
                                      //         fixedSize: const Size(300, 45),
                                      //         foregroundColor: Colors.white,
                                      //         backgroundColor: Colors.green,
                                      //         shape: RoundedRectangleBorder(
                                      //           borderRadius: BorderRadius.circular(00),
                                      //         ),
                                      //         textStyle: const TextStyle(fontSize: 20)),
                                      //     // child: Text('Book Now'),
                                      //
                                      //     child: const Text('Login',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
                                      //
                                      //     onPressed: () async {
                                      //       setState(() => isLoading = true);
                                      //       // _postData();
                                      //       //login(emailController.text.toString(), passwordController.text.toString());
                                      //
                                      //       SharedPreferences prefs = await SharedPreferences.getInstance();
                                      //       prefs.setString('emailkey', emailController.text);
                                      //       prefs.setString('passwordkey', passwordController.text);
                                      //       print('token value....');
                                      //       print(tokenvalue);
                                      //       prefs.setString('tokenkey', tokenvalue);
                                      //       await Future.delayed(Duration(seconds: 2), () => () {});
                                      //       setState(() => isLoading = false);
                                      //     },
                                      //   ),
                                      // ),
                                    ],
                                  )
                              ),
                              // middle widget goes here
                              Expanded(
                                child: Container(),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // Icon(Icons.star),
                                    // Text("Bottom Text")
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