import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import '../UserDashboard_Screens/newDashboard.dart';
class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}
class _ForgotState extends State<Forgot> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  void forgot(String email , otp , password , password_confirmation) async {
    try{
      Response response = await post(
          //Uri.parse('https://staging.abisiniya.com/api/v1/forgotpass/resetpassword'),
          Uri.parse(baseDioSingleton.AbisiniyaBaseurl + 'forgotpass/resetpassword'),
          body: {
            'email' : emailController.text.toString(),
            'otp' : otpController.text.toString(),
            'password' : passwordController.text.toString(),
            'password_confirmation' : confirmpasswordController.text.toString()
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

      }else {
        print('failed');
        final snackBar = SnackBar(
          content: Text('The password confirmation does not match.'),
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
              //style: TextStyle(
                  //color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
          //backgroundColor: Colors.grey,
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
                                  height: 520.0,
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
                                          "Reset Password",
                                          textAlign: TextAlign.left ,
                                          style: TextStyle(
                                              color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 22),),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        width: 325,
                                        height: 440,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 325,
                                              color: Colors.transparent,
                                              child: Text(
                                                "E-mail Address",
                                                textAlign: TextAlign.left ,
                                                style: TextStyle(
                                                    color: Colors.black87,fontWeight: FontWeight.normal,fontSize: 18),),
                                            ),
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
                                              controller: otpController,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  border:OutlineInputBorder(),
                                                  labelText: 'otp',
                                                  hintText: 'otp'
                                              ),
                                            ),

                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextField (
                                              obscureText: true,
                                              controller: passwordController,
                                              decoration: InputDecoration(
                                                  border:OutlineInputBorder(),
                                                  labelText: 'Password',
                                                  hintText: 'Password'
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextField (
                                              obscureText: true,
                                              controller: confirmpasswordController,
                                              decoration: InputDecoration(
                                                  border:OutlineInputBorder(),
                                                  labelText: 'Confirm Password',
                                                  hintText: 'Confirm Password'
                                              ),
                                            ),

                                            SizedBox(
                                              height: 15,
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
                                            onPressed: () async {
                                              setState(() => isLoading = true);
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                                prefs.setString('emailkey', emailController.text);
                                                print('forgot password...');
                                                print(emailController.text);
                                                forgot(emailController.text.toString(),otpController.text.toString(), passwordController.text.toString(),confirmpasswordController.text.toString());
                                            await Future.delayed(Duration(seconds: 2), () => () {});
                                            setState(() => isLoading = false);
                                              },
                                              //child: const Text('Reset Password'),
                                              child: const Text('Reset Password',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
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