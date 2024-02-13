
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


//import 'NewUserbooking.dart';
class ViewBookingscreen extends StatefulWidget {
  // const MyApartmentScreen({super.key});

  @override
  State<ViewBookingscreen> createState() => _userDashboardState();
}

class _userDashboardState extends State<ViewBookingscreen> {
  int bookingID = 0;
  String Referencestr = '';

  String RetrivedBearertoekn = '';
  String Bookingsts = 'Not booked yet!';
  int ApartmentId = 0;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // RetrivedEmail = prefs.getString('emailkey') ?? "";
      // RetrivedPwd = prefs.getString('passwordkey') ?? "";
      Referencestr = prefs.getString('referencekey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      bookingID = prefs.getInt('userbookingId') ?? 0;
      print('bookingID id---');
      print(bookingID);
      print('My Apartment token');
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
    //String url = 'https://staging.abisiniya.com/api/v1/apartment/list';
    String url = 'https://staging.abisiniya.com/api/v1/booking/apartment/mybookingdetail/$bookingID';
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
        leading: Padding(
          // padding: const EdgeInsets.all(0.0),
          padding: EdgeInsets.only(left: 15.0, top: 0.0),
          child: Image.asset(
            "images/logo.jpg",
          ),),
        title: Text('ABISINIYA',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
        iconTheme: IconThemeData(color: Colors.green),),
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
                        height: 10,
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
                                Column(
                                children: <Widget>[
                                  //Container(color: Colors.red, height: 50),
                                  Container(
                                  height: 190,
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
                                            child: Text('Fullname:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          ),
                                          Container(
                                              height: 30,
                                              width: 200,
                                              color: Colors.transparent,
                                              child:Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                        : snapshot.data?["data"]['booking'][0]['customerDetail']?['name'].toString()
                                                        ?? 'empty') + (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                        : snapshot.data?["data"]['booking'][0]['customerDetail']?['surname'].toString()
                                                        ?? 'empty'),
                                                    style: TextStyle(
                                                        color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                  )
                                              )
                                            // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          )
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 140,
                                            color: Colors.transparent,
                                            child: Text('Email:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          ),
                                          Container(
                                              height: 30,
                                              width: 200,
                                              color: Colors.transparent,
                                              child:Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                        : snapshot.data?["data"]['booking'][0]['customerDetail']?['email'].toString()
                                                        ?? 'empty'),
                                                    style: TextStyle(
                                                        color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                  )
                                              )
                                            // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 140,
                                            color: Colors.transparent,
                                            child: Text('Phone:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          ),
                                          Container(
                                              height: 30,
                                              width: 200,
                                              color: Colors.transparent,
                                              child:Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                        : snapshot.data?["data"]['booking'][0]['customerDetail']?['phone'].toString()
                                                        ?? 'empty'),
                                                    style: TextStyle(
                                                        color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                  )
                                              )
                                            // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          )
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 140,
                                            color: Colors.transparent,
                                            child: Text('Start Date:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          ),
                                          Container(
                                              height: 30,
                                              width: 200,
                                              color: Colors.transparent,
                                              child:Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                        : snapshot.data?["data"]['booking'][0]['checkIn'].toString()
                                                        ?? 'empty'),
                                                    style: TextStyle(
                                                        color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                  )
                                              )
                                            // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          )
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 140,
                                            color: Colors.transparent,
                                            child: Text('End Date:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          ),
                                          Container(
                                              height: 30,
                                              width: 200,
                                              color: Colors.transparent,
                                              child:Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                        : snapshot.data?["data"]['booking'][0]['checkOut'].toString()
                                                        ?? 'empty'),
                                                    style: TextStyle(
                                                        color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                  )
                                              )
                                            // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          )
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 140,
                                            color: Colors.transparent,
                                            child: Text('Payment Status:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          ),
                                          Container(
                                              height: 30,
                                              width: 200,
                                              color: Colors.transparent,
                                              child:Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                        : snapshot.data?["data"]['booking'][0]['customerDetail']?['Payment Status'].toString()
                                                        ?? 'empty'),
                                                    style: TextStyle(
                                                        color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                  )
                                              )
                                            // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Text('Apartments booked',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),


                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 140,
                                          color: Colors.transparent,
                                          child: Text('Owner:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                          height: 60,
                                          width: 200,
                                          color: Colors.transparent,
                                            child:Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                      : snapshot.data?["data"]['booking'][0]['ownerDetail']?['name'].toString()
                                                      ?? 'empty') + '\n' +  (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                      : snapshot.data?["data"]['booking'][0]['ownerDetail']?['email'].toString()
                                                      ?? 'empty'),
                                                  style: TextStyle(
                                                      color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                )
                                            )
                                          // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 140,
                                          color: Colors.transparent,
                                          child: Text('Phone:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                            height: 30,
                                            width: 200,
                                            color: Colors.transparent,
                                            child:Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                      : snapshot.data?["data"]['booking'][0]['ownerDetail']?['phone'].toString()
                                                      ?? 'empty'),
                                                  style: TextStyle(
                                                      color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                )
                                            )
                                          // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        )
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 140,
                                          color: Colors.transparent,
                                          child: Text('Address:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                            height: 30,
                                            width: 200,
                                            color: Colors.transparent,
                                            child:Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                      : snapshot.data?["data"]['booking'][0]['ownerDetail']?['address'].toString()
                                                      ?? 'empty'),
                                                  style: TextStyle(
                                                      color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                )
                                            )
                                          // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        )
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 140,
                                          color: Colors.transparent,
                                          child: Text('City:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                            height: 30,
                                            width: 200,
                                            color: Colors.transparent,
                                            child:Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                      : snapshot.data?["data"]['booking'][0]['ownerDetail']?['city'].toString()
                                                      ?? 'empty'),
                                                  style: TextStyle(
                                                      color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                )
                                            )
                                          // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 140,
                                          color: Colors.transparent,
                                          child: Text('Check In:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                            height: 30,
                                            width: 200,
                                            color: Colors.transparent,
                                            child:Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                      : snapshot.data?["data"]['booking'][0]['checkIn'].toString()
                                                      ?? 'empty'),
                                                  style: TextStyle(
                                                      color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                )
                                            )
                                          // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        )
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 140,
                                          color: Colors.transparent,
                                          child: Text('Check Out:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                            height: 30,
                                            width: 200,
                                            color: Colors.transparent,
                                            child:Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                      : snapshot.data?["data"]['booking'][0]['checkOut'].toString()
                                                      ?? 'empty'),
                                                  style: TextStyle(
                                                      color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                )
                                            )
                                          // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 140,
                                          color: Colors.transparent,
                                          child: Text('Price:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                            height: 30,
                                            width: 200,
                                            color: Colors.transparent,
                                            child:Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                      : snapshot.data?["data"]['booking'][0]['price'].toString()
                                                      ?? 'empty'),
                                                  style: TextStyle(
                                                      color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                )
                                            )
                                          // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        )
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 140,
                                          color: Colors.transparent,
                                          child: Text('Status:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                            height: 30,
                                            width: 200,
                                            color: Colors.transparent,
                                            child:Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                      : snapshot.data?["data"]['booking'][0]['status'].toString()
                                                      ?? 'empty'),
                                                  style: TextStyle(
                                                      color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                )
                                            )
                                          // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
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
                                                  child: Text('Add Reply',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.white),),
                                                ),
                                              ),


                                            ),                                                              ),
                                          onTap: () async {
                                            },
                                        ),


                                      ],
                                    ),


                                    Column(
                                      children:<Widget>[
                                        //Text('second test'),
                                        ListView.separated(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: snapshot.data?["data"]['add_reply_responses'].length ?? '',
                                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                                            itemBuilder: (BuildContext context, int index) {

                                              SizedBox(
                                                height: 20,
                                              );
                                              return Container(

                                                  child: Column(

                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: 140,
                                                            color: Colors.transparent,
                                                            child:Text(
                                                                (snapshot.data?['data']['add_reply_responses'].isEmpty ? 'Empty name'
                                                                    : snapshot.data?["data"]['add_reply_responses'][index]['created_at'].toString()
                                                                    ?? 'empty'),
                                                                style: TextStyle(
                                                                color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                                                            ),
                                                          ),
                                                          Container(
                                                              height: 50,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              child:Align(
                                                                  alignment: Alignment.topLeft,
                                                                child:Text(
                                                                  (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                                      : snapshot.data?["data"]['booking'][0]['customerDetail']?['name'].toString()
                                                                      ?? 'empty') + (snapshot.data?['data']['booking'].isEmpty ? 'Empty name'
                                                                      : snapshot.data?["data"]['booking'][0]['customerDetail']?['surname'].toString()
                                                                      ?? 'empty'),
                                                                  style: TextStyle(
                                                                      color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                                ),
                                                              )
                                                            // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                      height: 20,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: 140,
                                                            color: Colors.transparent,
                                                            child:Text(
                                                              ('Date & Time'),
                                                              style: TextStyle(
                                                                  color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                                                            ),
                                                          ),
                                                          Container(
                                                              height: 50,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              child:Align(
                                                                alignment: Alignment.topLeft,
                                                                child:Text((snapshot.data?['data']['add_reply_responses'].isEmpty ? 'Empty name' : snapshot.data?["data"]['add_reply_responses'][index]['reply'].toString()
                                                      ?? 'empty'), style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                                                ),
                                                              )
                                                            // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                              );
                                            })

                                      ],
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
