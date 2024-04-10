
import 'package:flutter/material.dart';
//import 'package:tourstravels/ApartVC/Add_Apartment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:tourstravels/ApartVC/Addaprtment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/UserDashboard_Screens/Apartbooking_Model.dart';
import 'package:tourstravels/UserDashboard_Screens/PivoteVC.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/My_Apartments/My_AprtmetsVC.dart';
import 'package:tourstravels/My_Apartments/ViewApartmentVC.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import '../MyBookings/MybookingVC.dart';
import '../ServiceDasboardVC.dart';
// import 'ViewBookingsVC.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';

import 'create_AuthuserVC.dart';
import 'create_newuserVC.dart';
import 'flightViewBookingVC.dart';


//import 'NewUserbooking.dart';
class FluBooking_RequestScreen extends StatefulWidget {
  // const MyApartmentScreen({super.key});

  @override
  State<FluBooking_RequestScreen> createState() => _userDashboardState();
}

class _userDashboardState extends State<FluBooking_RequestScreen> {
  final baseDioSingleton = BaseSingleton();
  int bookingID = 0;
  String LoggedInUser = 'LoggedUser';
  String RetrivedBearertoekn = '';
  String Bookingsts = 'Not booked yet!';
  int ApartmentId = 0;
  String flyAuthuser = '';
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // RetrivedEmail = prefs.getString('emailkey') ?? "";
      // RetrivedPwd = prefs.getString('passwordkey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      // ApartmentId = prefs.getInt('userbookingId') ?? 0;
      // print('Apartment id---');
      // print(ApartmentId);
      print('My Fly token');
      print(RetrivedBearertoekn);
    });
  }
//@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    getData();

  }

  Future<dynamic> getData() async {
    // String url = 'https://staging.abisiniya.com/api/v1/booking/apartment/mybookings';
    String url = baseDioSingleton.AbisiniyaBaseurl + 'flight/flightreqs';

    var response = await http.get(
      Uri.parse(
          url),
      headers: {
        // 'Authorization':
        // 'Bearer <--your-token-here-->',
        "Authorization": "Bearer $RetrivedBearertoekn",

      },
    );
    if (response.statusCode == 200) {
      final data1 = jsonDecode(response.body);
      var getpicsData = [];
      var jsonData = data1['data'];
      print('fly....');
      print(jsonData);
      // for (var record in picstrr) {
      //   idnum = record['id'];
      // }
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text(
      //     'Abisiniya',
      //   ),
      //   // backgroundColor: const Color(0xff764abc),
      //   backgroundColor: Colors.green,
      //
      // ),
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          onPressed: () async{
            print("back Pressed");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // prefs.setString('logoutkey', ('LogoutDashboard'));
            //prefs.setString('Property_type', ('Apartment'));
            prefs.setString('LoggedinUserkey', LoggedInUser);
            SharedPreferences prefrences = await SharedPreferences.getInstance();
            await prefrences.remove("flyAuthuserkey");


            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServiceDashboardScreen()),
            );
            // LoggedInUser = 'LoggedUser';
            // prefs.setString('LoggedinUserkey', LoggedInUser);
            //
            // NewBookingUserstr = prefs.getString('newBookingUserkey') ?? "";
            // LoggedInUSerstr = prefs.getString('LoggedinUserkey') ?? "";
            // print(' dashboard logged in user...');
            // print(LoggedInUSerstr);
            // print(NewBookingUserstr);

          },

        ),
        // iconTheme: IconThemeData(
        //     color: Colors.green,
        // ),
        title: Text('Flight Requests',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

      ),
      // appBar: AppBar(
      //   centerTitle: true,
      //   leading: BackButton(
      //   onPressed: () async{
      // print("back Pressed");
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // // prefs.setString('logoutkey', ('LogoutDashboard'));
      // //prefs.setString('Property_type', ('Apartment'));
      // prefs.setString('LoggedinUserkey', LoggedInUser);
      //
      //
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => ServiceDashboardScreen()),
      // );
      //   leading: Padding(
      //     // padding: const EdgeInsets.all(0.0),
      //     padding: EdgeInsets.only(left: 15.0, top: 0.0),
      //     child: Image.asset(
      //       "images/logo.jpg",
      //     ),),
      //   title: Text('ABISINIYA',textAlign: TextAlign.center,
      //       style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
      //   iconTheme: IconThemeData(color: Colors.green),),
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
              title: const Text('My Bookings',
                  style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('logoutkey', ('LogoutDashboard'));
                prefs.setString('Property_type', ('Apartment'));
                prefs.setString('tokenkey',RetrivedBearertoekn );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyBookingScreen()),
                );
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.money,
                color: Colors.green,
              ),
              title: const Text('Booking Commision',
                  style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w500,fontSize: 18)),


              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.flight,
                color: Colors.green,
              ),

              title: const Text('My Flight Requests',
                  style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w500,fontSize: 18)),

              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('logoutkey', ('LogoutDashboard'));
                prefs.setString('Property_type', ('Apartment'));
                print('flight token');
                print(RetrivedBearertoekn);
                prefs.setString('tokenkey',RetrivedBearertoekn );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FluBooking_RequestScreen()),
                );
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // prefs.setString('logoutkey', ('LogoutDashboard'));
                // prefs.setString('Property_type', ('Apartment'));
                // prefs.setString('tokenkey',RetrivedBearertoekn );
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.apartment,
                color: Colors.green,
              ),


              title: const Text('My Apartments',
                  style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w500,fontSize: 18)),

              onTap: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('logoutkey', ('LogoutDashboard'));
                prefs.setString('Property_type', ('Apartment'));
                prefs.setString('tokenkey',RetrivedBearertoekn );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApartmentScreen()),
                );
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.bus_alert,
                color: Colors.green,
              ),
              title: const Text('My Vehicles',
                  style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w500,fontSize: 18)),
              //title: const Text('Airport Shuttle',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.bus_alert_sharp,
                color: Colors.green,
              ),
              //title: const Text('List Property and Car',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18)),
              title: const Text('My Buses',
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
              //title: const Text('Contact Us',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18)),
              title: const Text('My Shuttle',
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
              title: const Text('Logout',
                  style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

              //onTap: () async {
              onTap: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('logoutkey', ('LogoutDashboard'));
                //prefs.setString('Property_type', ('Apartment'));
                //prefs.setString('newBookingUserkey', (LoggedInUser));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ServiceDashboardScreen()),
                );
                SharedPreferences prefrences = await SharedPreferences.getInstance();
                await prefrences.remove("LoggedinUserkey");
                await prefrences.remove("flyAuthuserkey");


                // NewBookingUserstr = prefs.getString('newBookingUserkey') ?? "";
                // LoggedInUSerstr = prefs.getString('LoggedinUserkey') ?? "";
                // print(' dashboard logged in user...');
                // print(LoggedInUSerstr);
                // print(NewBookingUserstr);
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<dynamic>(

        //future: BookingDashboardUsers,
          future: getData(),

          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('');
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                print('imagename......');
                return Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  //return InkWell(

                  return Column(
                    children: <Widget>[
                      //Container(color: Colors.red, height: 50),
                      Container(
                        height: 5,
                        width: 340,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white70,
                          child: LayoutBuilder(
                            builder: (context, constraint) {
                              return SingleChildScrollView(
                                physics: ScrollPhysics(),

                                child: Column(
                                  children: <Widget>[
                                    //Text('Your Apartments'),
                                    Text('Create Flight',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),


                                    Container(
                                      height: 50,
                                      width: 340,
                                      color: Colors.black54,

                                      child: Column(
                                        children: [

                                          InkWell(
                                            child: Container(
                                              height: 50,
                                              width: 340,
                                              color: Colors.black54,
                                              child: const Align(
                                                alignment: Alignment.center,
                                                child: Text('Create',
                                                    style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w800
                                                    ),
                                                    textAlign: TextAlign.center),
                                              ),

                                            ),
                                            onTap: () async {
                                              print("Tapped on container");
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              prefs.setString('logoutkey', ('LogoutDashboard'));
                                              prefs.setString('Property_type', ('Apartment'));
                                              prefs.setString('tokenkey',RetrivedBearertoekn );
                                              flyAuthuser = prefs.getString('flyAuthuserkey') ?? "";
                                              print('fly.......');
                                              print(flyAuthuser);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Create_AuthFlightScreen()),
                                              );
                                              // if(flyAuthuser == 'Flyauthuser'){
                                              //   print('fly not empty...');
                                              //
                                              //   Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => Create_AuthFlightScreen()),
                                              //   );
                                              //
                                              // } else {
                                              //   print('fly empty...');
                                              //   // Navigator.push(
                                              //   //   context,
                                              //   //   MaterialPageRoute(
                                              //   //       builder: (context) => Create_newUSerFlightScreen()),
                                              //   // );
                                              //
                                              // }

                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) => CreateApartment()),
                                              // );
                                            },
                                          )],
                                      ),
                                      // child: const Align(
                                      // alignment: Alignment.center,
                                      // child: Text('Create',
                                      // style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w800
                                      // ),
                                      // textAlign: TextAlign.center),
                                      // ),
                                    ),

                                    ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        //itemCount:50,
                                        itemCount: snapshot.data['data'].length ?? '',
                                        //itemCount: snapshot.data?['data']['bookings'].length ?? "" ,
                                        //itemCount: snapshot.data!['data'][0]['bookings'][0].length ?? 0,
                                        //itemCount: snapshot.data?.length ?? 0,



                                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                                        itemBuilder: (BuildContext context, int index) {
                                          bookingID = snapshot.data['data'][index]['flight_request_id'];
                                          print('fly id...');
                                          print(bookingID);


//    itemBuilder: (context,index){
                                          return Container(
                                            height: 275,
                                            width: 100,
                                            alignment: Alignment.center,
                                            color: Colors.white,
                                            child: InkWell(

                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 275,
                                                    width: 340,
                                                    color: Colors.black12,
                                                    child: Column(
                                                      children: [

                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('Date:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              child:Text(snapshot.data['data'][index]['created_at'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('ID:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              // child:Text(snapshot.data['data'][index]['created_at'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                              child:Text('${(snapshot.data['data'][index]['flight_request_id'].toString())}',textAlign: TextAlign.left,
                                                                style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('FullName:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,

                                                              //child:Text(snapshot.data['data'][index]['type'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),

                                                              child:Text('${(snapshot.data['data'][index]['user_id']['surname']) + " " + (snapshot.data['data'][index]['user_id']['name'])}',textAlign: TextAlign.left,
                                                                style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),

                                                              // child:Text('${(snapshot.data['data'][index]['user_id'].toString())}.00/Night.',textAlign: TextAlign.left,
                                                              //   style: (TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.green)),),

                                                            )
                                                          ],
                                                        ),

                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('From:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              child:Text(snapshot.data['data'][index]['from'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            )
                                                          ],
                                                        ),

                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('To:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              child:Text(snapshot.data['data'][index]['to'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            )
                                                          ],
                                                        ),


                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('Airline:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              child:Text(snapshot.data['data'][index]['airline'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            )
                                                          ],
                                                        ),

                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('Travel Class:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              child:Text(snapshot.data['data'][index]['travel_class'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            )
                                                          ],
                                                        ),



                                                        Column(
                                                          children: [

                                                            // Align(
                                                            //   alignment: Alignment.center,
                                                            //   child: Container(
                                                            //     color: Colors.transparent,
                                                            //     child: Text('Action:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),),
                                                            //   ),
                                                            // ),

                                                            // SizedBox(
                                                            //   width: 30,
                                                            // ),
                                                            InkWell(
                                                              child: Container(
                                                                color: Colors.green,
                                                                child: Container(
                                                                  width: 340,
                                                                  height: 40,
                                                                  color: Colors.transparent,
                                                                  //child: Text('View',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
                                                                  child: Align(
                                                                    alignment: Alignment.center,
                                                                    child: Container(
                                                                      color: Colors.transparent,
                                                                      child: Text('View',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.white),),
                                                                    ),
                                                                  ),


                                                                ),                                                              ),
                                                              onTap: () async {

                                                                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                                  builder: (_) => flightViewBookingscreen(),
                                                                ),);
                                                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                print('booking id...');
                                                               // print(bookingID);
                                                                print(snapshot.data['data'][index]['flight_request_id']);
                                                                // prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                                                //prefs.setString('referencekey', snapshot.data['data'][index]['reference']);
                                                                prefs.setInt('userbookingId', snapshot.data['data'][index]['flight_request_id']);
                                                                prefs.setString('tokenkey', RetrivedBearertoekn);
                                                                print("value of your text");},
                                                            ),
                                                          ],
                                                        )
                                                      ],

                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () async{
                                                //
                                                // if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval' || (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved' || (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked In' || (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked Out'){
                                                //
                                                //
                                                //   SharedPreferences prefs = await SharedPreferences.getInstance();
                                                //   print('booking id...');
                                                //   print(snapshot.data['data'][index]['id']);
                                                //   prefs.setString('namekey', snapshot.data['data'][index]['name']);
                                                //
                                                //   prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                                //   prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                //   prefs.setString('countrykey', snapshot.data['data'][index]['country']);
                                                //   prefs.setInt('guestkey', snapshot.data['data'][index]['guest']);
                                                //   prefs.setInt('bedroomkey', snapshot.data['data'][index]['bedroom']);
                                                //   prefs.setInt('bathroomkey', snapshot.data['data'][index]['bathroom']);
                                                //   prefs.setInt('pricekey', snapshot.data['data'][index]['price']);
                                                //   prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
                                                //   prefs.setString('tokenkey', RetrivedBearertoekn);
                                                //
                                                //
                                                //   Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                //     builder: (_) => PivotDashboard(),
                                                //   ),);
                                                //
                                                // } else {
                                                //   print('failure....');
                                                //   final snackBar = SnackBar(
                                                //     content: Text('Not booked yet!'),
                                                //   );
                                                //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                // }

                                              },
                                            ),
                                          );
                                          //return  Text('Some text');
                                        }),

                                    Column(
                                      children:<Widget>[
                                        // Text('second test'),
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: 1,
                                            itemBuilder: (context,index){
                                              return  Text('',style: TextStyle(fontSize: 22),);
                                            }),

                                      ],
                                    )
                                  ],

                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],

                  );

                }
            }
          }
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: 50,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
