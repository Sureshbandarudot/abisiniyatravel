import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:tourstravels/ApartVC/Addaprtment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ServiceDasboardVC.dart';
import 'VehicleScreens/BusHire_ExistingBookingVC.dart';
import 'VehicleScreens/BusHire_NewuserBookingVC.dart';
import 'VehicleScreens/CarHire_ExistingBookingVC.dart';
import 'VehicleScreens/CarHire_NewBookingVC.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';

void main() {
  runApp(const AuthenticatedVehiclescreen());

}

class AuthenticatedVehiclescreen extends StatelessWidget {
  const AuthenticatedVehiclescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(

          appBar: AppBar(
            leading: BackButton(
              onPressed: () async{
                // print("back Pressed");
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // prefs.setString('logoutkey', ('LogoutDashboard'));
                // prefs.setString('Property_type', ('Apartment'));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ServiceDashboardScreen()),
                );
              },

            ),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
            title: const Text('Vehicle Hire'),
          ),
          body: TabBarView(
            children: [
              Center(
                child: carHire(),
              ),
              Center(
                child: BusHire(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class carHire extends StatefulWidget {
  carHire({
    Key? key,
  }) : super(key: key);
  String RetrivedBearertoekn = '';

  @override
  State<carHire> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<carHire> {

  final baseDioSingleton = BaseSingleton();
  String RetrivedBearertoekn = '';
  String Logoutstr = '';
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // RetrivedEmail = prefs.getString('emailkey') ?? "";
      // RetrivedPwd = prefs.getString('passwordkey') ?? "";
      Logoutstr = prefs.getString('logoutkey') ?? "";
      var propertytype = prefs.getString('Property_type') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";

      print(propertytype);
      print('logout....');
      print(Logoutstr);

      // prefs.setString('logoutkey', ('Logout_Dashboard'));

    });
  }

  Future<dynamic> getData() async {
    //String url = baseDioSingleton.AbisiniyaBaseurl + 'vehicle/auth/list';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //RetrivedId = prefs.getInt('imgkeyId') ?? 0;
    RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
    //String url = (baseDioSingleton.AbisiniyaBaseurl + 'apartment/show/$RetrivedId');
    print('token value for authenticated user....');
    print(RetrivedBearertoekn);

    String url = baseDioSingleton.AbisiniyaBaseurl + 'vehicle/auth/list';
    //final response = await http.get(Uri.parse(url));

    var response = await http.get(
        Uri.parse(
            url),
        headers: {
          "Authorization": "Bearer $RetrivedBearertoekn",
        },
    );
    //final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('success.....');
      final data1 = jsonDecode(response.body);
      print(data1);
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  Future<String>? _calculation;

  @override
  void initState() {
    _retrieveValues();
    _calculation = Future<String>.delayed(
      const Duration(seconds: 2),
          () => 'Data Loaded',
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.headline2!,
        textAlign: TextAlign.center,

        child: FutureBuilder<dynamic>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Input a URL to start');
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return Text('');
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.white),
                    );
                  } else {
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,

                      itemCount: snapshot.data['data'].length ,
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(

                          margin: EdgeInsets.all(35),// add margin

                          // height: 475,
                          // width: 300,
                          color: Colors.white,
                          child: InkWell(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                Container(

                                  height: 475,
                                  width: 300,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFffffff),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 15.0, // soften the shadow
                                          spreadRadius: 5.0, //extend the shadow
                                          offset: Offset(
                                            5.0, // Move to right 5  horizontally
                                            5.0, // Move to bottom 5 Vertically
                                          ),
                                        )
                                      ],
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 200,
                                        //color: Colors.green,

                                        // } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                        //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked Out'){


                                        decoration: BoxDecoration(
                                          // image: DecorationImage(image: NetworkImage(snapshot.data["data"][index]['pictures'][0
                                          // ]['imageUrl']),
                                            image: DecorationImage(image: NetworkImage(snapshot.data?['data'][index]['pictures'].isEmpty ? 'Empty image'
                                                : snapshot.data?["data"][index]['pictures'][0]['imageUrl'].toString() ?? 'empty'),
                                                fit: BoxFit.cover)
                                        ),
                                      ),

                                      Container(
                                        height: 70,
                                        width: 300,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 140,
                                                  child:Text('${(snapshot.data['data'][index]['year'].toString()) + '|' + (snapshot.data['data'][index]['make'].toString())}',textAlign: TextAlign.left,
                                                    style: (TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.green)),),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 140,
                                                  child:Text('${(snapshot.data['data'][index]['model'].toString())}',textAlign: TextAlign.left,
                                                    style: (TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.black)),),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 70,
                                        width: 300,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 300,
                                                  height: 70,
                                                  color: Colors.white,
                                                  //child: (Text(snapshot.data['data']['price'] as int)),
                                                  child:Row(
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: 150,
                                                        color: Colors.white,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 150,
                                                              child:Text('Start From',textAlign: TextAlign.start,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              child:Text('${(snapshot.data['data'][index]['price'].toString())}.00/Night.',textAlign: TextAlign.left,
                                                                style: (TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.green)),),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 40,
                                                        width: 140,
                                                        color: Colors.white,

                                                        child: TextButton(
                                                          style: TextButton.styleFrom(backgroundColor:Colors.green),
                                                          onPressed: () async {
                                                            print(index);
                                                            print(
                                                                'index value...');

                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => CarHire_ExistingBookingScreen()
                                                              ),
                                                            );
                                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                                            prefs.setString('namekey', snapshot.data['data'][index]['name']);
                                                            prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                            prefs.setInt('imgkeyId', snapshot.data['data'][index]['id']);
                                                            prefs.setString('addresskey', snapshot.data['data'][index]['address']);

                                                            prefs.setString('bookable_type', ('Vehicle'));


                                                            //   if(Logoutstr == 'LogoutDashboard') {
                                                            //     Navigator.push(
                                                            //       context,
                                                            //       MaterialPageRoute(
                                                            //           builder: (context) => CarHire_ExistingBookingScreen()
                                                            //       ),
                                                            //     );
                                                            //     SharedPreferences prefs = await SharedPreferences.getInstance();
                                                            //     prefs.setString('namekey', snapshot.data['data'][index]['name']);
                                                            //     prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                            //     prefs.setInt('imgkeyId', snapshot.data['data'][index]['id']);
                                                            //     prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                                            //     prefs.setString('bookable_type', ('Vehicle'));
                                                            //     RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
                                                            //
                                                            //
                                                            //   } else{
                                                            //     Navigator.push(
                                                            //       context,
                                                            //       MaterialPageRoute(
                                                            //           builder: (context) => CarHire_NewUserBooking()
                                                            //       ),
                                                            //     );
                                                            //     SharedPreferences prefs = await SharedPreferences.getInstance();
                                                            //     prefs.setString('namekey', snapshot.data['data'][index]['name']);
                                                            //     prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                            //     prefs.setInt('imgkeyId', snapshot.data['data'][index]['id']);
                                                            //     prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                                            //
                                                            //     prefs.setString('bookable_type', ('Vehicle'));
                                                            //
                                                            //     // login(RetrivedEmail, RetrivedPwd);
                                                            //   }
                                                            // },
                                                          },
                                                          child: const Text('Drive Now',style: (TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18)),),
                                                        ),
                                                      )


                                                    ],
                                                  ),
                                                ),
                                              ],

                                            )
                                          ],
                                        ),
                                      ),

                                      Container(
                                        height: 40,
                                        width: 300,
                                        color: Colors.white,
                                        child:Container(
                                          width: 300,
                                          height: 50,
                                          color: Colors.white,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child:Text('${(snapshot.data['data'][index]['name'].toString())}',textAlign: TextAlign.left,
                                              style: (TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.black)),),
                                          ),
                                        ),
                                      ),


                                      Container(
                                        height: 70,
                                        width: 300,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 300,
                                                  height: 70,
                                                  color: Colors.white,
                                                  //child: (Text(snapshot.data['data']['price'] as int)),
                                                  child:Row(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 150,
                                                        color: Colors.green,
                                                        child:Container(
                                                          width: 360,
                                                          height: 230,
                                                          color: Colors.green,
                                                          child: Align(
                                                            alignment: Alignment.center,
                                                            child:Text('${(snapshot.data['data'][index]['fuel_type'].toString())}',textAlign: TextAlign.center,
                                                              style: (TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.white)),),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        width: 150,
                                                        color: Colors.green,
                                                        child:Container(
                                                          width: 360,
                                                          height: 230,
                                                          color: Colors.green,
                                                          child: Align(
                                                            alignment: Alignment.center,
                                                            child:Text('${(snapshot.data['data'][index]['transmission'].toString())}',textAlign: TextAlign.center,
                                                              style: (TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.white)),),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            //onTap: ()
                            onTap: ()async{

                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('citykey', snapshot.data['data'][index]['city']);
                              prefs.setInt('imgkeyId', snapshot.data['data'][index]['id']);
                              prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                              prefs.setString('bathroomkey', (snapshot.data['data'][index]['bathroom'].toString()));
                              prefs.setString('bedroomkey', (snapshot.data['data'][index]['bedroom'].toString()));
                              prefs.setString('pricekey', (snapshot.data['data'][index]['price'].toString()));
                              prefs.setString('Property_type', ('Apartment'));
                              print([index]);
                            },
                          ),
                        );
                      },
                    );
                  }
              }
            }
        )
    );
  }
}

class BusHire extends StatefulWidget {
  BusHire({
    Key? key,
  }) : super(key: key);
  String RetrivedBearertoekn = '';

  @override
  State<BusHire> createState() => _BusHireWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _BusHireWidgetState extends State<BusHire> {

  final baseDioSingleton = BaseSingleton();
  String RetrivedBearertoekn = '';
  String Logoutstr = '';
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // RetrivedEmail = prefs.getString('emailkey') ?? "";
      // RetrivedPwd = prefs.getString('passwordkey') ?? "";
      Logoutstr = prefs.getString('logoutkey') ?? "";
      var propertytype = prefs.getString('Property_type') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      print('bus hiring........');

      print(propertytype);
      print('logout....');
      print(Logoutstr);

      // prefs.setString('logoutkey', ('Logout_Dashboard'));

    });
  }

  Future<dynamic> busgetData() async {
    String url = baseDioSingleton.AbisiniyaBaseurl + 'bus/list';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('success.....');
      final data1 = jsonDecode(response.body);
      print(data1);
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  Future<String>? _calculation;

  @override
  void initState() {
    _retrieveValues();
    _calculation = Future<String>.delayed(
      const Duration(seconds: 2),
          () => 'Data Loaded',
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.headline2!,
        textAlign: TextAlign.center,

        child: FutureBuilder<dynamic>(
            future: busgetData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Input a URL to start');
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return Text('');
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.white),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: snapshot.data['data'].length ,
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 475,
                          width: 300,
                          color: Colors.white,
                          child: InkWell(
                            child: Column(
                              children: [
                                //Text(snapshot.data["data"][index]['pictures'][index]['imageUrl']),
                                //Image.network(snapshot.data["data"][index]['pictures'][index]['imageUrl']),

                                Container(
                                  height: 475,
                                  width: 300,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFffffff),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 15.0, // soften the shadow
                                          spreadRadius: 5.0, //extend the shadow
                                          offset: Offset(
                                            5.0, // Move to right 5  horizontally
                                            5.0, // Move to bottom 5 Vertically
                                          ),
                                        )
                                      ],
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 200,
                                        //color: Colors.green,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage(snapshot.data["data"][index]['pictures'][0
                                            ]['imageUrl']),
                                                fit: BoxFit.cover)
                                        ),
                                      ),

                                      Container(
                                        height: 70,
                                        width: 300,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 140,
                                                  child:Text('${(snapshot.data['data'][index]['year'].toString()) + '|' + (snapshot.data['data'][index]['make'].toString())}',textAlign: TextAlign.left,
                                                    style: (TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.green)),),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 140,
                                                  child:Text('${(snapshot.data['data'][index]['model'].toString())}',textAlign: TextAlign.left,
                                                    style: (TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.black)),),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 70,
                                        width: 300,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 300,
                                                  height: 70,
                                                  color: Colors.white,
                                                  //child: (Text(snapshot.data['data']['price'] as int)),
                                                  child:Row(
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: 150,
                                                        color: Colors.white,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 150,
                                                              child:Text('Start From',textAlign: TextAlign.start,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              child:Text('${(snapshot.data['data'][index]['price'].toString())}.00/Night.',textAlign: TextAlign.left,
                                                                style: (TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.green)),),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 40,
                                                        width: 140,
                                                        color: Colors.white,

                                                        child: TextButton(
                                                          style: TextButton.styleFrom(backgroundColor:Colors.green),
                                                          onPressed: () async {
                                                            print(index);
                                                            print('index value...');


                                                            if(Logoutstr == 'LogoutDashboard') {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => BusHire_ExistingBookingScreen()
                                                                ),
                                                              );

                                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                                              prefs.setInt('caridkey', snapshot.data['data'][index]['id']);
                                                              prefs.setString('bookable_type', ('Vehicle'));
                                                              RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";


                                                            } else{
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => BusHire_NewUserBooking()
                                                                ),
                                                              );
                                                              print('new bus hire id......');
                                                              print(snapshot.data['data'][index]['id']);
                                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                                              prefs.setInt('caridkey', snapshot.data['data'][index]['id']);
                                                              prefs.setString('bookable_type', ('Vehicle'));

                                                              // login(RetrivedEmail, RetrivedPwd);
                                                            }
                                                          },
                                                          child: const Text('Hire Now',style: (TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18)),),
                                                        ),
                                                      )


                                                    ],
                                                  ),
                                                ),
                                              ],

                                            )
                                          ],
                                        ),
                                      ),

                                      // Container(
                                      //   height: 40,
                                      //   width: 300,
                                      //   color: Colors.white,
                                      //   child:Container(
                                      //     width: 300,
                                      //     height: 50,
                                      //     color: Colors.white,
                                      //     child: Align(
                                      //       alignment: Alignment.centerLeft,
                                      //       child:Text('${(snapshot.data['data'][index]['name'].toString())}',textAlign: TextAlign.left,
                                      //         style: (TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.black)),),
                                      //     ),
                                      //   ),
                                      // ),


                                      Container(
                                        height: 70,
                                        width: 300,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 300,
                                                  height: 70,
                                                  color: Colors.white,
                                                  //child: (Text(snapshot.data['data']['price'] as int)),
                                                  child:Row(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 150,
                                                        color: Colors.green,
                                                        child:Container(
                                                          width: 360,
                                                          height: 230,
                                                          color: Colors.green,
                                                          child: Align(
                                                            alignment: Alignment.center,
                                                            child:Text('${(snapshot.data['data'][index]['fuel_type'].toString())}',textAlign: TextAlign.center,
                                                              style: (TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.white)),),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        width: 150,
                                                        color: Colors.green,
                                                        child:Container(
                                                          width: 360,
                                                          height: 230,
                                                          color: Colors.green,
                                                          child: Align(
                                                            alignment: Alignment.center,
                                                            child:Text('${(snapshot.data['data'][index]['transmission'].toString())}',textAlign: TextAlign.center,
                                                              style: (TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.white)),),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            //onTap: ()
                            onTap: ()async{

                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('citykey', snapshot.data['data'][index]['city']);
                              prefs.setInt('imgkeyId', snapshot.data['data'][index]['id']);
                              prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                              prefs.setString('bathroomkey', (snapshot.data['data'][index]['bathroom'].toString()));
                              prefs.setString('bedroomkey', (snapshot.data['data'][index]['bedroom'].toString()));
                              prefs.setString('pricekey', (snapshot.data['data'][index]['price'].toString()));
                              prefs.setString('Property_type', ('Apartment'));
                              print([index]);
                            },
                          ),
                        );
                      },
                    );
                  }
              }
            }
        )
    );
  }
}
