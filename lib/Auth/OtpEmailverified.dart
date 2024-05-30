import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import '../ServiceDasboardVC.dart';
import 'dart:async';
import '../UserDashboard_Screens/newDashboard.dart';
import 'Register.dart';
import 'otpResendVC.dart';

String _email='';
class OTPVerified extends StatefulWidget {
  @override
  _OTPVerifiedState createState() => _OTPVerifiedState();
}
class _OTPVerifiedState extends State<OTPVerified> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  String? emaildata;
  final globalKey = GlobalKey<ScaffoldState>();
  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  void OTPVerified(String email , String otp ) async {
    try{
      Response response = await post(
          //Uri.parse('https://staging.abisiniya.com/api/v1/otpverify'),
          Uri.parse(baseDioSingleton.AbisiniyaBaseurl + 'otpverify'),
          body: {
            'email' : emailController.text.toString(),
            'otp' : otpController.text.toString(),
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print(data['token']);
        print('Login successfully');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Login()
          ),
        );

      } else if(response.statusCode == 404){
        final snackBar = SnackBar(
          content: Text('User Already Verified.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else {
        print('failed');

        final snackBar = SnackBar(
          content: Text('The otp confirmation does not match.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = prefs.getString('emailkey') ?? "";
      print(emailController.text);

    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveValues();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
          //print('clicked resend otp btn....');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => ResendOTPScreen()
          //   ),
          // );
        });
      }
    });
  }
  Widget build(BuildContext context) {
    //emaildata = ModalRoute.of(context)?.settings.arguments as String?;
    print('inside widget....');
    print(emailController.text);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(
            onPressed: () async{
              print("back Pressed");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              // prefs.setString('logoutkey', ('LogoutDashboard'));
              //prefs.setString('Property_type', ('Apartment'));
              //prefs.setString('LoggedinUserkey', LoggedInUser);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Register()),
              );

            },
          ),
          title: Text('OTP Email Verification',textAlign: TextAlign.center,
              style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

        ),
        body: Column(
          children: <Widget>[
            Container(color: Colors.white, height: 100),
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
                                  height: 375.0,
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
                                        padding: EdgeInsets.all(10),
                                        height: 50,
                                        width: 325,
                                        color: Colors.transparent,
                                        child: Text(
                                          "Email or OTP Verification",
                                          textAlign: TextAlign.left ,
                                          style: TextStyle(
                                              color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 22),),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        width: 325,
                                        height: 315,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            TextField (
                                              readOnly: true,
                                              controller: emailController,
                                              decoration: InputDecoration(
                                                  border:OutlineInputBorder(),
                                                  labelText: 'Email',
                                                  hintText: 'Email'
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextField (
                                              obscureText: true,
                                              controller: otpController,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                  border:OutlineInputBorder(),
                                                  labelText: 'otp',
                                                  hintText: 'otp'
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),

                                            TextButton(
                                              style: TextButton.styleFrom(
                                                  fixedSize: const Size(300, 45),
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: Colors.green,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(00),
                                                  ),
                                                  textStyle: const TextStyle(fontSize: 20)),
                                             // onPressed: () {
                                                onPressed: () async {

                                                  setState(() => isLoading = true);
                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                prefs.setString('emailkey', emailController.text);
                                                print(emailController.text);
                                                OTPVerified(emailController.text.toString(), otpController.text.toString());
                                                  await Future.delayed(Duration(seconds: 2), () => () {});
                                                  setState(() => isLoading = false);
                                                },
                                              //child: const Text('Verified'),
                                              child: const Text('Verify',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                 children: [
                                                   Text(
                                                     ' $secondsRemaining ',
                                                     style: TextStyle(color: Colors.red, fontSize: 18),
                                                   ),
                                                   SizedBox(
                                                     width: 100,
                                                   ),

                                                   TextButton(
                                                     style: TextButton.styleFrom(
                                                         fixedSize: const Size(150, 18),
                                                         foregroundColor: Colors.green,
                                                         backgroundColor: Colors.white,
                                                         shape: RoundedRectangleBorder(
                                                           borderRadius: BorderRadius.circular(00),
                                                         ),
                                                         textStyle: const TextStyle(fontSize: 18)),
                                                     child: Text('Resend OTP'),
                                                     onPressed: enableResend ? _resendCode : null,

                                                     // child: const Text('Resend',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
                                                   ),
                                                 ],

                                                )
                                              ],
                                            )
                                          ],
                                        ),

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

  void _resendCode() {
    //other code here
    setState((){
      secondsRemaining = 60;
      enableResend = false;
      print('click.....');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResendOTPScreen()
        ),
      );
    });
  }

  @override
  dispose(){
    timer.cancel();
    super.dispose();
  }
}
