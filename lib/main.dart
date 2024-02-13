import 'package:tourstravels/Splash.dart';
import 'package:flutter/material.dart';
// import 'package:tourstravels/Dashboard.dart';
// import 'package:tourstravels/Properties.dart';
//import 'package:tourstravels/Splash.dart';
import 'package:tourstravels/Splash.dart';
// /*import 'package:tourstravels/Vehicles.dart';
// import 'package:tourstravels/Login.dart';
// import 'package:tourstravels/Flights.dart';
// import 'package:tourstravels/Splash.dart';


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
      // endDrawer: Drawer(
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      //         child: Image.asset(
      //           'images/logo.jpg',
      //           width: 50,height: 50,
      //         ),
      //       ),
      //       ListTile(
      //         trailing: Icon(
      //           Icons.login,
      //         ),
      //         title: const Text('Regester/Login',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => Login()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         trailing: Icon(
      //           Icons.flight,
      //         ),
      //         title: const Text('Flights',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18)),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         trailing: Icon(
      //           Icons.apartment,
      //         ),
      //         title: const Text('Apartments',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18)),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         trailing: Icon(
      //           Icons.car_rental,
      //         ),
      //         title: const Text('Vehicle',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18)),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         trailing: Icon(
      //           Icons.airport_shuttle,
      //         ),
      //         title: const Text('Airport Shuttle',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18)),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         trailing: Icon(
      //           Icons.car_repair_sharp,
      //         ),
      //         title: const Text('List Property and Car',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18)),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         trailing: Icon(
      //           Icons.contact_page,
      //         ),
      //         title: const Text('Contact Us',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18)),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         trailing: Icon(
      //           Icons.logout,
      //         ),
      //         title: const Text('Sign Out',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 20)),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      //body: _screens[_selectedScreenIndex]["screen"],
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedScreenIndex,
      //   onTap: _selectScreen,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     //BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Properties"),
      //      BottomNavigationBarItem(icon: Icon(Icons.apartment), label: 'Apartments'),
      //      BottomNavigationBarItem(icon: Icon(Icons.flight), label: "Flights")
      //   ],
      //),
    );
  }
}