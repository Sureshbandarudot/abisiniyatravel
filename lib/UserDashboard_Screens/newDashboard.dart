
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
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import '../Auth/profileUpdateVC.dart';
import '../MyBookings/MybookingVC.dart';
import '../My_Apartments/MyVehicles/MyvehicleVC.dart';
import '../ServiceDasboardVC.dart';
import '../flyScreens/MyflightRequest.dart';
import 'Vehicle_PivoteVC.dart';
//import 'NewUserbooking.dart';
class newuserDashboard extends StatefulWidget {
  const newuserDashboard({super.key});

  @override
  State<newuserDashboard> createState() => _userDashboardState();
}

class _userDashboardState extends State<newuserDashboard> {
  final baseDioSingleton = BaseSingleton();
  int bookingID = 0;
  int visitorCnt = 0;

  String LoggedInUser = 'LoggedUser';

  String LoggedInUSerstr = '';
  String NewBookingUserstr = '';
  String profileNamestr = '';
  String Retrivedprofilestr = '';
  String profileEmailstr = '';
  String RetrivedEmailstr = '';
  String profilephonestr = '';
  String profilefirstnamestr = '';
  String profilesurnamestr = '';
  String profileaddresstr = '';
  String profilecountrystr = '';

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
      Retrivedprofilestr = prefs.getString('profileuserKey') ?? "";
      RetrivedEmailstr = prefs.getString('profileemailKey') ?? "";
      print('retrived profile...');
      print(Retrivedprofilestr);
      prefs.setString('Property_type', ('Apartment'));
    });
  }
//@override
  void initState()  {
    // TODO: implement initState
    super.initState();
    getData();
    VehiclegetData();

    Profile();
    _retrieveValues();
    print('calling profile values...');
    // SharedPreferences prefs = SharedPreferences.getInstance();
    // Retrivedprofilestr = prefs.getString('profileuserKey') ?? "";
    // RetrivedEmailstr = prefs.getString('profileemailKey') ?? "";

    print(Retrivedprofilestr);
    BookingDashboardUsers = DashboardBooking_fetchUsers();
    //pics = fetchpics();
  }
  // String url = 'https://staging.abisiniya.com/api/v1/apartment/list';
  // String url = baseDioSingleton.AbisiniyaBaseurl+ 'apartment/list';

  Future<List<DashboardApart>> DashboardBooking_fetchUsers() async {
    String url = baseDioSingleton.AbisiniyaBaseurl+ 'apartment/list';

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
    // String url = 'https://staging.abisiniya.com/api/v1/booking/apartment/withbooking';
      String url = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/withbooking';

      var response = await http.get(
      Uri.parse(
          url),
      headers: {
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

  //Future<dynamic> Profile() async {
    //Profile() async {
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
      print('profile data....');
      print(data1);
      profileNamestr = data1['data'][0]['name'] +'\n ' + data1['data'][0]['surname'] ;
      profileEmailstr = data1['data'][0]['email'];


      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<dynamic> VehiclegetData() async {
    // String url = 'https://staging.abisiniya.com/api/v1/booking/vehicle/withbooking';
    String url = baseDioSingleton.AbisiniyaBaseurl + 'booking/vehicle/withbooking';

    var response = await http.get(
      Uri.parse(
          url),
      headers: {
        "Authorization": "Bearer $RetrivedBearertoekn",
      },
    );
    if (response.statusCode == 200) {
      print('vehicle booking.......');
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
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          onPressed: () async{
            print("back Pressed");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // prefs.setString('logoutkey', ('LogoutDashboard'));
            //prefs.setString('Property_type', ('Apartment'));
             prefs.setString('LoggedinUserkey', LoggedInUser);


            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServiceDashboardScreen()),
            );
    },),
        title: Text('Dashboard',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
      ),
      endDrawer: Drawer(
          child:FutureBuilder<dynamic> (
            future: Profile(),
            builder: (context, snapshot) {
    //builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      profileNamestr = snapshot.data['data'][0]['name'] +' ' + snapshot.data['data'][0]['surname'] ;
      print(profileNamestr);
      profileEmailstr = snapshot.data['data'][0]['email'];
      visitorCnt = snapshot.data['visitorCount'];
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    //child: Text('Categories', style: TextStyle(color: Colors.white)),
                    decoration: BoxDecoration(color: Color(0xffffff
                    ),),
                    padding: EdgeInsets.fromLTRB(10,30,10,10),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Column(
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  child: Container(
                                    width: 300,
                                    height: 30,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(profileNamestr,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w900,color: Colors.black54),),
                                        SizedBox(width: 50,),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.edit,

                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () async{
                                    print("click on user profile");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => profileUpdatescreen()),
                                    );
                                    SharedPreferences prefs = await SharedPreferences.getInstance();

                                    print('first name...');
                                    print(profileEmailstr);
                                    profilefirstnamestr = snapshot.data['data'][0]['name'] ?? '';
                                    profilesurnamestr = snapshot.data['data'][0]['surname'] ?? '';
                                     profilephonestr = snapshot.data['data'][0]['phone'] ?? '';
                                     profileEmailstr = snapshot.data['data'][0]['email'] ?? '';
                                     profileaddresstr = snapshot.data['data'][0]['address'] ?? '';
                                    profilecountrystr = snapshot.data['data'][0]['country'] ?? '';
                                     prefs.setString('profilenamekey', profilefirstnamestr);
                                    prefs.setString('profilesurnamekey', profilesurnamestr);
                                     prefs.setString('profilephonekey', profilephonestr);
                                     prefs.setString('profile_emailkey', profileEmailstr);
                                     prefs.setString('profile_addresskey', profileaddresstr);
                                     prefs.setString('profile_countrykey', profilecountrystr);
                                  },
                                ),

                                InkWell(
                                  child: Container(
                                    width: 300,
                                    height: 40,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(profileEmailstr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black54),),
                                        SizedBox(width: 20,),
                                        Align(
                                          alignment: Alignment.center,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {print("click on user profile");},
                                ),
                                InkWell(
                                  child: Container(
                                    width: 300,
                                    height: 40,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Total Visitors :',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black54),),
                                          ],
                                        ),
                                         SizedBox(width: 20,),
                                        Row(
                                          children: [
                                            Text(visitorCnt.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black54),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {print("click on user profile");},
                                ),
                              ],
                            )
                          ],
                        )
                      ],
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
                      //Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyVehicleScreen()),
                      );
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
                      // print(NewBookingUserstr);
                    },
                  ),
                ],
              );
            },
          )
      ),
    body: FutureBuilder<dynamic>(
    //future: BookingDashboardUsers,
          future: getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Logged In success');
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
              Text('Logged In User'),
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
              //('Logged In User',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),

              Text('Your Apartments',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              Container(

                child:Text(snapshot.data?['data'].isEmpty ? 'Apartments not available' : '',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.red),),
                // : snapshot.data?["data"]?.toString() ?? 'empty',style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)))
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
               bookingID = snapshot.data['data'][index]['id'];
//    itemBuilder: (context,index){
              return Container(
                height: 250,
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
                                    : snapshot.data?["data"][index]?['name']?.toString() ?? 'empty',style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black))),
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
                                child:Text(snapshot.data['data'][index]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)),),
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
                                child:Text(snapshot.data['data'][index]['city'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)),),
                                // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                Container(
                  height: 110,
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
                            child:Text(snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                : snapshot.data?["data"][index]?['bookings']?[0]['pivot']['status'].toString() ?? 'empty'),
                            //child: Text('check-out date:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                          )
                        ],
                      ),

                  //     Row(
                  //       children: [
                  //         InkWell(
                  //          // onTap: doSomething,
                  //           onTap: () { print("Container was tapped2...."); },
                  //           child: SizedBox(
                  //             height: 35,
                  //             width: 100,
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                   border: Border.all(color: Colors.white)),
                  //               child: Text(
                  //                 'Action',
                  //                 textAlign: TextAlign.left,
                  //                 style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         InkWell(
                  //           // onTap: doSomething,
                  //           onTap: () async {
                  //           //  UpdatedstatusshowAlertDialog(context);
                  //             if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                 : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval'){
                  //               // stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                  //               stsbaseurl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/';
                  //
                  //               // stsId = snapshot.data['data'][index]['id'].toString();
                  //               stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                   : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                  //               String ApproveStr = '/Approved';
                  //               String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                  //               var response = await http.get(
                  //                   Uri.parse(
                  //                       Apprvoedurl),
                  //                   headers: {
                  //                     // 'Authorization':
                  //                     // 'Bearer <--your-token-here-->',
                  //                     "Authorization": "Bearer $RetrivedBearertoekn",
                  //                   },
                  //                 );
                  //                 if (response.statusCode == 200) {
                  //                   final data1 = jsonDecode(response.body);
                  //                   var getpicsData = [];
                  //                   var picstrr = data1['data'];
                  //                  print('successfully Approved....');
                  //                   final snackBar = SnackBar(
                  //                     content: Text('Successfully Approved'),
                  //                   );
                  //                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //                   return json.decode(response.body);
                  //                 } else {
                  //                   // If that call was not successful, throw an error.
                  //                   throw Exception('Failed to load post');
                  //                 }
                  //             }  else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                 : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved'){
                  //
                  //               // stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                  //               stsbaseurl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/';
                  //
                  //               // stsId = snapshot.data['data'][index]['id'].toString();
                  //               stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                   : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                  //               String ApproveStr = '/Checked In';
                  //               String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                  //               var response = await http.get(
                  //                 Uri.parse(
                  //                     Apprvoedurl),
                  //                 headers: {
                  //                   "Authorization": "Bearer $RetrivedBearertoekn",
                  //                 },
                  //               );
                  //               if (response.statusCode == 200) {
                  //                 final data1 = jsonDecode(response.body);
                  //                 var getpicsData = [];
                  //                 var picstrr = data1['data'];
                  //                 print('successfully checked In....');
                  //                 final snackBar = SnackBar(
                  //                   content: Text('Successfully Checked In'),
                  //                 );
                  //                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //                 return json.decode(response.body);
                  //               } else {
                  //                 // If that call was not successful, throw an error.
                  //                 throw Exception('Failed to load post');
                  //               }
                  //
                  //             } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                 : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked In'){
                  //               // stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                  //               stsbaseurl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/';
                  //
                  //               // stsId = snapshot.data['data'][index]['id'].toString();
                  //               stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                   : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                  //               String ApproveStr = '/Checked Out';
                  //               String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                  //               var response = await http.get(
                  //                 Uri.parse(
                  //                     Apprvoedurl),
                  //                 headers: {
                  //                   // 'Authorization':
                  //                   // 'Bearer <--your-token-here-->',
                  //                   "Authorization": "Bearer $RetrivedBearertoekn",
                  //                 },
                  //               );
                  //               if (response.statusCode == 200) {
                  //                 final data1 = jsonDecode(response.body);
                  //                 var getpicsData = [];
                  //                 var picstrr = data1['data'];
                  //                 print('successfully checked out....');
                  //                 final snackBar = SnackBar(
                  //                   content: Text('Successfully Checked Out'),
                  //                 );
                  //                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //                 return json.decode(response.body);
                  //               } else {
                  //                 // If that call was not successful, throw an error.
                  //                 throw Exception('Failed to load post');
                  //               }
                  //
                  //             } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                 : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked Out'){
                  //             }
                  //             print("Approve Container was tapped....."); },
                  //           child: SizedBox(
                  //             height: 35,
                  //             width: 100,
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                   border: Border.all(color: Colors.white)),
                  //               child: Column(children:[  if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                   : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval'))
                  // Text(
                  //   'Approve',
                  //   textAlign: TextAlign.right,
                  //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.green),
                  // ),
                  //                 if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved'))
                  //                   Text(
                  //                     'Check In',
                  //                     textAlign: TextAlign.right,
                  //                     style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.green),
                  //                   ),
                  //                 if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked In'))
                  //                   Text(
                  //                     'Check Out',
                  //                     textAlign: TextAlign.right,
                  //                     style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.green),
                  //                   ),
                  //                   ])
                  //             ),
                  //           ),
                  //         ),
                  //
                  //         InkWell(
                  //           // onTap: doSomething,
                  //           onTap: () async {
                  //             print('clicked on declined btn...');
                  //            // DeclinedshowAlertDialog(context);
                  //             if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                 : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval'){
                  //               // stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                  //               stsbaseurl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/';
                  //
                  //               // stsId = snapshot.data['data'][index]['id'].toString();
                  //               stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                   : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                  //               String ApproveStr = '/Declined';
                  //               String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                  //               var response = await http.get(
                  //                 Uri.parse(
                  //                     Apprvoedurl),
                  //                 headers: {
                  //                   // 'Authorization':
                  //                   // 'Bearer <--your-token-here-->',
                  //                   "Authorization": "Bearer $RetrivedBearertoekn",
                  //                 },
                  //               );
                  //               if (response.statusCode == 200) {
                  //                 final data1 = jsonDecode(response.body);
                  //                 var getpicsData = [];
                  //                 var picstrr = data1['data'];
                  //                 await showDialog(
                  //                   context: context,
                  //                   builder: (context) => new AlertDialog(
                  //                     title: new Text('Message'),
                  //                     content: Text(
                  //                         'Successfully Declined'),
                  //                     actions: <Widget>[
                  //                       new TextButton(
                  //                         onPressed: () {
                  //                           Navigator.of(context, rootNavigator: true)
                  //                               .pop(); // dismisses only the dialog and returns nothing
                  //                         },
                  //                         child: new Text('OK'),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 );
                  //                 return json.decode(response.body);
                  //               } else {
                  //                 // If that call was not successful, throw an error.
                  //                 throw Exception('Failed to load post');
                  //               }
                  //             } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                 : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved'){
                  //               // stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                  //               stsbaseurl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/';
                  //
                  //               // stsId = snapshot.data['data'][index]['id'].toString();
                  //               stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                   : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                  //               String ApproveStr = '/Declined';
                  //               String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                  //               var response = await http.get(
                  //                 Uri.parse(
                  //                     Apprvoedurl),
                  //                 headers: {
                  //                   // 'Authorization':
                  //                   // 'Bearer <--your-token-here-->',
                  //                   "Authorization": "Bearer $RetrivedBearertoekn",
                  //                 },
                  //               );
                  //               if (response.statusCode == 200) {
                  //                 final data1 = jsonDecode(response.body);
                  //                 var getpicsData = [];
                  //                 var picstrr = data1['data'];
                  //                 print('successfully Declined....');
                  //                 await showDialog(
                  //                   context: context,
                  //                   builder: (context) => new AlertDialog(
                  //                     title: new Text('Message'),
                  //                     content: Text(
                  //                         'Successfully Declined'),
                  //                     actions: <Widget>[
                  //                       new TextButton(
                  //                         onPressed: () {
                  //                           Navigator.of(context, rootNavigator: true)
                  //                               .pop(); // dismisses only the dialog and returns nothing
                  //                         },
                  //                         child: new Text('OK'),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 );
                  //                 return json.decode(response.body);
                  //               } else {
                  //                 // If that call was not successful, throw an error.
                  //                 throw Exception('Failed to load post');
                  //               }
                  //             }
                  //
                  //             print("Approve Container was tapped....."); },
                  //           child: SizedBox(
                  //             height: 35,
                  //             width: 100,
                  //             child: Container(
                  //                 decoration: BoxDecoration(
                  //                     border: Border.all(color: Colors.white)),
                  //
                  //                 child: Column(children:[  if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval'))
                  //                   Text(
                  //                     'Decline',
                  //                     textAlign: TextAlign.right,
                  //                     style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.red),
                  //                   ),
                  //                   if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                  //                       : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved'))
                  //                     Text(
                  //                       'Unbook',
                  //                       textAlign: TextAlign.right,
                  //                       style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.red),
                  //                     ),
                  //
                  //                 ])
                  //
                  //
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
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
                ),
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
                FutureBuilder<dynamic>(
                  future: VehiclegetData(),
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
      //return SingleChildScrollView(
      //scrollDirection: Axis.horizontal,
      //physics: ScrollPhysics(),

      return Column(
              children: [
                SizedBox(height: 30,),
            Text('Your Vehicles',style: TextStyle(fontSize: 22,fontWeight:FontWeight.w600),),

                Container(
                  // color: Colors.blueGrey,
                  // child:Text(snapshot.data?['data'].isEmpty ? 'Vehicles not available' : ''),
                  child:Text(snapshot.data?['data'].isEmpty ? 'Vehicles not available' : '',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.red),),

                  // : snapshot.data?["data"]?.toString() ?? 'empty',style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)))
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
                      bookingID = snapshot.data['data'][index]['id'];
//    itemBuilder: (context,index){

                      return Container(
                        height: 320,
                        width: 100,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: InkWell(
                          child: Column(
                            children: [
                              Container(
                                height: 120,
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
                                          child: Text('Make:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 200,
                                          color: Colors.black12,
                                          //child:Text(snapshot.data['data'][index]['name'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.green)),),

                                          child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                              : snapshot.data?["data"][index]?['make']?.toString() ?? 'empty',style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black))),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 140,
                                          color: Colors.black12,
                                          child: Text('Model:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 200,
                                          color: Colors.black12,
                                          //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          child:Text(snapshot.data['data'][index]['model'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)),),
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
                                          child:Text(snapshot.data['data'][index]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)),),
                                          // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
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
                                          //child:Text(snapshot.data['data'][index]['name'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.green)),),

                                          child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                              : snapshot.data?["data"][index]?['city']?.toString() ?? 'empty',style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black))),
                                        )
                                      ],
                                    ),

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
                                              // stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                              stsbaseurl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/';

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

                                              // stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                              stsbaseurl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/';

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
                                              // stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                              stsbaseurl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/';

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
                                             // stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                              stsbaseurl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/';

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
                                              // stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                              stsbaseurl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/';

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
                              ),
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
                              prefs.setString('makekey', snapshot.data['data'][index]['make']);
                              prefs.setString('modelkey', snapshot.data['data'][index]['model']);
                              prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                              prefs.setString('citykey', snapshot.data['data'][index]['city']);
                              prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
                              prefs.setString('tokenkey', RetrivedBearertoekn);
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                builder: (_) => Vehicle_PivoteDashboard(),
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
                    })



            // ListView.separated(
            //         physics: NeverScrollableScrollPhysics(),
            //         shrinkWrap: true,
            //         itemCount: snapshot.data['data'].length ?? '',
            //         //itemCount: snapshot.data?['data']['bookings'].length ?? "" ,
            //         //itemCount: snapshot.data!['data'][0]['bookings'][0].length ?? 0,
            //         //itemCount: snapshot.data?.length ?? 0,
            //         separatorBuilder: (BuildContext context, int index) => const Divider(),
            //         itemBuilder: (BuildContext context, int index) {
            //
            //           Container(
            //             height: 90,
            //             width: 340,
            //             color: Colors.black12,
            //             child: Column(
            //               children: [
            //                 Row(
            //                   children: [
            //                     Container(
            //                       height: 30,
            //                       width: 140,
            //                       color: Colors.black12,
            //                       child: Text('Make:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            //                     ),
            //                     Container(
            //                       height: 30,
            //                       width: 200,
            //                       color: Colors.black12,
            //                       //child:Text(snapshot.data['data'][index]['name'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.green)),),
            //
            //                       child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
            //                           : snapshot.data?["data"][index]?['make']?.toString() ?? 'empty',style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black))),
            //                     )
            //                   ],
            //                 ),
            //                 Row(
            //                   children: [
            //                     Container(
            //                       height: 30,
            //                       width: 140,
            //                       color: Colors.black12,
            //                       child: Text('Model:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            //                     ),
            //                     Container(
            //                       height: 30,
            //                       width: 200,
            //                       color: Colors.black12,
            //                       //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            //                       child:Text(snapshot.data['data'][index]['model'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)),),
            //                     )
            //                   ],
            //                 ),
            //                 Row(
            //                   children: [
            //                     Container(
            //                       height: 30,
            //                       width: 140,
            //                       color: Colors.black12,
            //                       child: Text('Address:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            //                     ),
            //                     Container(
            //                       height: 30,
            //                       width: 200,
            //                       color: Colors.black12,
            //                       child:Text(snapshot.data['data'][index]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)),),
            //                       // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            //                     )
            //                   ],
            //                 )
            //               ],
            //             ),
            //           );
            //         }),

              ],
            );
          }
      }
    }
                )
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
    );
  }
}
