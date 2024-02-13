
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:tourstravels/ApartVC/Add_Apartment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:tourstravels/ApartVC/Addaprtment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/UserDashboard_Screens/ApartDshbrdModel.dart';
import 'package:tourstravels/UserDashboard_Screens/Apartbooking_Model.dart';
//import 'NewUserbooking.dart';
class PivotDashboard extends StatefulWidget {
  const PivotDashboard({super.key});

  @override
  State<PivotDashboard> createState() => _userDashboardState();
}

class _userDashboardState extends State<PivotDashboard> {

  String bookings = '';
  int Bookable_iD = 0;
  String status = '';
  int idnum = 0;
  String Date = '';
  int selectedIndex = 0;
  int imageID = 0;
  String citystr = '';
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String RetrivedBearertoekn = '';
  var getbookingData = [];
  var startDateList = [];
  var endDateList = [];
  int booking_idv = 0;
  var booking_idList = [];
  String startDatestr = '';
  String endDatestr = '';
  var pivotsts = '';
  String Retrivedcityvalue = '';
  String RetrivedAdress = '';


  String Bookingsts = 'Not booked yet!';
  String Statusstr = '';
  String stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
  String stsId = '';
  int booking_id = 0;
  String ApprovedMessagestr = '';
  String DeclinedMessagestr = '';
  var controller = ScrollController();
  late Future<List<DashboardApart>> BookingDashboardUsers ;
  int count = 15;
 // late Future<List<Apart>> listUsers ;
  late Future<List<Pivot>> BookinguserList ;

  List<Pivot> welcomeFromJson(String str) => List<Pivot>.from(json.decode(str).map((x) => Pivot.fromJSON(x)));
  String welcomeToJson(List<Pivot> data) => json.encode(List<dynamic>.from(data.map((x) => x.toString())));
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      RetrivedEmail = prefs.getString('emailkey') ?? "";
      RetrivedPwd = prefs.getString('passwordkey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      Bookable_iD = prefs.getInt('userbookingId') ?? 0;
      Retrivedcityvalue = prefs.getString('citykey') ?? "";
      RetrivedAdress = prefs.getString('addresskey') ?? "";
      ApprovedMessagestr = prefs.getString('Approvedkey') ?? "";
      DeclinedMessagestr = prefs.getString('Declinedkey') ?? "";




    });
  }
//@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    //getData();

  }
  Future<dynamic> getData() async {
    //String url = 'https://staging.abisiniya.com/api/v1/apartment/list';
    String url = 'https://staging.abisiniya.com/api/v1/booking/apartment/withbooking';
    //var token = '296|JeKFHy6w6YIIvbeDmRIZ3zLFXOF3WRWptD3FddoD';
    print('sts token..');
    print(RetrivedBearertoekn);
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
      var picstrr = data1['data'];
      for (var record in picstrr) {
        var pictures = record['bookings'];
        for (var pics in pictures) {
          var pivotdata = pics['pivot'];
          //print('pivot array.....');
          //print(pivotdata);
          int bookable_id = 0;
          bookable_id = pivotdata['bookable_id'];
          print('Retrive bookabi id');
          print(bookable_id);
          if (bookable_id == Bookable_iD) {
            pivotsts = pivotdata['status'];
            startDatestr = pivotdata['start_date'];
            endDatestr = pivotdata['end_date'];
            booking_idv = pivotdata['booking_id'];
            getbookingData.add(pivotsts);
            startDateList.add(startDatestr);
            endDateList.add(endDatestr);
            booking_idList.add(booking_idv);
          }
        }
      }
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
        title: const Text(
          'Abisiniya',
        ),
        // backgroundColor: const Color(0xff764abc),
        backgroundColor: Colors.green,

      ),
      body: FutureBuilder<dynamic>(

        //future: BookingDashboardUsers,
          future: getData(),

        //future: BookinguserList,
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
                  return InkWell(

                      child:Column(
                        children: <Widget>[
                          Container(color: Colors.white54, height: 110,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 140,
                                      height: 35,
                                      color: Colors.grey,
                                      child: Text('Owner:',style: (TextStyle(fontSize: 18,color: Colors.black87)),),
                                    ),
                                    Container(
                                      width: 200,
                                      height: 35,
                                      color: Colors.grey,
                                      child: Text('----',style: (TextStyle(fontSize: 18,color: Colors.black87)),),
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 140,
                                      height: 35,
                                      color: Colors.grey,
                                      child: Text('Address',style: (TextStyle(fontSize: 18,color: Colors.black87)),),
                                    ),
                                    Container(
                                      width: 200,
                                      height: 35,
                                      color: Colors.grey,
                                      child: Text(RetrivedAdress,style: (TextStyle(fontSize: 18,color: Colors.black87)),),
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 140,
                                      height: 35,
                                      color: Colors.grey,
                                      child: Text('City:',style: (TextStyle(fontSize: 18,color: Colors.black87)),),
                                    ),
                                    Container(
                                      width: 200,
                                      height: 35,
                                      color: Colors.grey,
                                      child: Text(Retrivedcityvalue,style: (TextStyle(fontSize: 18,color: Colors.black87)),),
                                    ),

                                  ],
                                ),
                              ],
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
                                        //Text('Your Apartments:',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),

                                        ListView.separated(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: getbookingData.length,
                                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                                            itemBuilder: (BuildContext context, int index) {
                                              return Container(
                                                height: 150,
                                                width: 100,
                                                alignment: Alignment.center,
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                  Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 10,
                                                              ),
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
                                                                 child: Text(startDateList[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              )
                                                            ],
                                                          ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 35,
                                                          width: 140,
                                                          color: Colors.white10,
                                                          child: Text('check-out:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        ),
                                                        Container(
                                                          height: 35,
                                                          width: 200,
                                                          color: Colors.white,
                                                          child: Text(endDateList[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 35,
                                                          width: 140,
                                                          color: Colors.white10,
                                                          child: Text('Status:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        ),
                                                        Container(
                                                          height: 35,
                                                          width: 200,
                                                          color: Colors.white,
                                                          child: Text(getbookingData[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        )
                                                      ],
                                                    ),

                                              SizedBox(
                                                width: 50,
                                              ),

                                              Row(
                                              children: [
                                              InkWell(
                                              // onTap: doSomething,
                                              onTap: () { print("Container was tapped2...."); },
                                              child: SizedBox(
                                              height: 35,
                                              width: 80,
                                              child: Container(
                                              decoration: BoxDecoration(
                                              border: Border.all(color: Colors.white)),
                                              child: Text(
                                              'Action',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                                              ),
                                              ),
                                              ),
                                              ),


                                                InkWell(
                                                  // onTap: doSomething,
                                                  onTap: () async {
                                                    print('Approvemsg....');
                                                    print(ApprovedMessagestr);
                                                    if(ApprovedMessagestr == 'successfully Approved'){
                                                      print('Jumped.........');
                                                     // UpdatedstatusshowAlertDialog(context);
                                                    }
                                                   // UpdatedstatusshowAlertDialog(context);


                                                    //
                                                    if (getbookingData[index] == 'Awaiting Approval'){
                                                      stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                                      // stsId = snapshot.data['data'][index]['id'].toString();
                                                      stsId = booking_idList[index].toString();
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
                                                        ApprovedMessagestr = 'successfully Approved';
                                                        print(ApprovedMessagestr);
                                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                                        prefs.setString('Approvedkey', ApprovedMessagestr);
                                                        final snackBar = SnackBar(
                                                          content: Text('Successfully Approved'),
                                                        );
                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                        return json.decode(response.body);
                                                      } else {
                                                        // If that call was not successful, throw an error.
                                                        throw Exception('Failed to load post');
                                                      }
                                                    } else if (getbookingData[index] == 'Approved'){

                                                      stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                                      stsId = booking_idList[index].toString();
                                                      // stsId = snapshot.data['data'][index]['id'].toString();
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

                                                    } else if (getbookingData[index] == 'Checked In'){

                                                      stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';

                                                      stsId = booking_idList[index].toString();

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
                                                    },
                                                  child: SizedBox(
                                                    height: 35,
                                                    width: 160,
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.white)),

                                                        child: Column(children:[  if ((getbookingData[index]== 'Awaiting Approval'))
                                                          Text(
                                                            'Approve',
                                                            textAlign: TextAlign.right,
                                                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.green),
                                                          ),
                                                          if ((getbookingData[index] == 'Approved'))
                                                            Text(
                                                              'Check In',
                                                              textAlign: TextAlign.right,
                                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.green),
                                                            ),
                                                          if ((getbookingData[index] == 'Checked In'))
                                                            Text(
                                                              'Check Out',
                                                              textAlign: TextAlign.right,
                                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.green),
                                                            ),


                                                          // if (e["index"] == 3)
                                                          //   Text(e["text"].toString(),
                                                          //       textAlign: TextAlign.center,
                                                          //       style: TextStyle(color: Colors.amber)),
                                                          // if (e["index"] == 4)
                                                          //   Text(e["text"].toString(),
                                                          //       textAlign: TextAlign.center,
                                                          //       style: TextStyle(color: Colors.orange)),
                                                          // if (e["index"] == 5)
                                                          //   Text(e["text"].toString(),
                                                          //       textAlign: TextAlign.center,
                                                          //       style: TextStyle(color: Colors.red)),
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
                                                   // showAlertDialog(context);


                                                    // if(DeclinedMessagestr == 'successfully Declined'){
                                                    //   print('Jumped into declined.........');
                                                    //   DeclinedshowAlertDialog(context);
                                                    // }
                                                   // DeclinedshowAlertDialog(context);
                                                    print('booking sts...');
                                                    print(getbookingData[index]);


                                                    if (getbookingData[index] == 'Awaiting Approval'){
                                                      stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                                      // stsId = snapshot.data['data'][index]['id'].toString();
                                                      stsId = booking_idList[index].toString();
                                                      String ApproveStr = '/Declined';
                                                      String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                                      print('decline url...');
                                                      print(Apprvoedurl);
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
                                                        print('successfully Decline....');
                                                        DeclinedMessagestr = 'successfully Declined';
                                                        print(DeclinedMessagestr);
                                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                                        prefs.setString('Declinedkey', DeclinedMessagestr);
                                                        final snackBar = SnackBar(
                                                          content: Text('Successfully Approved'),
                                                        );
                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                        return json.decode(response.body);
                                                      } else {
                                                        // If that call was not successful, throw an error.
                                                        throw Exception('Failed to load post');
                                                      }
                                                    } else if (getbookingData[index] == 'Approve'){
                                                      stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                                      // stsId = snapshot.data['data'][index]['id'].toString();
                                                      stsId = booking_idList[index].toString();
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
                                                        print('successfully Declined unbook....');
                                                        DeclinedMessagestr = 'successfully Declined';
                                                        print(DeclinedMessagestr);
                                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                                        prefs.setString('Declinedkey', DeclinedMessagestr);
                                                        final snackBar = SnackBar(
                                                          content: Text('Successfully Approved'),
                                                        );
                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                        return json.decode(response.body);
                                                      } else {
                                                        // If that call was not successful, throw an error.
                                                        throw Exception('Failed to load post');
                                                      }
                                                    }

                                                   //
                                                   //  if (getbookingData[index] == 'Awaiting Approval'){
                                                   // stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                                   //  stsId = booking_idList[index].toString();
                                                   //    String ApproveStr = '/Declined';
                                                   //    String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                                   //    var response = await http.get(
                                                   //      Uri.parse(
                                                   //          Apprvoedurl),
                                                   //      headers: {
                                                   //        // 'Authorization':
                                                   //        // 'Bearer <--your-token-here-->',
                                                   //        "Authorization": "Bearer $RetrivedBearertoekn",
                                                   //      },
                                                   //    );
                                                   //    if (response.statusCode == 200) {
                                                   //      final data1 = jsonDecode(response.body);
                                                   //      var getpicsData = [];
                                                   //      var picstrr = data1['data'];
                                                   //      print('successfully Declined....1');
                                                   //      DeclinedMessagestr = 'successfully Declined';
                                                   //      SharedPreferences prefs = await SharedPreferences.getInstance();
                                                   //      prefs.setString('Declinedkey', DeclinedMessagestr);
                                                   //      final snackBar = SnackBar(
                                                   //        content: Text('Successfully Declined'),
                                                   //      );
                                                   //      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                   //
                                                   //
                                                   //      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                   //      return json.decode(response.body);
                                                   //    } else {
                                                   //      // If that call was not successful, throw an error.
                                                   //      throw Exception('Failed to load post');
                                                   //    }
                                                   //  } else if (getbookingData[index] == 'Approved'){
                                                   //    stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                                   //    stsId = booking_idList[index].toString();
                                                   //    String ApproveStr = '/Declined';
                                                   //    String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                                   //    var response = await http.get(
                                                   //      Uri.parse(
                                                   //          Apprvoedurl),
                                                   //      headers: {
                                                   //        // 'Authorization':
                                                   //        // 'Bearer <--your-token-here-->',
                                                   //        "Authorization": "Bearer $RetrivedBearertoekn",
                                                   //      },
                                                   //    );
                                                   //    if (response.statusCode == 200) {
                                                   //      final data1 = jsonDecode(response.body);
                                                   //      var getpicsData = [];
                                                   //      var picstrr = data1['data'];
                                                   //      print('successfully Declined....');
                                                   //      DeclinedMessagestr = 'successfully Declined';
                                                   //      SharedPreferences prefs = await SharedPreferences.getInstance();
                                                   //      prefs.setString('Declinedkey', DeclinedMessagestr);
                                                   //      final snackBar = SnackBar(
                                                   //        content: Text('Successfully Declined'),
                                                   //      );
                                                   //      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                   //
                                                   //      return json.decode(response.body);
                                                   //    } else {
                                                   //      // If that call was not successful, throw an error.
                                                   //      throw Exception('Failed to load post');
                                                   //    }
                                                    //}

                                                    print("Approve Container was tapped....."); },
                                                  child: SizedBox(
                                                    height: 35,
                                                    width: 100,
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.white)),

                                                        child: Column(children:[  if ((getbookingData[index] == 'Awaiting Approval'))
                                                          Text(
                                                            'Decline',
                                                            textAlign: TextAlign.left,
                                                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.red),
                                                          ),
                                                          if ((getbookingData[index] == 'Approved'))
                                                            Text(
                                                              'Unbook',
                                                              textAlign: TextAlign.right,
                                                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.red),
                                                            ),


                                                          // if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                          //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked In'))
                                                          //   Text(
                                                          //     'Check Out',
                                                          //     textAlign: TextAlign.right,
                                                          //     style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.green),
                                                          //   ),


                                                          // if (e["index"] == 3)
                                                          //   Text(e["text"].toString(),
                                                          //       textAlign: TextAlign.center,
                                                          //       style: TextStyle(color: Colors.amber)),
                                                          // if (e["index"] == 4)
                                                          //   Text(e["text"].toString(),
                                                          //       textAlign: TextAlign.center,
                                                          //       style: TextStyle(color: Colors.orange)),
                                                          // if (e["index"] == 5)
                                                          //   Text(e["text"].toString(),
                                                          //       textAlign: TextAlign.center,
                                                          //       style: TextStyle(color: Colors.red)),
                                                        ])

                                                      //),

                                                      // child: Text(
                                                      //   'Approve',
                                                      //   textAlign: TextAlign.right,
                                                      //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.green),
                                                      // ),
                                                    ),
                                                  ),
                                                )




                                                    ],
                                              ),




                                                    // Row(
                                                    //   children: [
                                                    //     InkWell(
                                                    //       // onTap: doSomething,
                                                    //       onTap: () { print("Container was tapped2...."); },
                                                    //       child: SizedBox(
                                                    //         height: 35,
                                                    //         width: 100,
                                                    //         child: Container(
                                                    //           decoration: BoxDecoration(
                                                    //               border: Border.all(color: Colors.white)),
                                                    //           child: Text(
                                                    //             'Action',
                                                    //             textAlign: TextAlign.left,
                                                    //             style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //     InkWell(
                                                    //       // onTap: doSomething,
                                                    //       onTap: () async {
                                                    //
                                                    //         if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //             : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval'){
                                                    //           stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                                    //           // stsId = snapshot.data['data'][index]['id'].toString();
                                                    //           stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //               : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                                                    //           String ApproveStr = '/Approved';
                                                    //           String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                                    //           var response = await http.get(
                                                    //             Uri.parse(
                                                    //                 Apprvoedurl),
                                                    //             headers: {
                                                    //               // 'Authorization':
                                                    //               // 'Bearer <--your-token-here-->',
                                                    //               "Authorization": "Bearer $RetrivedBearertoekn",
                                                    //             },
                                                    //           );
                                                    //           if (response.statusCode == 200) {
                                                    //             final data1 = jsonDecode(response.body);
                                                    //             var getpicsData = [];
                                                    //             var picstrr = data1['data'];
                                                    //             print('successfully Approved....');
                                                    //             final snackBar = SnackBar(
                                                    //               content: Text('Successfully Approved'),
                                                    //             );
                                                    //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                    //             return json.decode(response.body);
                                                    //           } else {
                                                    //             // If that call was not successful, throw an error.
                                                    //             throw Exception('Failed to load post');
                                                    //           }
                                                    //         }  else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //             : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved'){
                                                    //
                                                    //           stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                                    //           // stsId = snapshot.data['data'][index]['id'].toString();
                                                    //           stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //               : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                                                    //           String ApproveStr = '/Checked In';
                                                    //           String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                                    //           var response = await http.get(
                                                    //             Uri.parse(
                                                    //                 Apprvoedurl),
                                                    //             headers: {
                                                    //               "Authorization": "Bearer $RetrivedBearertoekn",
                                                    //             },
                                                    //           );
                                                    //           if (response.statusCode == 200) {
                                                    //             final data1 = jsonDecode(response.body);
                                                    //             var getpicsData = [];
                                                    //             var picstrr = data1['data'];
                                                    //             print('successfully checked In....');
                                                    //             final snackBar = SnackBar(
                                                    //               content: Text('Successfully Checked In'),
                                                    //             );
                                                    //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                    //             return json.decode(response.body);
                                                    //           } else {
                                                    //             // If that call was not successful, throw an error.
                                                    //             throw Exception('Failed to load post');
                                                    //           }
                                                    //
                                                    //         } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //             : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked In'){
                                                    //           stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                                    //           // stsId = snapshot.data['data'][index]['id'].toString();
                                                    //           stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //               : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                                                    //           String ApproveStr = '/Checked Out';
                                                    //           String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                                    //           var response = await http.get(
                                                    //             Uri.parse(
                                                    //                 Apprvoedurl),
                                                    //             headers: {
                                                    //               // 'Authorization':
                                                    //               // 'Bearer <--your-token-here-->',
                                                    //               "Authorization": "Bearer $RetrivedBearertoekn",
                                                    //             },
                                                    //           );
                                                    //           if (response.statusCode == 200) {
                                                    //             final data1 = jsonDecode(response.body);
                                                    //             var getpicsData = [];
                                                    //             var picstrr = data1['data'];
                                                    //             print('successfully checked out....');
                                                    //             final snackBar = SnackBar(
                                                    //               content: Text('Successfully Checked Out'),
                                                    //             );
                                                    //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                    //             return json.decode(response.body);
                                                    //           } else {
                                                    //             // If that call was not successful, throw an error.
                                                    //             throw Exception('Failed to load post');
                                                    //           }
                                                    //
                                                    //         } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //             : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked Out'){
                                                    //
                                                    //
                                                    //           print('checked out btn clicked.....');
                                                    //         }
                                                    //
                                                    //
                                                    //         print("Approve Container was tapped....."); },
                                                    //       child: SizedBox(
                                                    //         height: 35,
                                                    //         width: 100,
                                                    //         child: Container(
                                                    //             decoration: BoxDecoration(
                                                    //                 border: Border.all(color: Colors.white)),
                                                    //
                                                    //             child: Column(children:[  if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //                 : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval'))
                                                    //               Text(
                                                    //                 'Approve',
                                                    //                 textAlign: TextAlign.right,
                                                    //                 style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.green),
                                                    //               ),
                                                    //               if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //                   : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved'))
                                                    //                 Text(
                                                    //                   'Check In',
                                                    //                   textAlign: TextAlign.right,
                                                    //                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.green),
                                                    //                 ),
                                                    //               if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //                   : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked In'))
                                                    //                 Text(
                                                    //                   'Check Out',
                                                    //                   textAlign: TextAlign.right,
                                                    //                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.green),
                                                    //                 ),
                                                    //
                                                    //
                                                    //               // if (e["index"] == 3)
                                                    //               //   Text(e["text"].toString(),
                                                    //               //       textAlign: TextAlign.center,
                                                    //               //       style: TextStyle(color: Colors.amber)),
                                                    //               // if (e["index"] == 4)
                                                    //               //   Text(e["text"].toString(),
                                                    //               //       textAlign: TextAlign.center,
                                                    //               //       style: TextStyle(color: Colors.orange)),
                                                    //               // if (e["index"] == 5)
                                                    //               //   Text(e["text"].toString(),
                                                    //               //       textAlign: TextAlign.center,
                                                    //               //       style: TextStyle(color: Colors.red)),
                                                    //             ])
                                                    //
                                                    //           //),
                                                    //
                                                    //           // child: Text(
                                                    //           //   'Approve',
                                                    //           //   textAlign: TextAlign.right,
                                                    //           //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.green),
                                                    //           // ),
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //
                                                    //     InkWell(
                                                    //       // onTap: doSomething,
                                                    //       onTap: () async {
                                                    //         print('clicked on declined btn...');
                                                    //
                                                    //         if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //             : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval'){
                                                    //
                                                    //           stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                                    //           // stsId = snapshot.data['data'][index]['id'].toString();
                                                    //           stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //               : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                                                    //           String ApproveStr = '/Declined';
                                                    //           String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                                    //           var response = await http.get(
                                                    //             Uri.parse(
                                                    //                 Apprvoedurl),
                                                    //             headers: {
                                                    //               // 'Authorization':
                                                    //               // 'Bearer <--your-token-here-->',
                                                    //               "Authorization": "Bearer $RetrivedBearertoekn",
                                                    //             },
                                                    //           );
                                                    //           if (response.statusCode == 200) {
                                                    //             final data1 = jsonDecode(response.body);
                                                    //             var getpicsData = [];
                                                    //             var picstrr = data1['data'];
                                                    //             print('successfully Declined....');
                                                    //             final snackBar = SnackBar(
                                                    //               content: Text('Successfully Declined'),
                                                    //             );
                                                    //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                    //             return json.decode(response.body);
                                                    //           } else {
                                                    //             // If that call was not successful, throw an error.
                                                    //             throw Exception('Failed to load post');
                                                    //           }
                                                    //         } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //             : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved'){
                                                    //
                                                    //
                                                    //           print('checked in btn clicked.....');
                                                    //           stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
                                                    //           // stsId = snapshot.data['data'][index]['id'].toString();
                                                    //           stsId = (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //               : snapshot.data?["data"][index]['bookings'][0]['pivot']['booking_id'].toString() ?? 'empty');
                                                    //           String ApproveStr = '/Unbook';
                                                    //           String Apprvoedurl = '$stsbaseurl$stsId$ApproveStr';
                                                    //           var response = await http.get(
                                                    //             Uri.parse(
                                                    //                 Apprvoedurl),
                                                    //             headers: {
                                                    //               // 'Authorization':
                                                    //               // 'Bearer <--your-token-here-->',
                                                    //               "Authorization": "Bearer $RetrivedBearertoekn",
                                                    //             },
                                                    //           );
                                                    //           if (response.statusCode == 200) {
                                                    //             final data1 = jsonDecode(response.body);
                                                    //             var getpicsData = [];
                                                    //             var picstrr = data1['data'];
                                                    //             print('successfully Declined....');
                                                    //             final snackBar = SnackBar(
                                                    //               content: Text('Successfully Declined'),
                                                    //             );
                                                    //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                    //             return json.decode(response.body);
                                                    //           } else {
                                                    //             // If that call was not successful, throw an error.
                                                    //             throw Exception('Failed to load post');
                                                    //           }
                                                    //         }
                                                    //
                                                    //         print("Approve Container was tapped....."); },
                                                    //       child: SizedBox(
                                                    //         height: 35,
                                                    //         width: 100,
                                                    //         child: Container(
                                                    //             decoration: BoxDecoration(
                                                    //                 border: Border.all(color: Colors.white)),
                                                    //
                                                    //             child: Column(children:[  if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //                 : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval'))
                                                    //               Text(
                                                    //                 'Decline',
                                                    //                 textAlign: TextAlign.right,
                                                    //                 style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.red),
                                                    //               ),
                                                    //               if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //                   : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved'))
                                                    //                 Text(
                                                    //                   'Unbook',
                                                    //                   textAlign: TextAlign.right,
                                                    //                   style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.red),
                                                    //                 ),
                                                    //
                                                    //
                                                    //               // if (((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    //               //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked In'))
                                                    //               //   Text(
                                                    //               //     'Check Out',
                                                    //               //     textAlign: TextAlign.right,
                                                    //               //     style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.green),
                                                    //               //   ),
                                                    //
                                                    //
                                                    //               // if (e["index"] == 3)
                                                    //               //   Text(e["text"].toString(),
                                                    //               //       textAlign: TextAlign.center,
                                                    //               //       style: TextStyle(color: Colors.amber)),
                                                    //               // if (e["index"] == 4)
                                                    //               //   Text(e["text"].toString(),
                                                    //               //       textAlign: TextAlign.center,
                                                    //               //       style: TextStyle(color: Colors.orange)),
                                                    //               // if (e["index"] == 5)
                                                    //               //   Text(e["text"].toString(),
                                                    //               //       textAlign: TextAlign.center,
                                                    //               //       style: TextStyle(color: Colors.red)),
                                                    //             ])
                                                    //
                                                    //           //),
                                                    //
                                                    //           // child: Text(
                                                    //           //   'Approve',
                                                    //           //   textAlign: TextAlign.right,
                                                    //           //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.green),
                                                    //           // ),
                                                    //         ),
                                                    //       ),
                                                    //     )
                                                    //   ],
                                                    // ),



                                                  ],
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
                                                itemCount:0,
                                                itemBuilder: (context,index){
                                                  return  Text('Apartment');
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
                      ),
                      onTap: ()async {
                        print('View more Tapped button.....');
                      }
                  );



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
