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



class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String tokenvalue = '';

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () async{
        Navigator.of(context, rootNavigator: true).pop();
        await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => newuserDashboard()));
    setState((){
      //Navigator.pop(context);
    });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Abisiniya",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24,color: Colors.green),),
      content: Text("Do you want Login?",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.black54),),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void login(String email , password) async {

    try{

      // isLoading = true;
      // var response = await http.get(url);
      // isLoading = false;
      print('login url...');
      print(baseDioSingleton.AbisiniyaBaseurl +'login');
      Response response = await post(
          //Uri.parse('https://staging.abisiniya.com/api/v1/login'),
          Uri.parse(baseDioSingleton.AbisiniyaBaseurl +'login'),



          body: {
            'email' : emailController.text.toString(),
            'password' : passwordController.text.toString()
          }

      );

      isLoading = true;
      if(response.statusCode == 200){
        isLoading = false;
        print('success api response');
        var data = jsonDecode(response.body.toString());
        var data1 = jsonDecode(response.body.toString());
        print(data1['data']);
        print(data1['data']['token']);
        tokenvalue = (data1['data']['token']);
        String namestr = (data1['data']['name']);
        print('token value....');
        print(tokenvalue);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('tokenkey', tokenvalue);



        //
        //
        // var datar = jsonDecode(response.body['data']['token']);
        //
        // json.encode(response.body['data'['token']]);
        //
        // //SharedPreferences localStorage = await SharedPreferences.getInstance();
        // //localStorage.setString('token', json.encode(body['data']['token']));
        //
        // //localStorage.setString('data', json.encode(body['data']));

        showAlertDialog(context);
        //
        // print(data);
        // print(data['token']);
        // print('Login successfully');
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => newuserDashboard()
        //   ),
        // );

      }else {
        print('failed');


        final snackBar = SnackBar(
          content: Text('Hi, Invalid login credentials'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }catch(e){
      print(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(
        //   backgroundColor: PrimaryColor,
        //
        //   centerTitle: true,
        //   title: Text('Login',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18,),),
        // ),

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
            // TextButton(
            //   onPressed: () async {
            //
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => ServiceDashboardScreen()
            //       ),
            //     );
            //     SharedPreferences prefs = await SharedPreferences.getInstance();
            //     // prefs.setString('logoutkey', ('LogoutDashboard'));
            //     //prefs.setString('Property_type', ('Apartment'));
            //     prefs.setString('NewuserBookingkey', 'NewuserBooking');
            //
            //   },
            //   child: Text('New Booking',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.green),),
            // ),
          ],
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.white
          ),
            title: Text('ABISINIYA',textAlign: TextAlign.center,
                style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

        ),

      // title: Text('ABISINIYA',textAlign: TextAlign.center,
      //     style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
      // iconTheme: IconThemeData(color: Colors.green),),


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
                                      color: Colors.grey,
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
                                    "Welcome Back",
                                    textAlign: TextAlign.center ,
                                    style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26),),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(00.0),
                                      padding: EdgeInsets.only(top: 05.0,
                                          left: 15.0,
                                          right: 05.0),
                                      //color: Colors.white30,
                                      color: Colors.white,
                                      width: 300.0,
                                      height: 40.0,
                                      child: TextField(
                                        controller: emailController,
                                          textAlign: TextAlign.left,
                                          autocorrect: false,
                                          decoration:
                                          //disable single line border below the text field

                                          new InputDecoration.collapsed(
                                              hintText: 'Email/Phone number')),
                                    ),

                                    SizedBox(height: 10,),
                                    Container(
                                      margin: const EdgeInsets.all(00.0),
                                      padding: EdgeInsets.only(top: 05.0,
                                          left: 15.0,
                                          right: 05.0),
                                      //color: Colors.white30,
                                      color: Colors.white,
                                      width: 300.0,
                                      height: 40.0,
                                      child: TextField(
                                        obscureText: true,
                                        controller: passwordController,
                                          textAlign: TextAlign.left,
                                          autocorrect: false,
                                          decoration:
                                          //disable single line border below the text field
                                          new InputDecoration.collapsed(
                                              hintText: 'Password')),
                                    ),


                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child:isLoading
                                          ? Center(child: CircularProgressIndicator())
                                          : TextButton(
                                        style: TextButton.styleFrom(
                                                fixedSize: const Size(300, 45),
                                                foregroundColor: Colors.white,
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(00),
                                                ),
                                                textStyle: const TextStyle(fontSize: 20)),
                                        // child: Text('Book Now'),

                                        child: const Text('Login',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

                                        onPressed: () async {
                                          setState(() => isLoading = true);
                                         // _postData();
                                                login(emailController.text.toString(), passwordController.text.toString());

                                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                                prefs.setString('emailkey', emailController.text);
                                                prefs.setString('passwordkey', passwordController.text);



                                          print('token value....');
                                                print(tokenvalue);
                                                prefs.setString('tokenkey', tokenvalue);




                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) => tabbar()
                                              //   ),
                                              // );


                                          await Future.delayed(Duration(seconds: 2), () => () {});
                                          setState(() => isLoading = false);
                                        },
                                      ),
                                    ),



                                    // TextButton(
                                    //   style: TextButton.styleFrom(
                                    //       fixedSize: const Size(300, 45),
                                    //       foregroundColor: Colors.white,
                                    //       backgroundColor: Colors.green,
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(00),
                                    //       ),
                                    //       textStyle: const TextStyle(fontSize: 20)),
                                    //   onPressed: () async {
                                    //
                                    //       login(emailController.text.toString(), passwordController.text.toString());
                                    //
                                    //       SharedPreferences prefs = await SharedPreferences.getInstance();
                                    //       prefs.setString('emailkey', emailController.text);
                                    //       prefs.setString('passwordkey', passwordController.text);
                                    //
                                    //       // print('token value....');
                                    //       // print(tokenvalue);
                                    //       // prefs.setString('tokenkey', tokenvalue);
                                    //
                                    //
                                    //
                                    //
                                    //     // Navigator.push(
                                    //     //   context,
                                    //     //   MaterialPageRoute(
                                    //     //       builder: (context) => tabbar()
                                    //     //   ),
                                    //     // );
                                    //   },
                                    //   child: const Text('Login',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
                                    // ),


                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Text("New to this site?",
                                          style: TextStyle(color: Colors.black87,fontSize: 14),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                fixedSize: const Size(180, 40),
                                                foregroundColor: Colors.green,
                                                backgroundColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(00),
                                                ),
                                                textStyle: const TextStyle(fontSize: 16)),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Register()
                                                ),
                                              );
                                            },
                                            child: const Text('Create New Account'),

                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            fixedSize: const Size(180, 40),
                                            foregroundColor: Colors.redAccent,
                                            backgroundColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(00),
                                            ),
                                            textStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                                        onPressed: () {

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ForgotpwdOTPVerified()
                                            ),
                                          );
                                        },
                                        child: const Text('Forgot password'),

                                      )
                                    ),
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