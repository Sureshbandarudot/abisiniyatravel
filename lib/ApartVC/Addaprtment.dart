import 'dart:convert';
//import 'package:apartmentdataparsing/models/Apartmentdata.dart';
import 'package:tourstravels/ApartVC/ApartmentAddmodel/Apartmentdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import 'package:tourstravels/userDashboardvc.dart';
import 'package:tourstravels/UserDashboard_Screens/newDashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../MyBookings/MybookingVC.dart';
import '../ServiceDasboardVC.dart';
import 'Authenticated_Userbookingscreen.dart';
//import 'models/user.dart';
class AddApartment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<AddApartment> {
  final baseDioSingleton = BaseSingleton();
  String result = ''; // To store the result from the API call
  TextEditingController FromdateInputController = TextEditingController();
  TextEditingController TodateInputController = TextEditingController();
  //List listUsers= [];
  //Future? listUsers;;
  int RetrivedId = 0;
  String newBookingUser = '';

  int idnum = 0;
  int aptId = 0;
  int Bookable_iD = 0;
  String Bookable_type = '';
  String Retrivedcityvalue = '';
  String RetrivedAdress = '';
  String RetrivedBathromm = '';
  String RetrivedBedroom = '';
  String RetrivedPrice = '';
  String RetrivedBearertoekn = '';
  bool isLoading = false;
  //Date Strings
  String fromDate = '';
  String toDatestr = '';
  //Future<List<User>> listUsers;
  late Future<List<Apart>> listUsers ;
  late Future<List<Picture>> pics ;

  List<Picture> welcomeFromJson(String str) => List<Picture>.from(json.decode(str).map((x) => Picture.fromJSON(x)));
  String welcomeToJson(List<Picture> data) => json.encode(List<dynamic>.from(data.map((x) => x.toString())));
@override
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print(baseDioSingleton.AbisiniyaBaseurl);
      Retrivedcityvalue = prefs.getString('citykey') ?? "";
      Bookable_iD = prefs.getInt('imgkeyId') ?? 0;
      RetrivedAdress = prefs.getString('addresskey') ?? "";
      RetrivedBathromm = prefs.getString('bathroomkey') ?? "";
      RetrivedBedroom = prefs.getString('bedroomkey') ?? "";
      RetrivedPrice = prefs.getString('pricekey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      Bookable_type = prefs.getString('Property_type') ?? "";


    });
  }


  //@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    _postData();
    listUsers = fetchUsers();
    pics = fetchpics();
  }
  //String url = 'https://staging.abisiniya.com/api/v1/apartment/list';

//String url = baseDioSingleton.AbisiniyaBaseurl;
  Future<List<Apart>> fetchUsers() async {
    //String url = baseDioSingleton.AbisiniyaBaseurl + 'apartment/list';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    RetrivedId = prefs.getInt('imgkeyId') ?? 0;
    RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
    String url = (baseDioSingleton.AbisiniyaBaseurl + 'apartment/show/$RetrivedId');
    //final response = await http.get(Uri.parse(url));
    var response = await http.get(
      Uri.parse(
          url),
      headers: {
        "Authorization": "Bearer $RetrivedBearertoekn",
      },
    );
    if (response.statusCode == 200) {
      final data1 = jsonDecode(response.body);
      var getUsersData = data1['data'] as List;
      //print(getUsersData);
      var listUsers = getUsersData.map((i) => Apart.fromJSON(i)).toList();
      // print('list.....');
      // print(listUsers);
      return listUsers;
      //var recordsList = data["records"];
      // for (var record in tagsJson) {
      //   //var apartmentlists = record['name'];
      //   print('name...');
      //   //print(name);
      //   var pictures = record['pictures'];
      //   for(var pics in pictures) {
      //     var picname = pics['imageUrl'];
      //     print('pictures...');
      //     print(picname);
      //   }
      // }
      //List<Apart> list = parseAgents(response.body);
      //return list;
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Picture>> fetchpics() async {
    // String url = baseDioSingleton.AbisiniyaBaseurl + 'apartment/list';
    //String url = baseDioSingleton.AbisiniyaBaseurl + 'apartment/auth/list';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    RetrivedId = prefs.getInt('imgkeyId') ?? 0;
    RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
    String url = (baseDioSingleton.AbisiniyaBaseurl + 'apartment/show/$RetrivedId');
   // apartment/auth/list
    //final response = await http.get(Uri.parse(url));
    var response = await http.get(
      Uri.parse(
          url),
      headers: {
        "Authorization": "Bearer $RetrivedBearertoekn",
      },
    );
    if (response.statusCode == 200) {
      final data1 = jsonDecode(response.body);
      var getpicsData = [];
      var picstrr = data1['data'];
      for (var record in picstrr) {
        idnum = record['id'];
        var pictures = record['pictures'];
        for (var picid in pictures) {
          aptId = picid['apartmentId'];
        }
        print(Bookable_iD);
        if (aptId == Bookable_iD) {
          for (var pics in pictures) {
            print(pics);
            getpicsData.add(pics);
            print(getpicsData);
          }
        }

      }
      var pics = getpicsData.map((i) => Picture.fromJSON(i)).toList();
      return pics;

    } else {
      throw Exception('Error');
    }
  }


  //Apartment data post to server
  Future<void> _postData() async {
    try {
      String apiUrl = '';
      apiUrl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/booking/authuser';
      print('url.....1');
      print(apiUrl);
      print('auth bearer token');
      print(RetrivedBearertoekn);
      print(Bookable_type);
      print(Bookable_iD);
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
         // 'Content-Type': 'application/json; charset=UTF-8',
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $RetrivedBearertoekn",
        },
        body: jsonEncode(<String, dynamic>{
          'start_date': FromdateInputController.text,
          'end_date': TodateInputController.text,
          'bookable_type': Bookable_type,
          'bookable_id': Bookable_iD
          // Add any other data you want to send in the body
        }),
      );
      print('status code...');
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(response.body);
        print('Apartment fresh user data successfully posted');
        print(responseData);
        var data = jsonDecode(response.body.toString());
        print('message......k');
        print(data['message']);
        // RetrivedBearertoekn = data['data']['token'];
        // print('token generated...');
        // print(RetrivedBearertoekn);
        // // String datestr = '';
        // // datestr = data['message'].toString();
        // print('date status...');
        // print(datestr);

        if (data['message'] == 'Thank you for booking request')
        {
          print('not calling....');
          final snackBar = SnackBar(
            content: Text(data['message']),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (data['message'] == 'Start date should be greater or equal to booking day'){
          print('Start date should be greater or equal to booking day.......');
          final snackBar = SnackBar(
            content: Text('Start date should be greater or equal to booking day'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (_) => MyBookingScreen(),
          ),);
          print('calling token....');
          print(RetrivedBearertoekn);
          RetrivedBearertoekn = data['data']['token'];
          print('token generated...');
          print(RetrivedBearertoekn);
          newBookingUser = 'NewBookingUser';
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('tokenkey', RetrivedBearertoekn);
          prefs.setString('newBookingUserkey', newBookingUser);

        }
      }
      if (response.statusCode == 404) {
        final snackBar = SnackBar(
                content: Text('You cant book your own apartment'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (response.statusCode == 422) {
        print('already entered existing data1...');
        var data = jsonDecode(response.body);
        print('email...');
        print(data['message']['email']);
        //String emailstr = (data['message']['email']);
        //print(emailstr);
        print(data['message']['phone']);
        print(data['message']['end_date']);
        if ((data['message']['phone']) != null && (data['message']['email']) != null) {
          final snackBar = SnackBar(
            content: Text('The email and phone has already been taken.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);        }
        else if ((data['message']['phone']) != null) {
          final snackBar = SnackBar(
            content: Text('The phone has already been taken.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        } else if ((data['message']['email']) != null) {
          final snackBar = SnackBar(
            content: Text('The  email has already been taken.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if ((data['message']['end_date']) != null) {
          print('date....');
          final snackBar = SnackBar(
            content: Text('The end date must be a date after start date.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          print('nullll.....');
        }
        // if ((data['message']['email']) != '[The email has already been taken.]' && (data['message']['phone']) != '[The phone has already been taken.]'){
        //   final snackBar = SnackBar(
        //     content: Text('The email and phone has already been taken.'),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //
        // }  else if ((data['message']['email']) != '[The email has already been taken.]') {
        //   final snackBar = SnackBar(
        //     content: Text('The email  has already been taken.'),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // } else if ((data['message']['phone']) != '[The phone has already been taken.]'){
        //   final snackBar = SnackBar(
        //     content: Text('The  phone has already been taken.'),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // } else if ((data['message']['end_date']) != '[The end date must be a date after start date.]') {
        //   final snackBar = SnackBar(
        //     content: Text('The end date must be a date after start date.'),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // }
      }  else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }


  //     if (response.statusCode == 200) {
  //       // Successful POST request, handle the response here
  //       final responseData = jsonDecode(response.body);
  //       print('Apartment data successfully posted');
  //       print(responseData);
  //       var data = jsonDecode(response.body.toString());
  //       print(data['message']);
  //       if (data['message'] == 'Thank you for booking request')
  //       {
  //         print('not calling....');
  //         final snackBar = SnackBar(
  //           content: Text(data['message']),
  //         );
  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //         // print('calling....');
  //         // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
  //         //   builder: (_) => newuserDashboard(),
  //         // ),);
  //       } else {
  //         print('calling....');
  //         Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
  //           builder: (_) => newuserDashboard(),
  //         ),);
  //         print('calling token....');
  //         print(RetrivedBearertoekn);
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         prefs.setString('tokenkey', RetrivedBearertoekn);
  //         newBookingUser = 'NewBookingUser';
  //         prefs.setString('tokenkey', RetrivedBearertoekn);
  //         prefs.setString('newBookingUserkey', newBookingUser);
  //       }
  //       setState(() {
  //         //result = 'ID: ${responseData['id']}\nName: ${responseData['name']}\nEmail: ${responseData['email']}';
  //       });
  //     } else if(response.statusCode == 404){
  //
  //
  //       final responseData = jsonDecode(response.body);
  //       print(responseData);
  //       var data = jsonDecode(response.body.toString());
  //       print(data['message']);
  //
  //       final snackBar = SnackBar(
  //
  //         content: Text(data['message']),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     } else {
  //
  //       // final snackBar = SnackBar(
  //       //   content: Text('You cant book your own apartment'),
  //       // );
  //       // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       throw Exception('Failed to post data');
  //     }
  //   } catch (e) {
  //     setState(() {
  //       result = 'Error: $e';
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.white, Colors.green]),
          ),
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () async{
            print("back Pressed");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // prefs.setString('logoutkey', ('LogoutDashboard'));
            // prefs.setString('Property_type', ('Apartment'));
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AuthenticatedUserScreen()),

            );
          },
        ),
        title: Text('APARTMENT',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
      ),
      body: FutureBuilder(
          future: pics,
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
                  //return Column(
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: LayoutBuilder(
                            builder: (context, constraint) {
                              return SingleChildScrollView(
                                physics: ScrollPhysics(),
                                child: Column(
                                    children: [

                                      ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        // scrollDirection:Axis.horizontal,
                                        itemCount: (snapshot.data as List<Picture>).length,
                                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                                        itemBuilder: (BuildContext context, int index) {
                                          var abisiniyapic = (snapshot.data as List<Picture>)[index];
                                          return Container(
                                            height: 220,
                                            width: 300,
                                            color: Colors.white,
                                            child: InkWell(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 200,
                                                    // decoration: BoxDecoration(
                                                    //     image: DecorationImage(image: NetworkImage(abisiniyapic.imageUrl),
                                                    //         fit: BoxFit.cover)
                                                    // ),

                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(image: NetworkImage(abisiniyapic.imageUrl),
                                                            fit: BoxFit.cover)
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: ()
                                              {
                                                print('calling.......');
                                                print([index]);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            constraints:
                                            BoxConstraints(minHeight: constraint.maxHeight),
                                            child: IntrinsicHeight(
                                              child: Column(
                                                children: [
                                                  // SizedBox(
                                                  //   height: 10,
                                                  // ),
                                                  Column(
                                                      children: [
                                                        Column(
                                                            children: [
                                                              Container(
                                                                height: 40,
                                                                width: 340,
                                                                alignment: Alignment.topLeft,
                                                                color: Colors.white,
                                                                child: Text('Information',style: (TextStyle(fontSize: 22,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                              )
                                                            ]
                                                        ),
                                                      ]
                                                  ),
                                                  // middle widget goes here

                                                  Align(
                                                    alignment: Alignment.topCenter,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width: 150,
                                                              color: Colors.white,
                                                              child: Text('Category:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width: 175,
                                                              color: Colors.white,
                                                              child: Text('Accommodation',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              height: 60,
                                                              width: 150,
                                                              color: Colors.white,
                                                              child: Text('Address:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                            ),
                                                            Container(
                                                              height: 60,
                                                              width: 175,
                                                              color: Colors.white,
                                                              child: Text(RetrivedAdress,style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width: 150,
                                                              color: Colors.white,
                                                              child: Text('Location:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width: 175,
                                                              color: Colors.white,
                                                              child: Text(Retrivedcityvalue,style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width: 150,
                                                              color: Colors.white,
                                                              child: Text('Price:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width: 175,
                                                              color: Colors.white,
                                                              child: Text('${(RetrivedPrice)} /night',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              height: 60,
                                                              width: 150,
                                                              color: Colors.white,
                                                              child: Text('Specs & Utilities:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                            ),
                                                            Container(
                                                              height: 60,
                                                              width: 175,
                                                              color: Colors.white,
                                                              child: Text('${(RetrivedBathromm)} Bath, ${(RetrivedBedroom)} BedRoom',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Container(
                                                              height: 45,
                                                              width: 340,
                                                              child: Text('Booking Details',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w800,fontSize: 22),
                                                              ),),
                                                            SizedBox(height: 10,),
                                                            Container(
                                                              height: 45,
                                                              width: 340,
                                                              child: TextField(
                                                                  decoration: const InputDecoration(
                                                                    suffixIcon: Icon(Icons.calendar_month),
                                                                    hintText: 'From Date',
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                                                                  ),
                                                                  controller: FromdateInputController,
                                                                  readOnly: true,
                                                                  onTap: () async {

                                                                    DateTime? pickedDate = await showDatePicker(
                                                                        context: context,
                                                                        initialDate: DateTime.now(),
                                                                        firstDate: DateTime(1950),
                                                                        lastDate: DateTime(2050));
                                                                    if (pickedDate != null) {
                                                                      //FromdateInputController.text =pickedDate.toString();
                                                                      fromDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                                                                      FromdateInputController.text = fromDate;
                                                                    }

                                                                  }

                                                              ),),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              height: 45,
                                                              width: 340,
                                                              child: TextField(
                                                                  decoration: const InputDecoration(
                                                                    suffixIcon: Icon(Icons.calendar_month),
                                                                    hintText: 'To Date',
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                                                                  ),
                                                                  controller: TodateInputController,
                                                                  readOnly: true,
                                                                  onTap: () async {

                                                                    DateTime? pickedDate = await showDatePicker(
                                                                        context: context,
                                                                        initialDate: DateTime.now(),
                                                                        firstDate: DateTime(1950),
                                                                        lastDate: DateTime(2050));
                                                                    if (pickedDate != null) {
                                                                      //TodateInputController.text =pickedDate.toString();
                                                                      toDatestr = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                                                                      TodateInputController.text = toDatestr;
                                                                    }

                                                                  }

                                                              ),),
                                                            SizedBox(
                                                              height: 20,
                                                            ),

                                                            Container(
                                                              child:isLoading
                                                                  ? Center(child: CircularProgressIndicator())
                                                                  : TextButton(
                                                                style: TextButton.styleFrom(
                                                                    fixedSize: const Size(340, 50),
                                                                    foregroundColor: Colors.white,
                                                                    backgroundColor: Colors.blue,
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(00),
                                                                    ),
                                                                    textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                                                                child: Text('Book Now'),
                                                                onPressed: () async {
                                                                  setState(() => isLoading = true);
                                                                  _postData();
                                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                  prefs.setString('tokenkey', RetrivedBearertoekn);


                                                                  await Future.delayed(Duration(seconds: 3), () => () {});
                                                                  setState(() => isLoading = false);
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                      ]
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


