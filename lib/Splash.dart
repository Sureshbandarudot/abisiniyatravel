import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
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
  String freshstr = '';


  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Logoutstr = prefs.getString('logoutkey') ?? "";
      //freshstr = prefs.getString('freshuserkey') ?? "";
      prefs.setString('freshuserkey', ('Newuser'));

      print('splash logout....');
      print(Logoutstr);

      // prefs.setString('logoutkey', ('Logout_Dashboard'));

    });
  }

  @override




  void initState() {
    super.initState();

    //_checkVersion();

    _retrieveValues();
    GotoDashboard();
    //_navigateDashboard();
  }




  void _checkVersion()async{
    print('checking app version...');
    // final newVersion=NewVersion(
    //   androidId: "com.snapchat.android",
    // );
    // final newVersion = NewVersionPlus(
    //   //iOSId: 'com.disney.disneyplus',
    //   androidId: 'com.snapchat.android', androidPlayStoreCountry: "es_ES", androidHtmlReleaseNotes: true, //support country code
    // );
    final newVersion = NewVersionPlus(
      androidId: "com.Abisiniya.Abisiniya",
    );
    final status = await newVersion.getVersionStatus();
    //if(status?.canUpdate==true){
    print('ver sts...');
    print(status);
    print(status?.localVersion);
    print(status?.storeVersion);

    if(status?.localVersion != status?.storeVersion) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status!,
        allowDismissal: false,
        dialogTitle: "UPDATE",
        dialogText: "Please update the Abisiniya Travel&Tourism app from ${status.storeVersion} to ${status.localVersion}",
      );

    } else {
      await Future.delayed(Duration(milliseconds: 1500),() {});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()));

    }}
  GotoDashboard() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Logoutstr = prefs.getString('logoutkey') ?? "";
    print('calling exist user..');
    print(Logoutstr);
    if (Logoutstr == 'LogoutDashboard'){
      //_navigateDashboard();
      print('Exist user...');
      await Future.delayed(Duration(milliseconds: 5),() {});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>newuserDashboard()));
    } else {
      print('Fresh user...');
      //_checkVersion();
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

