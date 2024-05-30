
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
import 'package:tourstravels/UserDashboard_Screens/newDashboard.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/My_Apartments/My_AprtmetsVC.dart';
import 'package:tourstravels/My_Apartments/ViewApartmentVC.dart';

// import 'CreateVehicleVC.dart';
// import 'VehicleViewVC.dart';
// import 'Vehicle_EditVC.dart';

import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';

import 'AddlocationstopVC.dart';
import 'BuslocationViewVC.dart';
import 'locationEditVC.dart';
// import 'Apartment_EditVC.dart';
// import 'CreateApartmentVC.dart';
//import 'NewUserbooking.dart';
class MybusLocationStopscreen extends StatefulWidget {
  const MybusLocationStopscreen({super.key});

  @override
  State<MybusLocationStopscreen> createState() => _userDashboardState();
}

class _userDashboardState extends State<MybusLocationStopscreen> {
  final baseDioSingleton = BaseSingleton();

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
  int BusID = 0;
  int locationID = 0;
  var controller = ScrollController();
  late Future<List<DashboardApart>> BookingDashboardUsers ;
  int count = 15;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      RetrivedEmail = prefs.getString('emailkey') ?? "";
      RetrivedPwd = prefs.getString('passwordkey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      BusID = prefs.getInt('userbusId') ?? 0;
      print('BusID id---');
      print(BusID);
      print('loc token');
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
  Future<void> _deleteData(int ApartmentId) async {
    try {
      print('delete url...');
      print('bus id for Delete...');
      print(BusID);
      var url = '';
      // url = ('https://staging.abisiniya.com/api/v1/vehicle/delete/BusID');
      url = (baseDioSingleton.AbisiniyaBaseurl + 'bus/delete/$BusID');
      print(url);
      final response = await http
          .delete(Uri.parse(url),
        headers: {
          "Authorization": "Bearer $RetrivedBearertoekn",
        },
      );

      if (response.statusCode == 200) {
        print('bus Deleted successfully');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MybusLocationStopscreen()
          ),
        );
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (error) {
      print(error);
    }
  }
  Future<dynamic> getData() async {
    // String url = 'https://staging.abisiniya.com/api/v1/vehicle/auth/list';
    String url = baseDioSingleton.AbisiniyaBaseurl + 'bus/buslocation/list';

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
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          onPressed: () async{
            print("back Pressed");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => newuserDashboard()),
            );
          },

        ),
        // iconTheme: IconThemeData(
        //     color: Colors.green,
        // ),
        title: Text('My Locations',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

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
                  return Column(
                    children: <Widget>[
                      //Container(color: Colors.red, height: 50),
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
                                  child: Text('Add Bus/Stops',
                                      style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w800
                                      ),
                                      textAlign: TextAlign.center),
                                ),

                              ),
                              onTap: () async {
                                print("Tapped on container");
                                print(RetrivedBearertoekn);
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('logoutkey', ('LogoutDashboard'));
                                prefs.setString('Property_type', ('Apartment'));
                                prefs.setString('tokenkey',RetrivedBearertoekn );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddBusLocationVC()),
                                );
                              },
                            )],
                        ),
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
                                    Text('Locations',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                                    ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data['data'].length ?? '',
                                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                                        itemBuilder: (BuildContext context, int index) {
                                          bookingID = snapshot.data['data'][index]['id'];
                                          return Container(
                                            height: 50,
                                            width: 50,
                                            alignment: Alignment.center,
                                            color: Colors.white,
                                            child: InkWell(

                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                                                    height: 50,
                                                    width: 320,
                                                    color: Colors.black12,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          margin: const EdgeInsets.only(top: 10.0, right: 0.0),

                                                          height: 45,
                                                          width: 120,
                                                          child: Text(snapshot.data['data'][index]['buslocation'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                        ),
                                                        Container(
                                                          height: 45,
                                                          width: 200,

                                                          child: Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  InkWell(
                                                                    child: Container(
                                                                      width: 55,
                                                                      color: Colors.cyan,
                                                                      child: Text('View',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
                                                                    ),
                                                                    onTap: () async{
                                                                      print("value of your text");
                                                                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                                        builder: (_) => BusLocationViewVC(),
                                                                      ),);
                                                                      print(snapshot.data['data'][index]['id']);
                                                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                      prefs.setInt('buslocationIDkey', snapshot.data['data'][index]['id']);
                                                                      prefs.setString('buslocationkey', snapshot.data['data'][index]['buslocation']);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  InkWell(
                                                                    child: Container(
                                                                      width: 55,
                                                                      color: Colors.green,
                                                                      child: Text('Edit',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
                                                                    ),
                                                                    onTap: () async{
                                                                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                                        builder: (_) => BusLocationEditVC(),
                                                                      ),);
                                                                      print(snapshot.data['data'][index]['id']);
                                                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                      prefs.setInt('buslocationIDkey', snapshot.data['data'][index]['id']);
                                                                      prefs.setString('buslocationkey', snapshot.data['data'][index]['buslocation']);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),

                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  InkWell(
                                                                    child: Container(
                                                                      width: 55,
                                                                      color: Colors.red,
                                                                      child: Text('Delete',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
                                                                    ),
                                                                    onTap: () async{
                                                                      print("value of your text");
                                                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                      print(snapshot.data['data'][index]['id']);
                                                                      locationID = snapshot.data['data'][index]['id'];
                                                                      prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
                                                                      prefs.setString('tokenkey', RetrivedBearertoekn);
                                                                      try{
                                                                        print('delete url...');
                                                                        var url = '';
                                                                        // url = ('https://staging.abisiniya.com/api/v1/apartment/delete/$ApartmentId'
                                                                        url = (baseDioSingleton.AbisiniyaBaseurl + 'bus/buslocation/delete/$locationID');
                                                                        print(url);
                                                                        final response = await http
                                                                            .delete(Uri.parse(url),
                                                                          headers: {
                                                                            // 'Authorization':
                                                                            // 'Bearer <--your-token-here-->',
                                                                            "Authorization": "Bearer $RetrivedBearertoekn",
                                                                          },
                                                                        );

                                                                        if (response.statusCode == 200) {
                                                                          print('location Deleted successfully');
                                                                          Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => MybusLocationStopscreen()
                                                                            ),
                                                                          );
                                                                        } else {
                                                                          throw Exception('Failed to delete data');
                                                                        }
                                                                      } catch (error) {
                                                                        print(error);
                                                                      }
                                                                    },
                                                                    // onTap: () async{
                                                                    //   print("value of your text");
                                                                    //   // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                                    //   //   builder: (_) => BusEdit(),
                                                                    //   // ),);
                                                                    //   SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                    //   prefs.setString('modelkey', snapshot.data['data'][index]['model']);
                                                                    // },
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
                                              onTap: () async{

                                              },
                                            ),
                                          );
                                          //return  Text('Some text');
                                        }),

                                    Column(
                                      children:<Widget>[
                                        //Text('second test'),
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
    );
  }
}
