import 'package:new_version_plus/new_version_plus.dart';
import 'package:tourstravels/Splash.dart';
import 'package:flutter/material.dart';
// import 'package:tourstravels/Dashboard.dart';
// import 'package:tourstravels/Properties.dart';
//import 'package:tourstravels/Splash.dart';
import 'package:tourstravels/Splash.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'ABISINIYA',
      home: Splashscreen(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _selectedScreenIndex = 0;
  // final List _screens = [
  //   {"screen":  Dashboard(), "title": "Screen A Title"},
  //   {"screen": const ScreenB(), "title": "Screen B Title"},
  //    {"screen": const Vehiclescreen(), "title": "Vehicle C Title"},
  //    //{"screen": const FlightScreen(), "title": "Flights D Title"}
  // ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  void initState() {
    super.initState();
    print('calling version app.....');

    // Instantiate NewVersion manager object (Using GCP Console app as example)
  //   final newVersion = NewVersionPlus(
  //     //iOSId: 'com.disney.disneyplus',
  //     androidId: 'com.Abisiniya', androidPlayStoreCountry: "es_ES", androidHtmlReleaseNotes: true, //support country code
  //   );
  //
  //   // You can let the plugin handle fetching the status and showing a dialog,
  //   // or you can fetch the status and display your own dialog, or no dialog.
  //   final ver = VersionStatus(
  //     appStoreLink: '',
  //     localVersion: '',
  //     storeVersion: '',
  //     releaseNotes: '',
  //     originalStoreVersion: '',
  //   );
  //   print(ver);
  //   const simpleBehavior = true;
  //
  //   // if (simpleBehavior) {
  //   basicStatusCheck(newVersion);
  //   // }
  //   // else {
  //   // advancedStatusCheck(newVersion);
  //   // }
  // }
  //
  // basicStatusCheck(NewVersionPlus newVersion) async {
  //   final version = await newVersion.getVersionStatus();
  //   if (version != null) {
  //     var release = version.releaseNotes ?? "";
  //     setState(() {});
  //   }
  //   newVersion.showAlertIfNecessary(
  //     context: context,
  //     launchModeVersion: LaunchModeVersion.external,
  //   );
  }


  void _checkVersion()async{
    print('checking app version........');
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
      print('suc...');
      //newVersion.showUpdateDialog(


      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status!,
        allowDismissal: false,
        dialogTitle: "UPDATE",
        dialogText: "Please update the app from ${status.localVersion} to ${status.storeVersion}",
      );
    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
        leading: Padding(
       // padding: const EdgeInsets.all(0.0),
          padding: EdgeInsets.only(left: 10.0, top: 0.0),
          child: Image.asset(
    "images/logo.jpg",
    ),),
          title: Text('ABISINIYA',textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.bold,fontSize: 16)),),
    );
  }
}