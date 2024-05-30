
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:tourstravels/Auth/ForgotPassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
class ForgotpwdOTPVerified extends StatefulWidget {
  @override
  _ForgotpwdOTPVerifiedState createState() => _ForgotpwdOTPVerifiedState();
}

class _ForgotpwdOTPVerifiedState extends State<ForgotpwdOTPVerified> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  void OTPVerified(String email) async {
    try{
      Response response = await post(
          // Uri.parse('https://staging.abisiniya.com/api/v1/forgotpass/emailverify'),
          Uri.parse(baseDioSingleton.AbisiniyaBaseurl + 'forgotpass/emailverify'),
          body: {
            'email' : emailController.text.toString(),
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
               print(data);
        print(data['token']);
        print('email verified successfully');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Forgot()
          ),
        );
      }else {
        print('failed');
        final snackBar = SnackBar(
          content: Text('The email confirmation does not match.'),
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
  }
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
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.white

          ),

          title: const Text('Forgot Password',
              textAlign: TextAlign.center,
              style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
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
                                  height: 310.0,
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
                                        height: 250,
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
                                                print('forgot password...');
                                                print(emailController.text);

                                                OTPVerified(emailController.text.toString());
                                                  await Future.delayed(Duration(seconds: 2), () => () {});
                                                  setState(() => isLoading = false);
                                              },
                                              //child: const Text('Verified'),
                                              child: const Text('Verify',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
                                            ),
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
}