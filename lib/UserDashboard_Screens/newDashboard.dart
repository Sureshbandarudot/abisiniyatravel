
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

import '../MyBookings/MybookingVC.dart';
//import 'NewUserbooking.dart';
class newuserDashboard extends StatefulWidget {
  const newuserDashboard({super.key});

  @override
  State<newuserDashboard> createState() => _userDashboardState();
}

class _userDashboardState extends State<newuserDashboard> {


  int bookingID = 0;
  var API = '';
  String status = '';
  int _counter = 0;
  int idnum = 0;
  String Date = '';
  int selectedIndex = 0;
  int imageID = 0;
  String citystr = '';
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String RetrivedBearertoekn = '';
  String Bookingsts = 'Not booked yet!';
  String Statusstr = '';
  String stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
 String stsId = '';
  var controller = ScrollController();
  late Future<List<DashboardApart>> BookingDashboardUsers ;
  int count = 15;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      RetrivedEmail = prefs.getString('emailkey') ?? "";
      RetrivedPwd = prefs.getString('passwordkey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      print('booking token...');
      print(RetrivedBearertoekn);

      //SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('logoutkey', ('LogoutDashboard'));
      prefs.setString('Property_type', ('Apartment'));

      final snackBar = SnackBar(
        content: Text('You Are Logged In Successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);


    });
  }
//@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    getData();
    BookingDashboardUsers = DashboardBooking_fetchUsers();
    //pics = fetchpics();
  }
  String url = 'https://staging.abisiniya.com/api/v1/apartment/list';
  Future<List<DashboardApart>> DashboardBooking_fetchUsers() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data1 = jsonDecode(response.body);
      var getUsersData = data1['data'] as List;
      //print(getUsersData);
      var listUsers = getUsersData.map((i) => DashboardApart.fromJSON(i)).toList();
      return listUsers;

    } else {
      throw Exception('Error');
    }
  }

    Future<dynamic> getData() async {
    //String url = 'https://staging.abisiniya.com/api/v1/apartment/list';
    String url = 'https://staging.abisiniya.com/api/v1/booking/apartment/withbooking';
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
      print('success new user....');

      final data1 = jsonDecode(response.body);
      var getpicsData = [];
      var picstrr = data1['data'];
      // for (var record in picstrr) {
      //   idnum = record['id'];
      // }
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }


  //Alert Dialog box
  DeclinedshowAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PivotDashboard()),
        );
        //Navigator.push(
        //context, MaterialPageRoute(builder: (context) => Page1()));
        //Navigator.pushNamed(context, AppRoutes.helpScreen);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(
          "Do you want Update Decline!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
//Status Alert
  UpdatedstatusshowAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PivotDashboard()),
        );
        //Navigator.push(
        //context, MaterialPageRoute(builder: (context) => Page1()));
        //Navigator.pushNamed(context, AppRoutes.helpScreen);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(
          "Do you want Update the status!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
            prefs.setString('logoutkey', ('LogoutDashboard'));
            prefs.setString('Property_type', ('Apartment'));
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => tabbar()),
            );
    },

        ),
        // iconTheme: IconThemeData(
        //     color: Colors.green,
        // ),
        title: Text('ABISINIYA',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

      ),
      // appBar: AppBar(
      //   centerTitle: true,
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

              onTap: () {
                Navigator.pop(context);
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


                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // prefs.setString('logoutkey', ('LogoutDashboard'));
                // prefs.setString('Property_type', ('Apartment'));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => tabbar()),
                );
              },

              // onTap: () {
              //   Navigator.pop(context);
              // },
            ),
          ],
        ),
      ),
      //   drawer: Drawer(
      //     child: ListView(
      //       // Important: Remove any padding from the ListView.
      //       padding: EdgeInsets.zero,
      //       children: [
      //         // const DrawerHeader(
      //         //   decoration: BoxDecoration(
      //         //     color: Colors.green,
      //         //   ),
      //         //   child: Text('Drawer Header'),
      //         // ),
      //         DrawerHeader(
      //
      //           //child: Text('Categories', style: TextStyle(color: Colors.white)),
      //           decoration: BoxDecoration(color: Color(0xffffff
      //           ),),
      //           padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      //
      //           child: Image.asset(
      //             'images/logo2.png',
      //             width: 50,height: 50,
      //           ),
      //         ),
      //         ListTile(
      //           trailing: Icon(
      //             Icons.home,
      //           ),
      //           title: const Text('Page 1'),
      //           onTap: () {
      //             Navigator.pop(context);
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(
      //             Icons.train,
      //           ),
      //           title: const Text('Page 2'),
      //           onTap: () {
      //             Navigator.pop(context);
      //           },
      //         ),
      //         ListTile(
      //           trailing: Icon(
      //             Icons.logout,
      //             color: Colors.green,
      //           ),
      //           //title: const Text('Sign Out',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 20)),
      //           title: const Text('Logout',
      //               style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
      //
      //           //onTap: () async {
      //           onTap: ()async{
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => tabbar()),
      //             );
      //           },
      //
      //           // onTap: () {
      //           //   Navigator.pop(context);
      //           // },
      //         ),
      //       ],
      //     ),
      //   ),
      //body: FutureBuilder(
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
            Container(color: Colors.white, height: 10),
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
              Text('Your Apartments:',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),

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
               bookingID = snapshot.data['data'][index]['id'];


//    itemBuilder: (context,index){
              return Container(
                height: 290,
                width: 100,
                alignment: Alignment.center,
                color: Colors.white,
                child: InkWell(

                child: Column(
                  children: [
                    Container(
                      height: 90,
                      width: 340,
                      color: Colors.black12,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 140,
                                color: Colors.black12,
                                child: Text('Owner:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              ),
                              Container(
                                height: 30,
                                width: 200,
                                color: Colors.black12,
                                //child:Text(snapshot.data['data'][index]['name'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.green)),),

                                child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                    : snapshot.data?["data"][index]?['name']?.toString() ?? 'empty'),


                                // child:Text(snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                //     : snapshot.data?["data"][index]?['bookings']?[0]['pivot']['start_date'].toString() ?? 'empty'),


                                //child:Text((snapshot.data["data"][index]['bookings'][0]['date'])),

                                // child:Text(
                                //   (response.cutomerDetails.address.isNotEmpty)
                                //       ? response.customerDetails!.address![0].city
                                //       : "N/A",
                               //child: Text((snapshot.data['data'][index]['bookings'][0]['date'] ?? 0)),
                                //child: Text(getpicsData[0]),

                                  //data.allData[index].reviews!.isEmpty ? 0 : data.allData[index].reviews![0].rating
                                //child: Text((snapshot.data['data'][index][''])),

                                  //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 140,
                                color: Colors.black12,
                                child: Text('Address:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              ),
                              Container(
                                height: 30,
                                width: 200,
                                color: Colors.black12,
                                //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                child:Text(snapshot.data['data'][index]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.green)),),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 140,
                                color: Colors.black12,
                                child: Text('City:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              ),
                              Container(
                                height: 30,
                                width: 200,
                                color: Colors.black12,
                                child:Text(snapshot.data['data'][index]['city'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.green)),),

                                // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              )
                            ],

                          )
                        ],

                      ),
                    ),
                Container(
                  height: 150,
                  width: 340,

                  color: Colors.white10,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 140,
                            color: Colors.white10,
                            child: Text('check-in:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                          ),
                          Container(
                            height: 35,
                            width: 200,
                            color: Colors.white,
                            //Text(snapshot.data["data"][index]['bookings'][0]['id'].toString() ?? 'empty'),
                            //
                            // child:Text(snapshot.data?['data'][index]['bookings'].isEmpty ? 'Not booked yet'
                            //     : snapshot.data?["data"][index]?['bookings']?[0]['start_date'].toString() ?? 'empty'),

                            // child:Text(snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                            //    : snapshot.data?["data"][index]?['bookings'][index]?['pivot']['start_date'].toString() ?? 'empty'),
                            child:Text(snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                : snapshot.data?["data"][index]?['bookings']?[0]['pivot']['start_date'].toString() ?? 'empty'),


                            // child: Text((snapshot.data["data"][index]['bookings'][0]['start_date'].toString() ?? 'empty'),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 140,
                            color: Colors.white,
                            child: Text('check-out:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                          ),
                          Container(
                            height: 35,
                            width: 200,
                            color: Colors.white,
                           // child: Text((snapshot.data["data"][index]['bookings'][0]['end_date'].toString() ?? 'empty'),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

                            //child:Text(snapshot.data?['data'][index]['bookings'].isEmpty ? 'Not booked yet'
                              //  : snapshot.data?["data"][index]?['bookings']?[0]['end_date'].toString() ?? 'empty'),

                           // child:Text(snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                             //   : snapshot.data?["data"][index]?['bookings'][index]?['pivot']['end_date'].toString() ?? 'empty'),

                            child:Text(snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                : snapshot.data?["data"][index]?['bookings']?[0]['pivot']['end_date'].toString() ?? 'empty'),

                            //child: Text('check-out date:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 140,
                            color: Colors.white,
                            child: Text('Status:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                          ),
                          Container(
                            height: 35,
                            width: 200,
                            color: Colors.white,
                            //child: Text((snapshot.data["data"][index]['bookings'][0]['status'].toString() ?? 'empty'),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

                            // child:Text(snapshot.data?['data'][index]['bookings'].isEmpty ? 'Not booked yet!'
                            //     : snapshot.data?["data"][index]?['bookings']?[0]['status'].toString() ?? 'empty'),
                            //   child:Text(snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                            //   : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty'),

                            child:Text(snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                : snapshot.data?["data"][index]?['bookings']?[0]['pivot']['status'].toString() ?? 'empty'),
                            //child: Text('check-out date:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                          )
                        ],
                      ),

                      Row(
                        children: [
                          InkWell(
                           // onTap: doSomething,
                            onTap: () { print("Container was tapped2...."); },
                            child: SizedBox(
                              height: 35,
                              width: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                child: Text(
                                  'Action',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            // onTap: doSomething,
                            onTap: () async {
                            //  UpdatedstatusshowAlertDialog(context);


                              if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                  : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval'){
                                stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                               // stsId = snapshot.data['data'][index]['id'].toString();
                                stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                    : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                                String ApproveStr = '/Approved';
                                String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                var response = await http.get(
                                    Uri.parse(
                                        Apprvoedurl),
                                    headers: {
                                      // 'Authorization':
                                      // 'Bearer <--your-token-here-->',
                                      "Authorization": "Bearer $RetrivedBearertoekn",
                                    },
                                  );
                                  if (response.statusCode == 200) {
                                    final data1 = jsonDecode(response.body);
                                    var getpicsData = [];
                                    var picstrr = data1['data'];
                                   print('successfully Approved....');
                                    final snackBar = SnackBar(
                                      content: Text('Successfully Approved'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    return json.decode(response.body);
                                  } else {
                                    // If that call was not successful, throw an error.
                                    throw Exception('Failed to load post');
                                  }
                              }  else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                  : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved'){

                                stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                // stsId = snapshot.data['data'][index]['id'].toString();
                                stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                    : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                                String ApproveStr = '/Checked In';
                                String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                var response = await http.get(
                                  Uri.parse(
                                      Apprvoedurl),
                                  headers: {
                                    "Authorization": "Bearer $RetrivedBearertoekn",
                                  },
                                );
                                if (response.statusCode == 200) {
                                  final data1 = jsonDecode(response.body);
                                  var getpicsData = [];
                                  var picstrr = data1['data'];
                                  print('successfully checked In....');
                                  final snackBar = SnackBar(
                                    content: Text('Successfully Checked In'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  return json.decode(response.body);
                                } else {
                                  // If that call was not successful, throw an error.
                                  throw Exception('Failed to load post');
                                }

                              } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                  : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked In'){
                                stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                // stsId = snapshot.data['data'][index]['id'].toString();
                                stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                    : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                                String ApproveStr = '/Checked Out';
                                String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                var response = await http.get(
                                  Uri.parse(
                                      Apprvoedurl),
                                  headers: {
                                    // 'Authorization':
                                    // 'Bearer <--your-token-here-->',
                                    "Authorization": "Bearer $RetrivedBearertoekn",
                                  },
                                );
                                if (response.statusCode == 200) {
                                  final data1 = jsonDecode(response.body);
                                  var getpicsData = [];
                                  var picstrr = data1['data'];
                                  print('successfully checked out....');
                                  final snackBar = SnackBar(
                                    content: Text('Successfully Checked Out'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  return json.decode(response.body);
                                } else {
                                  // If that call was not successful, throw an error.
                                  throw Exception('Failed to load post');
                                }

                              } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                  : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked Out'){


                                print('checked out btn clicked.....');
                              }


                              print("Approve Container was tapped....."); },
                            child: SizedBox(
                              height: 35,
                              width: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),

                                child: Column(children:[  if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                    : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval'))
                  Text(
                    'Approve',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.green),
                  ),
                                  if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                      : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved'))
                                    Text(
                                      'Check In',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.green),
                                    ),
                                  if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                      : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked In'))
                                    Text(
                                      'Check Out',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.green),
                                    ),
                                    ])

                                //),

                                // child: Text(
                                //   'Approve',
                                //   textAlign: TextAlign.right,
                                //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.green),
                                // ),
                              ),
                            ),
                          ),

                          InkWell(
                            // onTap: doSomething,
                            onTap: () async {
                              print('clicked on declined btn...');
                             // DeclinedshowAlertDialog(context);


                              if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                  : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval'){

                                stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                // stsId = snapshot.data['data'][index]['id'].toString();
                                stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                    : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                                String ApproveStr = '/Declined';
                                String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                var response = await http.get(
                                  Uri.parse(
                                      Apprvoedurl),
                                  headers: {
                                    // 'Authorization':
                                    // 'Bearer <--your-token-here-->',
                                    "Authorization": "Bearer $RetrivedBearertoekn",
                                  },
                                );
                                if (response.statusCode == 200) {
                                  final data1 = jsonDecode(response.body);
                                  var getpicsData = [];
                                  var picstrr = data1['data'];
                                  await showDialog(
                                    context: context,
                                    builder: (context) => new AlertDialog(
                                      title: new Text('Message'),
                                      content: Text(
                                          'Successfully Declined'),
                                      actions: <Widget>[
                                        new TextButton(
                                          onPressed: () {
                                            Navigator.of(context, rootNavigator: true)
                                                .pop(); // dismisses only the dialog and returns nothing
                                          },
                                          child: new Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                  return json.decode(response.body);
                                } else {
                                  // If that call was not successful, throw an error.
                                  throw Exception('Failed to load post');
                                }
                              } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                  : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved'){
                                stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                // stsId = snapshot.data['data'][index]['id'].toString();
                                stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                    : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                                String ApproveStr = '/Declined';
                                String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                var response = await http.get(
                                  Uri.parse(
                                      Apprvoedurl),
                                  headers: {
                                    // 'Authorization':
                                    // 'Bearer <--your-token-here-->',
                                    "Authorization": "Bearer $RetrivedBearertoekn",
                                  },
                                );
                                if (response.statusCode == 200) {
                                  final data1 = jsonDecode(response.body);
                                  var getpicsData = [];
                                  var picstrr = data1['data'];
                                  print('successfully Declined....');
                                  await showDialog(
                                    context: context,
                                    builder: (context) => new AlertDialog(
                                      title: new Text('Message'),
                                      content: Text(
                                          'Successfully Declined'),
                                      actions: <Widget>[
                                        new TextButton(
                                          onPressed: () {
                                            Navigator.of(context, rootNavigator: true)
                                                .pop(); // dismisses only the dialog and returns nothing
                                          },
                                          child: new Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                  return json.decode(response.body);
                                } else {
                                  // If that call was not successful, throw an error.
                                  throw Exception('Failed to load post');
                                }
                              }

                              print("Approve Container was tapped....."); },
                            child: SizedBox(
                              height: 35,
                              width: 100,
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),

                                  child: Column(children:[  if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                      : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval'))
                                    Text(
                                      'Decline',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.red),
                                    ),
                                    if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                        : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved'))
                                      Text(
                                        'Unbook',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.red),
                                      ),

                                  ])


                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 340,
                  color: Colors.green,
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text('View More',
                          style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w800
                          ),
                          textAlign: TextAlign.center),
                    ),

//                  child: TextButton(
// // if you are not set the alignment, by default it will align center
//                     child: const Align(
//                       alignment: Alignment.center,
//                       child: Text('View More',
//                           style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w800
//                           ),
//                           textAlign: TextAlign.center),
//                     ),
//                     onPressed: () {},
//                   ),
                ),
                // image: DecorationImage(image: NetworkImage(snapshot.data["data"][index]['pictures'][0
                // ]['imageUrl']),

                //Text(snapshot.data['data'][index]['pictures'][0]['imageUrl']),
                    //Text(snapshot.data['data'][index]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),
                   // Text(Date,textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),

                    // (snapshot.data["data"][index]['bookings'][0
                    // ]['id'])

              //       Text(snapshot.data["data"][index]['bookings'][0
              // ]['date'] ?? ""),
                    // Text((snapshot.data["data"][index]['bookings'][0]['reference'])),

                  // API = (snapshot.data["data"][index]);
                  //APIdata = (snapshot.data['data']),
      // for(){
      //
      // }

      // for (var record in APIdata) {
      //           idnum = record['id'];
      //           var pictures = record['pictures'];
      //           for (var picid in pictures) {
      //             aptId = picid['apartmentId'];
      //           }
      //           print(Bookable_iD);
      //           // if (aptId == Bookable_iD) {
      //           //   for (var pics in pictures) {
      //           //     print(pics);
      //           //     getpicsData.add(pics);
      //           //     print(getpicsData);
      //           //   }
      //           // }
      //
      //         }
                   // for()
                   // Text((snapshot.data["data"].)),

                    //title: json['items'].isEmpty ? 'No new allergy alerts' : json['items'][0]['title'],
                    //Text((snapshot.data['data'].isEmpty ?? 'novalues' snapshot.data['data'].isEmpty ?? 'novalues' )),


                    //title: json['items'].isEmpty ? 'No new allergy alerts' : json['items'][0]['title'],


                  ],
                ),
                  onTap: () async{

                    if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                        : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval' || (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                        : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved' || (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                        : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked In' || (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                        : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked Out'){


                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                 print('booking id...');
                                 print(snapshot.data['data'][index]['id']);
                      prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                      prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                   prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
                      prefs.setString('tokenkey', RetrivedBearertoekn);


                                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                    builder: (_) => PivotDashboard(),
                                  ),);

                  } else {
                    print('failure....');
                    final snackBar = SnackBar(
                      content: Text('Not booked yet!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  },
              ),
              );
            //return  Text('Some text');
            }),

            Column(
            children:<Widget>[
            Text('second test'),
            ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context,index){
            return  Text(' Vehicles',style: TextStyle(fontSize: 22),);
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
    // onTap: ()async{
    //
    //
    // print('View more Tapped button.....');
    //           SharedPreferences prefs = await SharedPreferences.getInstance();
    //          print('booking id...');
    //          print(bookingID);
    //           // prefs.setString('citykey', snapshot.data['data'][index]['city']);
    //            //prefs.setInt('imgkeyId', snapshot.data['data'][index]['id']);
    //           // bookingID = snapshot.data['data'][index]['address'];
    //           Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
    //             builder: (_) => PivotDashboard(),
    //           ),);
    // }
    //);



                  //return Column(
                  // return Column(
                  //   children: <Widget>[
                  //     Expanded(
                  //       child: Container(
                  //         color: Colors.white,
                  //         child: LayoutBuilder(
                  //           builder: (context, constraint) {
                  //             return SingleChildScrollView(
                  //               child: Container(
                  //                 constraints:
                  //                 BoxConstraints(minHeight: constraint.maxHeight),
                  //                 child: IntrinsicHeight(
                  //                   child: Column(
                  //                     children: [
                  //                       // SizedBox(
                  //                       //   height: 10,
                  //                       // ),
                  //                       Column(
                  //                           children: [
                  //                             Column(
                  //                                 children: [
                  //                                   Padding(
                  //                                     padding: const EdgeInsets.all(8.0),
                  //                                     child: Container(
                  //                                       height: 250,
                  //
                  //                                       child:ListView.separated(
                  //                                         itemCount: (snapshot.data as List<DashboardApart>).length,
                  //                                         separatorBuilder: (BuildContext context, int index) => const Divider(),
                  //                                         itemBuilder: (BuildContext context, int index) {
                  //                                           var abisiniyapic = (snapshot.data as List<DashboardApart>)[index];
                  //                                           //var listData = (snapshot.data as List<DashboardApart>)[index];
                  //
                  //
                  //                                           return Container(
                  //                                             height: 220,
                  //                                             width: 300,
                  //                                             color: Colors.yellow,
                  //                                             child: InkWell(
                  //                                               child: Column(
                  //                                                 children: [
                  //                                                   Container(
                  //                                                     height: 200,
                  //                                                     child: Text(abisiniyapic.address),
                  //                                                     // decoration: BoxDecoration(
                  //                                                     //     image: DecorationImage(image: NetworkImage(abisiniyapic.address),
                  //                                                     //         fit: BoxFit.cover)
                  //                                                     // ),
                  //                                                   ),
                  //                                                 ],
                  //                                               ),
                  //                                               onTap: ()
                  //                                               {
                  //                                                 print('calling.......');
                  //                                                 print([index]);
                  //                                               },
                  //                                             ),
                  //                                           );
                  //                                         },
                  //                                       ),
                  //
                  //                                     ),
                  //                                   ),
                  //                                   Container(
                  //                                     height: 40,
                  //                                     width: 340,
                  //                                     alignment: Alignment.topLeft,
                  //                                     color: Colors.white,
                  //                                     child: Text('Information',style: (TextStyle(fontSize: 22,fontWeight: FontWeight.w900,color: Colors.black)),),
                  //                                   )
                  //                                   // Container(
                  //                                   //   height: 50,
                  //                                   //   width: 280,
                  //                                   //   color: Colors.orange,
                  //                                   //   // child:Text(snapshot.data['data'][10]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),
                  //                                   // ),
                  //                                 ]
                  //                             ),
                  //                           ]
                  //                       ),
                  //                       // middle widget goes here
                  //
                  //
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // );
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
