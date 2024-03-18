import 'dart:convert';
//import 'package:apartmentdataparsing/models/Apartmentdata.dart';
import 'package:tourstravels/ApartVC/ApartmentAddmodel/Apartmentdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import 'package:intl/intl.dart';
import 'package:tourstravels/userDashboardvc.dart';
import 'package:tourstravels/UserDashboard_Screens/newDashboard.dart';
//import 'models/user.dart';

import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
class BusHire_ExistingBookingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<BusHire_ExistingBookingScreen> {
  final baseDioSingleton = BaseSingleton();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController surnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController pwd_confirmcontroller = TextEditingController();
  TextEditingController FromdateInputController = TextEditingController();
  TextEditingController TodateInputController = TextEditingController();

  //final baseDioSingleton = BaseSingleton();
//   print(baseDioSingleton.Appname);
  //List listUsers= [];
  //Future? listUsers;;

  String bookable_type = '';
  String RetrivedBearertoekn = '';
  bool isLoading = false;
  int Bookable_iD = 0;
  String Bookable_type = '';
  String result = '';
  String fromDatestr = '';
  String toDatestr = '';


  int idnum = 0;
  int aptId = 0;
  int carid = 0;
  String Retrivedcityvalue = '';
  String RetrivedAdress = '';
  String RetrivedBathromm = '';
  String RetrivedBedroom = '';
  String RetrivedPrice = '';
  String NewUsertxt = 'This will automatically create a new account for you. If you already have an account please login here.';
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
      carid = prefs.getInt('caridkey') ?? 0;

      bookable_type = prefs.getString('bookable_type') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";

    });
  }

  Future<dynamic>BusHiregetData() async {
    print('id value...');
    print(carid);
    // String url = 'https://staging.abisiniya.com/api/v1/bus/detail/$carid';
    String url = baseDioSingleton.AbisiniyaBaseurl + 'bus/detail/$carid';

    var response = await http.get(
      Uri.parse(
          url),
      headers: {
        // 'Authorization':
        // 'Bearer <--your-token-here-->',
        //"Authorization": "Bearer $RetrivedBearertoekn",

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

  Future<void> _postData() async {
    try {
      String apiUrl = '';
      apiUrl = baseDioSingleton.AbisiniyaBaseurl + 'booking/vehicle/booking/authuser';
      print('url.....1');
      print(apiUrl);
      print('bearer token vehicle auth...');
      print(RetrivedBearertoekn);
      print(bookable_type);
      print(carid);
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $RetrivedBearertoekn",
        },
        body: jsonEncode(<String, dynamic>{
          // 'name': namecontroller.text,
          // 'surname': surnamecontroller.text,
          // 'email': emailcontroller.text,
          // 'phone': phonecontroller.text,
          // 'password': passwordcontroller.text,
          // 'password_confirmation': pwd_confirmcontroller.text,
          'start_date': FromdateInputController.text,
          'end_date': TodateInputController.text,
          'bookable_type': bookable_type,
          'bookable_id': carid
          // Add any other data you want to send in the body
        }),
      );

      print('auth ... sts authenticated...');
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(response.body);
        print('Apartment fresh user data successfully posted');
        print(responseData);
        var data = jsonDecode(response.body.toString());
        print(data['message']);
        RetrivedBearertoekn = data['data']['token'];
        print('token generated...');
        print(RetrivedBearertoekn);
        if (data['message'] == 'Thank you for booking request')
        {
          print('not calling....');
          final snackBar = SnackBar(
            content: Text(data['message']),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // print('calling....');
          // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          //   builder: (_) => newuserDashboard(),
          // ),);
        } else {
          print('vehicle authenticated calling....');
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (_) => newuserDashboard(),
          ),);
          print(RetrivedBearertoekn);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('tokenkey', RetrivedBearertoekn);
        }
        //}
        setState(() {
          //result = 'ID: ${responseData['id']}\nName: ${responseData['name']}\nEmail: ${responseData['email']}';
        });
      } else if (response.statusCode == 404){
        var data = jsonDecode(response.body.toString());
        final snackBar = SnackBar(
          content: Text('You can book your own vehicle.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);


      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  //@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    // listUsers = fetchUsers();
    // pics = fetchpics();
    _postData();
    BusHiregetData();
  }
   //String url = 'https://staging.abisiniya.com/api/v1/apartment/list';
  //String url = baseDioSingleton.AbisiniyaBaseurl + 'apartment/list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        //future: pics,
          future: BusHiregetData(),
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
                                //scrollDirection: Axis.horizontal,
                                physics: ScrollPhysics(),

                                child: Column(
                                  children: [

                                    ListView.separated(
                                      //scrollDirection:Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      //itemCount: (snapshot.data as List<Picture>).length,
                                      itemCount: snapshot.data?["data"]['pictures'].length ?? '',

                                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                                      itemBuilder: (BuildContext context, int index) {
                                        //var abisiniyapic = (snapshot.data as List<Picture>)[index];
                                        return Container(
                                          height: 220,
                                          width: 300,
                                          color: Colors.white,
                                          child: InkWell(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 200,
                                                  // child:Text(
                                                  //   (snapshot.data?['data']['pictures'].isEmpty ? 'Empty name'
                                                  //       : snapshot.data?["data"]['pictures'][index]['imageUrl'].toString()
                                                  //       ?? 'empty'),
                                                  //   style: TextStyle(
                                                  //       color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                                                  // ),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(image: NetworkImage((snapshot.data?['data']['pictures'].isEmpty ? 'Empty name'
                                                          : snapshot.data?["data"]['pictures'][index]['imageUrl'].toString()
                                                          ?? 'empty')),
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
                                                            // Container(
                                                            //   height: 50,
                                                            //   width: 280,
                                                            //   color: Colors.orange,
                                                            //   // child:Text(snapshot.data['data'][10]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),
                                                            // ),
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
                                                            child: Text('Transport',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

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
                                                            child: Text((snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                : snapshot.data?["data"]['address'].toString()
                                                                ?? 'empty'),style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

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
                                                            child: Text(((snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                : snapshot.data?["data"]['city'].toString()
                                                                ?? 'empty') + (snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                : snapshot.data?["data"]['coutry'].toString()
                                                                ?? 'empty')),style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

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
                                                            child: Text('${((snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                : snapshot.data?["data"]['price'].toString()
                                                                ?? 'empty'))} /night',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

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
                                                          // Container(
                                                          //   height: 60,
                                                          //   width: 175,
                                                          //   color: Colors.white,
                                                          //   child: Text('${(RetrivedBathromm)} Bath, ${(RetrivedBedroom)} BedRoom',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),
                                                          //
                                                          // )
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
                                                            child: Text('Transmission:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                          ),
                                                          Container(
                                                            height: 60,
                                                            width: 175,
                                                            color: Colors.white,
                                                            child: Text((snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                : snapshot.data?["data"]['transmission'].toString()
                                                                ?? 'empty'),style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

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
                                                            child: Text('Fuel Type:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                          ),
                                                          Container(
                                                            height: 60,
                                                            width: 175,
                                                            color: Colors.white,
                                                            child: Text((snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                : snapshot.data?["data"]['fuel_type'].toString()
                                                                ?? 'empty'),style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

                                                          )
                                                        ],
                                                      ),

                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Column(
                                                        children: [
                                                          Container(
                                                            height: 100,
                                                            width: 340,
                                                            color: Colors.white,
                                                            child: Text(NewUsertxt,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),) ,
                                                          ),

                                                          SizedBox(
                                                            height: 10,
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
                                                                    // FromdateInputController.text =pickedDate.toString();
                                                                    fromDatestr = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                                                    FromdateInputController.text = fromDatestr;
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
                                                                //setState(() => isLoading = true);
                                                                _postData();
                                                                print('new booking calling token1....');
                                                                print(RetrivedBearertoekn);
                                                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                prefs.setString('tokenkey', RetrivedBearertoekn);

                                                                await Future.delayed(Duration(seconds: 3), () => () {});
                                                                setState(() => isLoading = false);
                                                              },
                                                            ),
                                                          )
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


