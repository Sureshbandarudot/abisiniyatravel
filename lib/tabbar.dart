import 'package:flutter/material.dart';
import 'package:tourstravels/Dashboard.dart';
import 'package:tourstravels/Properties.dart';
import 'package:tourstravels/Vehicles.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:tourstravels/flyScreens/Flights.dart';
import 'package:tourstravels/tabbar.dart';

//import 'package:tourstravels/ApartVC/apartment.dart';

import 'ApartVC/Apartment.dart';
import 'Auth/Login.dart';
void main() {
  runApp(const tabbar());
}
class tabbar extends StatelessWidget {
  const tabbar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'ABISINIYA',
      home: MyHomePage(),
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
  final List _screens = [
    {"screen":  Dashboard(), "title": "Screen A Title"},
    {"screen": const ScreenB(), "title": "Screen B Title"},
    {"screen":  Apartmentscreen(), "title": "Apartment C Title"},
    {"screen": Vehiclescreen(), "title": "Flights D Title"}
  ];
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
          padding: EdgeInsets.only(left: 15.0, top: 0.0),
          child: Image.asset(
            "images/logo.jpg",
          ),),
        title: Text('ABISINIYA',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
          iconTheme: IconThemeData(color: Colors.green),),

      endDrawer: Drawer(
        child: ListView(

          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(

              //child: Text('Categories', style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(color: Color(0xffffff
              ),),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),

              child: Image.asset(
                'images/logo2.png',
                width: 50,height: 50,
              ),
            ),
            ListTile(
              trailing: Icon(
                Icons.login,
                color: Colors.green,
              ),
              title: const Text('Register/Login',
              style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login()),
                );
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.flight,
                color: Colors.green,
              ),
              title: const Text('Flights',
                  style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w500,fontSize: 18)),


              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.apartment,
                color: Colors.green,
              ),

              title: const Text('Apartments',
                  style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w500,fontSize: 18)),

              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.car_rental,
                color: Colors.green,
              ),


              title: const Text('Vehicles',
                  style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w500,fontSize: 18)),

              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.airport_shuttle,
                color: Colors.green,
              ),
              title: const Text('Airport Shuttles',
                  style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w500,fontSize: 18)),
              //title: const Text('Airport Shuttle',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.car_repair_sharp,
                color: Colors.green,
              ),
              //title: const Text('List Property and Car',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18)),
              title: const Text('List Property and car',
                  style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w500,fontSize: 18)),

              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.contact_page,
                color: Colors.green,
              ),
              //title: const Text('Contact Us',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18)),
              title: const Text('Contact Us',
                  style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w500,fontSize: 18)),

              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.logout,
                color: Colors.green,
              ),
              //title: const Text('Sign Out',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 20)),
              // title: const Text('Logout',
              //     style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

              //onTap: () async {
    // onTap: ()async{
    //
    //
    //             SharedPreferences prefs = await SharedPreferences.getInstance();
    //             prefs.setString('logoutkey', ('LogoutDashboard'));
    // prefs.setString('Property_type', ('Apartment'));
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) => tabbar()),
    //             );
    //
    //
    // },

              // onTap: () {
              //   Navigator.pop(context);
              // },
            ),
          ],
        ),
      ),
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // This is all you need!
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
         // BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/home_icon.png"),
              //color: Color(0xFF3A5A98),
              color: Colors.green,

            ),
            //label: 'Home',
            label: 'Home',
          ),
          BottomNavigationBarItem(
            //image: AssetImage('images/banner2.jpg',),
            icon: ImageIcon(
              AssetImage("images/airplane.png"),
              // color: Color(0xFF3A5A98),
              color: Colors.green,
            ),
            label: 'Fly',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/house_icon2.png"),
              // color: Color(0xFF3A5A98),
              color: Colors.green,


            ),
            label: 'Apartments',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/car_icon2.png"),
              // color: Color(0xFF3A5A98),
              color: Colors.green,

            ),
            label: 'Vehicles',
          ),
          //BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Properties"),
          //BottomNavigationBarItem(icon: Icon(Icons.apartment), label: 'Apartments'),
          //BottomNavigationBarItem(icon: Icon(Icons.flight), label: "Flights")
        ],
        selectedLabelStyle: TextStyle (
          fontFamily: 'Baloo',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.2575,
          color: Color(0xff000000),
        ),
        selectedItemColor: Colors.green,
      ),
    );
  }
}