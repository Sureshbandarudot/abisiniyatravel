//import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:tourstravels/Auth/ForgotPassword.dart';
import 'package:tourstravels/Auth/OtpEmailverified.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'package:tourstravels/Auth/forgotpwdemailVerify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import 'package:tourstravels/tabbar.dart';
class Register extends StatefulWidget {
   String registerinputemailData = '';
  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  String _email = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpwdController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = prefs.getString('emailkey') ?? "";
      print(emailController.text);
      //ageController.text = prefs.getString('age') ?? "";
      //print(ageController.text);
    });
  }
  @override
  void initState() {
    super.initState();
    _retrieveValues();
  }
  void RegisterAPI(String name , surname , email , password , password_confirmation , phone) async {
    try{
      Response response = await post(
          Uri.parse(baseDioSingleton.AbisiniyaBaseurl + 'myregister'),
          body: {
            'name' : nameController.text.toString(),
            'surname' : surnameController.text.toString(),
            'email' : emailController.text.toString(),
            'password' : passwordController.text.toString(),
            'password_confirmation' : confirmpwdController.text.toString(),
            'phone' : phoneController.text.toString(),
          });
      print('sts code...');
      print(response.statusCode);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print('response data');
        print(data);
        var data1 = jsonDecode(response.body.toString());
        print(data1['message']);
        bool successMsg = true;
        if (successMsg == (data1['success'])){
          String inputemailData = emailController.text.toString();
          print('Go to Email or OTP verification screen');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPVerified(),
              settings: RouteSettings(arguments: inputemailData),
            ),
          );
        }
        print(data);
        print(data['token']);
        print('Register  successfully');
      }

      if (response.statusCode == 400) {
        var data1 = jsonDecode(response.body);
        print('valid response data1');
        print(data1);
        print(data1['message']['email']);
        if (nameController.text.isEmpty) {
          final snackBar = SnackBar(
            content: Text('Please Fll firstname'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (surnameController.text.isEmpty) {
          final snackBar = SnackBar(
            content: Text('Please Fill surname'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if (phoneController.text.isEmpty) {
          final snackBar = SnackBar(
            content: Text('Please Fill Mobile number'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (emailController.text.isEmpty) {
          final snackBar = SnackBar(
            content: Text('Please Fill Email'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (passwordController.text.isEmpty) {
          final snackBar = SnackBar(
            content: Text('Please Fill password'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (confirmpwdController.text.isEmpty) {
          final snackBar = SnackBar(
            content: Text('Please Fill password confirmation'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if ((data1['message']['phone']) != null && (data1['message']['email']) != null) {
         // showAlertDialog(context);
          final snackBar = SnackBar(
            content: Text('The email and phone has already been taken.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if ((data1['message']['phone']) != null) {
          final snackBar = SnackBar(
            content: Text('The phone has already been taken.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //Phonenumber_showAlertDialog(context);


        } else if ((data1['message']['email']) != null) {
          //Email_showAlertDialog(context);

          final snackBar = SnackBar(
            content: Text('The  email has already been taken.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if ((data1['message']['password']) != null) {
          final snackBar = SnackBar(
            content: Text('The password confirmation does not match.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
        else {
        print('failed');
        print('validations123....');
        var data = jsonDecode(response.body.toString());
        print('response data');
        print(data);
        var data2 = jsonDecode(response.body);
        print('response data2');
        print(data2);

        final snackBar = SnackBar(
          content: Text('Please Fill All Fields or Make sure enter new details and please try again...'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }catch(e){
      print(e.toString());
    }
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

          title: const Text('Registration',
              textAlign: TextAlign.center,
              style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
        ),
        body: Column(
          children: <Widget>[
            Container(color: Colors.white, height: 30),
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
                                  height: 650.0,
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
                                        "Create Your Account",
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
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            controller: nameController,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Firstname')),
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
                                          controller: surnameController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Lastname')),
                                      ),
                                      SizedBox(
                                        height: 10,
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
                                            keyboardType: TextInputType.number,

                                            controller: phoneController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Mobile number')),
                                      ),
                                      SizedBox(
                                        height: 10,
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
                                                hintText: 'E-mail')),
                                      ),

                                      SizedBox(
                                        height: 10,
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
                                        height: 10,
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
                                          obscureText: true,
                                          controller: confirmpwdController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Confirm Password')),
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
                                          print('email.....');
                                          print(emailController.text);
                                          print(emailController.text.toString());
                                          RegisterAPI(nameController.text.toString(), surnameController.text.toString(), emailController.text.toString(), passwordController.text.toString(),confirmpwdController.text.toString(),phoneController.text.toString());
                                          await Future.delayed(Duration(seconds: 2), () => () {});
                                          setState(() => isLoading = false);
                                        },
                                        //child: const Text('Register'),
                                        child: const Text('Register',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Text("Already have an account?",
                                              style: TextStyle(color: Colors.black87,fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                  fixedSize: const Size(90, 40),
                                                  foregroundColor: Colors.green,
                                                  backgroundColor: Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(00),
                                                  ),
                                                  textStyle: const TextStyle(fontSize: 20)),
                                              onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Login()),
                                                  );
                                              },
                                              child: const Text('Login'),
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