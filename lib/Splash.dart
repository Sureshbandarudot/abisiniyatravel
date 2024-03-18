import 'package:flutter/material.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/onboardscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserDashboard_Screens/newDashboard.dart';


class Splashscreen  extends StatefulWidget {
  const Splashscreen ({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  String Logoutstr = '';

  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Logoutstr = prefs.getString('logoutkey') ?? "";
      print('splash logout....');
      print(Logoutstr);

      // prefs.setString('logoutkey', ('Logout_Dashboard'));

    });
  }

  @override




  void initState() {
    super.initState();

   // _navigateDashboard();
    _retrieveValues();
   // GotoDashboard();
    _navigateDashboard();
  }


  GotoDashboard() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    Logoutstr = prefs.getString('logoutkey') ?? "";
    print('calling exist user..');
    print(Logoutstr);
    if (Logoutstr == 'LogoutDashboard'){
      _navigateDashboard();

      print('Exist user...');
      await Future.delayed(Duration(milliseconds: 5),() {});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>newuserDashboard()));


    } else {

      print('Fresh user...');
      await Future.delayed(Duration(milliseconds: 1500),() {});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()));

    }
  }

  _navigateDashboard() async {
    await Future.delayed(Duration(milliseconds: 10),() {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()));
  }

  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(

        child: Column(
          children: [

            // Container(
            //   padding: const EdgeInsets.all(10.0),
            //   height: 200,
            //   width: 200,
            //   decoration: BoxDecoration(
            //     color: Colors.transparent,
            //     image: DecorationImage(
            //         image: AssetImage('images/logo.jpg',),
            //         fit: BoxFit.none),
            //   ),


        //     Container(
        //       alignment: Alignment.center,
        //
        //     width: 125,
        //     child: CircleAvatar(
        //       backgroundColor: Colors.transparent,
        //       radius: 60.0,
        //       child: Image.asset(
        //           "images/logo.jpg",
        //           height: 100.0,
        //           width: 125.0,
        //           fit: BoxFit.fill
        //       ),
        //     )
        // ),


          // Container(
          // color: Colors.amber,
          // child: Image.asset(
          //              "images/logo.jpg",
          //              height: 100.0,
          //              width: 125.0,
          //              fit: BoxFit.fill
          //          ),
          //
          //   //alignment: Alignment(0, 0),
          //   alignment: Alignment.bottomCenter,
          //
          // ),
          //

            Container(
              padding: EdgeInsets.all(100),
                //width: 125,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 225.0,
                  child: Image.asset(
                      "images/logo.jpg",
                      height: 150.0,
                      width: 200.0,
                      fit: BoxFit.fill
                  ),
                )
            ),



          ],
        ),
        //child: Text('Splash screen',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
      ),
    );
  }
}

