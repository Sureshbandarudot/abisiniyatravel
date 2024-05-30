import 'package:flutter/material.dart';
import 'package:tourstravels/settingsVC.dart';
import 'package:tourstravels/supportVC.dart';

import 'ApartVC/Apartment.dart';
import 'ApartVC/Authenticated_Userbookingscreen.dart';
import 'Auth/Login.dart';
import 'Authenticated_Vehiclescreen.dart';
import 'UserDashboard_Screens/newDashboard.dart';
import 'flyScreens/Auth_flightRequestVC.dart';
import 'flyScreens/Flights.dart';
import 'Vehicles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
class ServiceDashboardScreen extends StatefulWidget {
  const ServiceDashboardScreen({super.key});
  @override
  State<ServiceDashboardScreen> createState() => _ServiceDashboardScreenState();
}

class _ServiceDashboardScreenState extends State<ServiceDashboardScreen> {
  List<String> LoggedinUserlist = [];
  @override
  final borderRadius = BorderRadius.circular(20); // Image border
  String Logoutstr = '';
  String LoggedInUSerstr = '';
  String NewBookingUserstr = '';
  String Signoutstr = '';

  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      Logoutstr = prefs.getString('logoutkey') ?? "";
      print('new dashboard sts...');
      print(Logoutstr);
       if(Logoutstr == 'LogoutDashboard'){
       }
    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
  }
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.green,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.white, Colors.green]),
              ),
            ),
            title: Center(
              child: Text(
                'Abisiniya',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.white, Colors.green]),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 1.0,
              children: [
                Ink(
                  color: Colors.white,
                  child: InkWell(
                    child:Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            //margin: EdgeInsets.only(top: 20,left: 20),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                //child: Image.network('imageUrl', fit: BoxFit.cover),
                                child: Image.asset('images/apts.jpg', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text('Apartments',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),)
                        ],
                      ),
                    ),
                    onTap: () async{
                       SharedPreferences prefs = await SharedPreferences.getInstance();
                       print('dashboard sts...');
                      print(Logoutstr);
                      LoggedInUSerstr = prefs.getString('LoggedinUserkey') ?? "";
                      print(' logged in user...');
                      print(LoggedInUSerstr);
                       print('letters length....');
                       LoggedinUserlist.add(LoggedInUSerstr);
                       print(LoggedinUserlist);
                       print(LoggedinUserlist.length);
                      if (LoggedInUSerstr == 'LoggedUser') {
                        print('login...');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthenticatedUserScreen()),
                        );
                        SharedPreferences prefrences = await SharedPreferences.getInstance();
                        await prefrences.remove("LoggedinUserkey");

                      }  else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Apartmentscreen()),
                        );
                      }
                    },
                  ),
                ),

                Ink(
                  color: Colors.white,
                  child: InkWell(
                    child:Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            //margin: EdgeInsets.only(top: 20,left: 20),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                //child: Image.network('imageUrl', fit: BoxFit.cover),
                                child: Image.asset('images/Flightimg.jpg', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text('Flights',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),)
                        ],
                      ),
                    ),
                    onTap: () async{
                      LoggedinUserlist.add(LoggedInUSerstr);
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      LoggedInUSerstr = prefs.getString('LoggedinUserkey') ?? "";
                      LoggedinUserlist.add(LoggedInUSerstr);
                      if (LoggedInUSerstr == 'LoggedUser') {
                        print('login...');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthFlightScreen()),
                        );
                        SharedPreferences prefrences = await SharedPreferences.getInstance();
                        await prefrences.remove("LoggedinUserkey");

                      }  else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FlightScreen()),
                        );
                      }
                    },
                  ),
                ),
                Ink(
                  color: Colors.white,
                  child: InkWell(
                    child:Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            //margin: EdgeInsets.only(top: 20,left: 20),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                //child: Image.network('imageUrl', fit: BoxFit.cover),
                                child: Image.asset('images/carimgs.jpg', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text('Vehicles',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),)
                        ],
                      ),
                    ),
                    onTap: () async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      Logoutstr = prefs.getString('logoutkey') ?? "";
                      print('vehicle dashboard sts...');
                      print(Logoutstr);
                      LoggedinUserlist.add(LoggedInUSerstr);
                     // SharedPreferences prefs = await SharedPreferences.getInstance();
                      LoggedInUSerstr = prefs.getString('LoggedinUserkey') ?? "";
                      LoggedinUserlist.add(LoggedInUSerstr);
                      print('vehcle LoggedInUSerstr.....');
                      print(LoggedInUSerstr);
                      if (LoggedInUSerstr == 'LoggedUser') {
                        print('vehicle login...');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthenticatedVehiclescreen()),
                        );
                        SharedPreferences prefrences = await SharedPreferences.getInstance();
                        await prefrences.remove("LoggedinUserkey");

                      }  else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Vehiclescreen()),
                        );
                      }
                      // if(Logoutstr == 'LogoutDashboard'){
                      //   print('loged in user....');
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AuthenticatedVehiclescreen()),
                      //   );
                      // } else {
                      //   print('fresh vehicle use...');
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Vehiclescreen()),
                      //   );                      }
                    },
                  ),
                ),
                Ink(
                  color: Colors.white,
                  child: InkWell(
                    child:Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            //margin: EdgeInsets.only(top: 20,left: 20),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                //child: Image.network('imageUrl', fit: BoxFit.cover),
                                child: Image.asset('images/profileimg.jpg', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text('My Profile',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),)
                        ],
                      ),
                    ),
                    onTap: () async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      Logoutstr = prefs.getString('logoutkey') ?? "";
                      print('vehicle dashboard sts...');
                      print(Logoutstr);
                      LoggedinUserlist.add(LoggedInUSerstr);
                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                      LoggedInUSerstr = prefs.getString('LoggedinUserkey') ?? "";
                      LoggedinUserlist.add(LoggedInUSerstr);
                      print('vehcle LoggedInUSerstr.....');
                      print(LoggedInUSerstr);
                      if (LoggedInUSerstr == 'LoggedUser') {
                        print('vehicle login...');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => newuserDashboard()),
                        );
                        SharedPreferences prefrences = await SharedPreferences.getInstance();
                        await prefrences.remove("LoggedinUserkey");

                      }  else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login()),
                        );
                      }
                      // if(Logoutstr == 'LogoutDashboard'){
                      //   print('loged in user....');
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AuthenticatedVehiclescreen()),
                      //   );
                      // } else {
                      //   print('fresh vehicle use...');
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Vehiclescreen()),
                      //   );                      }
                    },
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Login()),
                    //   );
                    // },
                  ),
                ),
                Ink(
                  color: Colors.white,
                  child: InkWell(
                    child:Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            //margin: EdgeInsets.only(top: 20,left: 20),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                //child: Image.network('imageUrl', fit: BoxFit.cover),
                                child: Image.asset('images/Settingsimg.jpg', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text('More',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),)
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => settingsScreen()),
                      );
                    },
                  ),
                ),
                Ink(
                  color: Colors.white,
                  child: InkWell(
                    child:Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            //margin: EdgeInsets.only(top: 20,left: 20),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(48), // Image radius
                                //child: Image.network('imageUrl', fit: BoxFit.cover),
                                child: Image.asset('images/support.jpg', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text('Support',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),)
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => supportScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
