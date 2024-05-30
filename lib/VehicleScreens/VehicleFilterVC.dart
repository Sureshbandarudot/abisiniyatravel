import 'package:flutter/material.dart';
//import 'package:tourstravels/ApartVC/Add_Apartment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:tourstravels/ApartVC/Addaprtment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';

import '../ServiceDasboardVC.dart';
import 'CarHire_NewBookingVC.dart';
//import 'NewUserbooking.dart';
//void main() => runApp(Apartmentscreen());
class VehiclefilterSearchResultscreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);
  //final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  final baseDioSingleton = BaseSingleton();
  final borderRadius = BorderRadius.circular(20); // Image border
  int _counter = 0;
  int selectedIndex = 0;
  int imageID = 0;
  String citystr = '';
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String Logoutstr = '';
  String RetrivedCitylocation = '';
  String emptyName = '';
  String emptyBedroomstr = '';
  String emptyBathroomstr = '';
  String LoggedInUSerstr = '';
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      RetrivedCitylocation = prefs.getString('locationkey') ?? "";
      print('Retrived city loc....');
      print(RetrivedCitylocation);
      RetrivedEmail = prefs.getString('emailkey') ?? "";
      RetrivedPwd = prefs.getString('passwordkey') ?? "";
      Logoutstr = prefs.getString('logoutkey') ?? "";
      var propertytype = prefs.getString('Property_type') ?? "";
      print(propertytype);
      print('logout....');
      print(Logoutstr);
    });
  }


  //void SendRequesertSearch(String type , keyword) async {
  Future<dynamic> SendRequesertSearch() async {
    try{
      print('search url...');
      print(RetrivedCitylocation);
      print(baseDioSingleton.AbisiniyaBaseurl +'common/search');
      Response response = await post(
        //Uri.parse('https://staging.abisiniya.com/api/v1/login'),
          Uri.parse(baseDioSingleton.AbisiniyaBaseurl +'common/search'),
          body: {
            'type' : 'vehicle',
            'keyword' : RetrivedCitylocation
          }

      );
      //isLoading = true;
      if(response.statusCode == 200){
        //isLoading = false;
        print('success search api response');
        // var data = jsonDecode(response.body.toString());
        // var data1 = jsonDecode(response.body.toString());
        // print(data1['data']);
        print('success.....');
        final data = jsonDecode(response.body);
        print(data);
        return json.decode(response.body);
        // print(data1['data']['token']);
        // tokenvalue = (data1['data']['token']);
        // String namestr = (data1['data']['name']);
        // print('token value....');
        // print(tokenvalue);
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('tokenkey', tokenvalue);

      }else {
        print('failed');
        //final snackBar = SnackBar(
        //   content: Text('Hi, Invalid login credentials'),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }catch(e){
      print(e.toString());
    }
  }


  //Login Authentication for Fresh or Existing user:
  void login(String email , password) async {
    try{
      Response response = await post(
        //Uri.parse('https://staging.abisiniya.com/api/v1/login'),
          Uri.parse(baseDioSingleton.AbisiniyaBaseurl + 'login'),
          body: {
            'email' : RetrivedEmail,
            'password' : RetrivedPwd
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('User Login Authentication  successfully');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddApartment()
          ),
        );

      }else {
        print('failed');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CarHire_NewUserBooking()
          ),
        );
        print('User Login not Authentication  successfully');

      }
    }catch(e){
      print(e.toString());
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    SendRequesertSearch();

  }

  Future<dynamic> getData() async {
    //String url = 'https://staging.abisiniya.com/api/v1/apartment/list';
    //String url = baseDioSingleton.AbisiniyaBaseurl + 'apartment/list';
    String url = baseDioSingleton.AbisiniyaBaseurl + 'vehicle/list';

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
          title: Text('Search Result',textAlign: TextAlign.center,
              style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.white, Colors.green]),
            ),
            child: FutureBuilder(
              //future: SendRequesertSearch(),
                future: SendRequesertSearch(),


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
                        return Column(
                          children: [
                            Expanded(child: Container(

                                child: LayoutBuilder(
                                    builder: (context, constraint) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          // mainAxisSize: MainAxisSize.min,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[

                                            SizedBox(
                                              height: 20,
                                            ),
                                            // Container(
                                            //   height: 50,
                                            //   width: 330,
                                            //   //color: Colors.lightGreen,
                                            //   decoration: const BoxDecoration(
                                            //       gradient: LinearGradient(
                                            //           begin: Alignment.topCenter,
                                            //           end: Alignment.bottomCenter,
                                            //           colors: <Color>[Colors.blueGrey, Colors.green]),
                                            //       borderRadius: BorderRadius.all(Radius.circular(30))
                                            //
                                            //   ),
                                            //   child: Row(
                                            //     children: [
                                            //       Container(
                                            //           margin: const EdgeInsets.only(left: 20.0),
                                            //
                                            //           child: SizedBox(
                                            //             width: 220.0,
                                            //             height: 50,
                                            //             child: TextField(
                                            //               decoration: InputDecoration(
                                            //                 //border: OutlineInputBorder(),
                                            //                 border: InputBorder.none,
                                            //                 hintText: 'Search',
                                            //               ),
                                            //               controller: searchController,
                                            //               style: TextStyle(fontSize: 18.0, height: 0.0, color: Colors.black),
                                            //             ),
                                            //           )
                                            //       ),
                                            //       Container(
                                            //           margin: const EdgeInsets.only(left: 20.0),                                         child: IconButton(
                                            //         onPressed: () async{
                                            //           print('search btn clicked...');
                                            //           final prefs = await SharedPreferences.getInstance();
                                            //           await prefs.setString('locationkey', searchController.text);
                                            //
                                            //
                                            //         },
                                            //         icon: const Icon(Icons.search),
                                            //       )
                                            //       )
                                            //     ],
                                            //
                                            //   ),
                                            //
                                            // ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                                height: 510, // <-- you should put some value here
                                                child: ListView.separated(

                                                  scrollDirection: Axis.vertical,
                                                  itemCount: snapshot.data['data'].length ,

                                                  separatorBuilder: (BuildContext context, int index) => const Divider(),

                                                  itemBuilder: (BuildContext context, int index) {
                                                    print('null value...');
                                                    print(snapshot.data['data'][index]['name'].toString() ?? '');

                                                    if((snapshot.data['data'][index]['name'].toString() ?? '') != null){

                                                      emptyName == '';
                                                      print('empty name value...');
                                                      print(emptyName);
                                                    } else {

                                                      emptyName == (snapshot.data['data'][index]['name'].toString() ?? '');
                                                    }
                                                    return Container(
                                                      //margin: EdgeInsets.all(35),// add margin
                                                      color: Colors.white,
                                                      child: InkWell(
                                                        child: Column(
                                                          children: [
                                                            // SizedBox(
                                                            //   height: 25,
                                                            // ),
                                                            Container(
                                                              height: 475,
                                                              width: 300,
                                                              margin: EdgeInsets.only(top: 0, left: 0),

                                                              decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors.black,
                                                                    width: 0.0,
                                                                    style: BorderStyle.solid
                                                                ),
                                                                borderRadius: BorderRadius.circular(20),
                                                                //color: Colors.yellowAccent,
                                                                color: Colors.white,
                                                              ),
                                                              // decoration: const BoxDecoration(
                                                              //     color: Color(0xFFffffff),
                                                              //     boxShadow: [
                                                              //       BoxShadow(
                                                              //         color: Colors.white,
                                                              //         blurRadius: 15.0, // soften the shadow
                                                              //         spreadRadius: 5.0, //extend the shadow
                                                              //         offset: Offset(
                                                              //           5.0, // Move to right 5  horizontally
                                                              //           5.0, // Move to bottom 5 Vertically
                                                              //         ),
                                                              //       )
                                                              //     ],
                                                              //     borderRadius: BorderRadius.all(Radius.circular(10))
                                                              // ),
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
                                                                                          child:Text('${(snapshot.data['data'][index]['price'].toString())}.00/Day.',textAlign: TextAlign.left,
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
                                                                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                        print('dashboard sts...');
                                                                                        print(Logoutstr);
                                                                                        LoggedInUSerstr = prefs.getString('LoggedinUserkey') ?? "";
                                                                                        print(' logged in user...');
                                                                                        print(LoggedInUSerstr);
                                                                                        print('letters length....');
                                                                                        // LoggedinUserlist.add(LoggedInUSerstr);
                                                                                        // print(LoggedinUserlist);
                                                                                        // print(LoggedinUserlist.length);
                                                                                        // if (LoggedInUSerstr == 'LoggedUser') {
                                                                                        //   print('login...');
                                                                                        //   Navigator.push(
                                                                                        //     context,
                                                                                        //     MaterialPageRoute(
                                                                                        //         builder: (context) => CarHire_ExistingBookingScreen()),
                                                                                        //   );
                                                                                        //   SharedPreferences prefrences = await SharedPreferences.getInstance();
                                                                                        //   await prefrences.remove("LoggedinUserkey");
                                                                                        //
                                                                                        // }  else{
                                                                                        //   Navigator.push(
                                                                                        //     context,
                                                                                        //     MaterialPageRoute(
                                                                                        //         builder: (context) => CarHire_NewUserBooking()
                                                                                        //     ),
                                                                                        //   );
                                                                                        // }
                                                                                        prefs.setString('namekey', snapshot.data['data'][index]['name'] ?? '');
                                                                                        prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                                                        prefs.setInt('imgkeyId', snapshot.data['data'][index]['id']);
                                                                                        prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                                                                        prefs.setString('bookable_type', ('Vehicle'));


                                                                                        Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                              builder: (context) => CarHire_NewUserBooking()
                                                                                          ),
                                                                                        );
                                                                                        // SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                        //  prefs.setString('namekey', snapshot.data['data'][index]['name']);
                                                                                        //  prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                                                        //  prefs.setInt('imgkeyId', snapshot.data['data'][index]['id']);
                                                                                        //  prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                                                                        //  prefs.setString('bookable_type', ('Vehicle'));
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
                                                                    width: 330,
                                                                    color: Colors.white,
                                                                    child:Container(
                                                                      // width: 300,
                                                                      // height: 50,
                                                                      color: Colors.white,
                                                                      child: Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child:Text('${emptyName}',textAlign: TextAlign.left,
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
                                                )
                                                // child: ListView.separated(
                                                //   // physics: NeverScrollableScrollPhysics(),
                                                //   // shrinkWrap: true,
                                                //   scrollDirection: Axis.vertical,
                                                //   itemCount: snapshot.data['data'].length ,
                                                //   separatorBuilder: (BuildContext context, int index) => const Divider(),
                                                //   itemBuilder: (BuildContext context, int index) {
                                                //
                                                //     if((snapshot.data['data'][index]['name'].toString() ?? '') != null){
                                                //
                                                //       emptyName == '';
                                                //       print('empty name value...');
                                                //       print(emptyName);
                                                //     } else {
                                                //
                                                //       emptyName == (snapshot.data['data'][index]['name'].toString() ?? '');
                                                //     }
                                                //     if((snapshot.data['data'][index]['bedroom'].toString() ?? '') != null){
                                                //       emptyBedroomstr == '';
                                                //       print('empty bed value...');
                                                //       print(emptyName);
                                                //     } else {
                                                //
                                                //       emptyBedroomstr == (snapshot.data['data'][index]['bathroom'].toString() ?? '');
                                                //     }
                                                //     if((snapshot.data['data'][index]['name'].toString() ?? '') != null){
                                                //
                                                //       emptyBathroomstr == '';
                                                //       print('empty bath value...');
                                                //       print(emptyName);
                                                //     } else {
                                                //
                                                //       emptyBathroomstr == (snapshot.data['data'][index]['name'].toString() ?? '');
                                                //     }
                                                //
                                                //     var picstrr = snapshot.data['data'];
                                                //     for (var record in picstrr) {
                                                //       var pictures = record['pictures'];
                                                //       print(pictures);
                                                //       for(var pics in pictures) {
                                                //         //var picname = pics['imageUrl'];
                                                //         imageID = (snapshot.data['data'][index]['id']);
                                                //         print('iD value...');
                                                //         print(imageID);
                                                //         if (30 == 30) {
                                                //           var picname = pics['imageUrl'];
                                                //           var picimg = pics['imageName'];
                                                //           print('pic names');
                                                //           print(picname);
                                                //           print(picimg);
                                                //         }
                                                //       }
                                                //     }
                                                //     return Container(
                                                //       height: 510,
                                                //       width: 300,
                                                //       //margin: EdgeInsets.all(Top:20),// add margin
                                                //       //padding: EdgeInsets.all(20),
                                                //       margin: EdgeInsets.only(top: 0, left: 20,right: 20),
                                                //
                                                //       decoration: BoxDecoration(
                                                //         border: Border.all(
                                                //             color: Colors.black,
                                                //             width: 0.0,
                                                //             style: BorderStyle.solid
                                                //         ),
                                                //         borderRadius: BorderRadius.circular(20),
                                                //         //color: Colors.yellowAccent,
                                                //         color: Colors.white,
                                                //       ),
                                                //       child: InkWell(
                                                //         child: Column(
                                                //           children: [
                                                //             SizedBox(
                                                //               height: 25,
                                                //             ),
                                                //             Container(
                                                //               height: 475,
                                                //               width: 300,
                                                //               decoration: const BoxDecoration(
                                                //                   color: Color(0xFFffffff),
                                                //                   boxShadow: [
                                                //                     BoxShadow(
                                                //                       color: Colors.white,
                                                //                       blurRadius: 15.0, // soften the shadow
                                                //                       spreadRadius: 5.0, //extend the shadow
                                                //                       offset: Offset(
                                                //                         5.0, // Move to right 5  horizontally
                                                //                         5.0, // Move to bottom 5 Vertically
                                                //                       ),
                                                //                     )
                                                //                   ],
                                                //                   borderRadius: BorderRadius.all(Radius.circular(10))
                                                //               ),
                                                //               child: Column(
                                                //                 children: [
                                                //                   SizedBox(
                                                //                     height: 10,
                                                //                   ),
                                                //                   Container(
                                                //                     height: 200,
                                                //                     //color: Colors.green,
                                                //                     decoration: BoxDecoration(
                                                //                         image: DecorationImage(image: NetworkImage(snapshot.data["data"][index]['pictures'][0
                                                //                         ]['imageUrl']),
                                                //                             fit: BoxFit.cover)
                                                //                     ),
                                                //                   ),
                                                //                   SizedBox(
                                                //                     height: 10,
                                                //                   ),
                                                //                   Container(
                                                //                     height: 170,
                                                //                     width: 300,
                                                //                     color: Colors.white,
                                                //                     child: Column(
                                                //                       //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //                       //crossAxisAlignment: CrossAxisAlignment.start,
                                                //                       children: [
                                                //                         SizedBox(
                                                //                           width: 10,
                                                //                         ),
                                                //                         Container(
                                                //                           width: 280,
                                                //                           height: 40,
                                                //                           color: Colors.white,
                                                //                           child:Text(snapshot.data['data'][index]['city'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),
                                                //                         ),
                                                //                         SizedBox(
                                                //                           width: 5,
                                                //                         ),
                                                //                         Container(
                                                //                           width: 280,
                                                //                           height: 70,
                                                //                           color: Colors.white,
                                                //                           //child: (Text(snapshot.data['data']['price'] as int)),
                                                //                           child:Row(
                                                //                             children: [
                                                //                               Container(
                                                //                                 height: 60,
                                                //                                 width: 140,
                                                //                                 color: Colors.white,
                                                //                                 child: Column(
                                                //                                   children: [
                                                //                                     Container(
                                                //                                       height: 30,
                                                //                                       width: 140,
                                                //                                       child:Text('Start From',textAlign: TextAlign.start,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)),),
                                                //                                     ),
                                                //                                     Container(
                                                //                                       height: 30,
                                                //                                       width: 140,
                                                //                                       child:Text('${(snapshot.data['data'][index]['price'].toString())}.00/Day.',textAlign: TextAlign.left,
                                                //                                         style: (TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.green)),),
                                                //                                     ),
                                                //                                   ],
                                                //                                 ),
                                                //                               ),
                                                //                               Container(
                                                //                                 height: 40,
                                                //                                 width: 140,
                                                //                                 color: Colors.white,
                                                //
                                                //                                 child: TextButton(
                                                //                                   style: TextButton.styleFrom(backgroundColor:Colors.green),
                                                //                                   onPressed: () async {
                                                //
                                                //                                     SharedPreferences prefs = await SharedPreferences.getInstance();
                                                //                                     prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                //                                     prefs.setInt('imgkeyId', snapshot.data['data'][index]['id']);
                                                //                                     prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                                //                                     prefs.setString('bathroomkey', (snapshot.data['data'][index]['bathroom'].toString()));
                                                //                                     prefs.setString('bedroomkey', (snapshot.data['data'][index]['bedroom'].toString()));
                                                //                                     prefs.setString('pricekey', (snapshot.data['data'][index]['price'].toString()));
                                                //                                     prefs.setString('Property_type', ('Apartment'));
                                                //                                     prefs.setString('emailkey', (RetrivedEmail));
                                                //                                     prefs.setString('passwordkey', (RetrivedPwd));
                                                //                                     print('email....');
                                                //                                     print(RetrivedEmail);
                                                //                                     print('pwd...');
                                                //                                     print(RetrivedPwd);
                                                //                                     print('logout......');
                                                //                                     print(Logoutstr);
                                                //                                     // Navigator.push(
                                                //                                     //   context,
                                                //                                     //   MaterialPageRoute(
                                                //                                     //       builder: (context) => CarHire_NewUserBooking()
                                                //                                     //   ),
                                                //                                     // );
                                                //                                     Navigator.push(
                                                //                                       context,
                                                //                                       MaterialPageRoute(
                                                //                                           builder: (context) => CarHire_NewUserBooking()
                                                //                                       ),
                                                //                                     );
                                                //                                     // SharedPreferences prefs = await SharedPreferences.getInstance();
                                                //                                     prefs.setString('namekey', snapshot.data['data'][index]['name']);
                                                //                                     prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                //                                     prefs.setInt('imgkeyId', snapshot.data['data'][index]['id']);
                                                //                                     prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                                //                                     prefs.setString('bookable_type', ('Vehicle'));
                                                //                                   },
                                                //                                   //child: const Text('BookNow'),
                                                //                                   child: const Text('Drive Now',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                                                //
                                                //                                 ),
                                                //                               )
                                                //                             ],
                                                //                           ),
                                                //                         ),
                                                //                         SizedBox(
                                                //                           width: 10,
                                                //                         ),
                                                //
                                                //                         Container(
                                                //                           height: 50,
                                                //                           width: 280,
                                                //                           color: Colors.white,
                                                //                           child:Text(snapshot.data['data'][index]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green)),),
                                                //
                                                //                         ),
                                                //                       ],
                                                //                     ),
                                                //                   ),
                                                //                   SizedBox(
                                                //                     height: 24,
                                                //                   ),
                                                //                   Container(
                                                //                     height: 60,
                                                //                     width: 280,
                                                //                     color: Colors.green,
                                                //                     child: Row(
                                                //                       children: [
                                                //
                                                //                         Container(
                                                //                           height: 40,
                                                //                           width: 140,
                                                //                           color: Colors.green,
                                                //                           child:Text('${(emptyBedroomstr)} Bedroom(s)',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),textAlign: TextAlign.center,
                                                //                           ),
                                                //                         ),
                                                //                         Container(
                                                //                           height: 40,
                                                //                           width: 140,
                                                //                           color: Colors.green,
                                                //                           child:Text('${(emptyBathroomstr)} Bathroom(s)',textAlign: TextAlign.center,
                                                //                             style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18), ),
                                                //                         ),
                                                //                       ],
                                                //                     ),
                                                //                   )
                                                //                 ],
                                                //               ),
                                                //             ),
                                                //           ],
                                                //         ),
                                                //         //onTap: ()
                                                //         onTap: ()async{
                                                //           print([index]);
                                                //         },
                                                //       ),
                                                //     );},
                                                // )
                                            ),
                                            Column(
                                              children: [
                                                Text('Popular Offers',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800),)
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                )))
                          ],
                        );
                      }
                  }
                }
            )
        )
    );
  }
}
