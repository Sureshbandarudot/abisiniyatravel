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
import 'package:http/http.dart' as http;



import 'package:tourstravels/tabbar.dart';

import '../UserDashboard_Screens/newDashboard.dart';

class profileUpdatescreen extends StatefulWidget {

  String registerinputemailData = '';
  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<profileUpdatescreen> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  String profileNamestr = '';
  String Retrivedprofilestr = '';
  String profileEmail = '';
  String RetrivedEmailstr = '';
  String RetrivedBearertoekn = '';
  String _email = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // emailController.text = prefs.getString('emailkey') ?? "";
      print(emailController.text);
      setState(() {
        RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
        print('booking token...');
        print(RetrivedBearertoekn);
        Retrivedprofilestr = prefs.getString('profileuserKey') ?? "";
        RetrivedEmailstr = prefs.getString('profileemailKey') ?? "";
        prefs.setString('Property_type', ('Apartment'));
        nameController.text = prefs.getString('profilenamekey') ?? "";
        surnameController.text = prefs.getString('profilesurnamekey') ?? "";
        emailController.text = prefs.getString('profile_emailkey') ?? "";
        phoneController.text = prefs.getString('profilephonekey') ?? "";
        addressController.text = prefs.getString('profile_addresskey') ?? "";
        countryController.text = prefs.getString('profile_countrykey') ?? "";

      });
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveValues();
  }

  Future<dynamic> Profile() async {
    // String url = 'https://staging.abisiniya.com/api/v1/booking/vehicle/withbooking';
    String url = baseDioSingleton.AbisiniyaBaseurl + 'profile';
    print('profile url..');
    print(url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
    print('profile token...');
    print(RetrivedBearertoekn);
    var response = await http.get(
      Uri.parse(
          url),
      headers: {
        "Authorization": "Bearer $RetrivedBearertoekn",
      },
    );
    if (response.statusCode == 200) {
      print('profile name .......');
      final data1 = jsonDecode(response.body);
      var getpicsData = [];
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  void profileUpdate(String name , surname , email , address , country , phone) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      print(RetrivedBearertoekn);
      String apiUrl = baseDioSingleton.AbisiniyaBaseurl + 'profileupdate';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $RetrivedBearertoekn",
        },
        body: jsonEncode(<String, dynamic>{
          'name' : nameController.text,
          'surname' : surnameController.text,
          'email' : emailController.text,
          'address' : addressController.text,
          'country' : countryController.text,
          'phone' : phoneController.text,
          // Add any other data you want to send in the body
        }),
      );
      print('status...');
      print(response.statusCode);
      print(nameController.text.toString());
      print(countryController.text.toString());
      print(addressController.text);
      print(phoneController.text);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print('response data');
        print(data);
        var data1 = jsonDecode(response.body.toString());
        print(data1['message']);
        bool successMsg = true;
        if (successMsg == (data1['status'])){
          String inputemailData = emailController.text.toString();
          print('Go to Email or OTP verification screen');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => newuserDashboard()
            ),
          );
        }
        print(data);
        print(data['token']);
        print('Register  successfully');
      }else if (response.statusCode == 400) {
        var data1 = jsonDecode(response.body);
        print('valid response data1');
        print(data1);
        print(data1['message']['email']);
        if(data1['message']['email'] != null && data1['message']['phone'] != null && data1['message']['password'] != null  ){
          print('email valid...');
          final snackBar = SnackBar(
            content: Text('email,phone has already been taken and password confirmation does not match'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }   else if(data1['message']['email'] != null && data1['message']['phone'] == null && data1['message']['password'] != null  ){
          print('email valid...');
          final snackBar = SnackBar(
            content: Text('email has already been taken and password confirmation does not match'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if(data1['message']['email'] == null && data1['message']['phone'] != null){
          print('email valid...');
          final snackBar = SnackBar(
            content: Text('phone has already been taken and password confirmation does not match'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }else if(data1['message']['email'] == null && data1['message']['phone'] == null){
          print('email valid...');
          final snackBar = SnackBar(
            content: Text('email , phone has already been taken '),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if(data1['message']['email'] != null){
          print('email valid...');
          final snackBar = SnackBar(
            content: Text('email has already been taken '),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }else if(data1['message']['phone'] != null){
          print('email valid...');
          final snackBar = SnackBar(
            content: Text('phone has already been taken '),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }else if(data1['message']['password'] != null){
          print('email valid...');
          final snackBar = SnackBar(
            content: Text('password confirmation does not match '),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }


      }
      else {
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

          title: const Text('Profile',
              textAlign: TextAlign.center,
              style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
    // backgroundColor: Colors.grey,
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
                                        "Profile Update",
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
                                            //obscureText: true,
                                            controller: addressController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Address')),
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
                                           // obscureText: true,
                                            controller: countryController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Country')),
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
                                        //onPressed: () {

                                        onPressed: () async {
                                          setState(() => isLoading = true);
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          prefs.setString('emailkey', emailController.text);
                                          print('email.....');
                                          print(emailController.text);
                                          print(emailController.text.toString());
                                          profileUpdate(nameController.text.toString(), surnameController.text.toString(), emailController.text.toString(), addressController.text.toString(),countryController.text.toString(),phoneController.text.toString());
                                          await Future.delayed(Duration(seconds: 2), () => () {});
                                          setState(() => isLoading = false);
                                        },
                                        //child: const Text('Register'),
                                        child: const Text('Update',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
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