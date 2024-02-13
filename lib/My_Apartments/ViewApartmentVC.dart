
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

import 'ViewManagePicturesVC.dart';
//import 'NewUserbooking.dart';
class ViewApartmnt extends StatefulWidget {
  const ViewApartmnt({super.key});

  @override
  State<ViewApartmnt> createState() => _userDashboardState();
}

class _userDashboardState extends State<ViewApartmnt> {
  String RetrivedPwd = '';
   String RetrivedEmail = '';
   String RetrivedBearertoekn = '';
   int ApartmentId = 0;

   var ViewApartmentList = [];
   var PicArrayList = [];
   int Picture_Id = 0;
  var controller = ScrollController();
  int count = 15;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      RetrivedEmail = prefs.getString('emailkey') ?? "";
      RetrivedPwd = prefs.getString('passwordkey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      ApartmentId = prefs.getInt('userbookingId') ?? 0;
      print('view Apartment... ');
      print(RetrivedBearertoekn);
    });
  }
//@override

  Future<dynamic> getData() async {
    //String url = 'https://staging.abisiniya.com/api/v1/apartment/list';
    print('Apartmentid.....');
    print(ApartmentId);
    String url = 'https://staging.abisiniya.com/api/v1/apartment/auth/show/' + ApartmentId.toString();
    print('url...');
    print(url);
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
      var viewApartmentdata = data1['data'];
      print('data.....');

      for (var pics in viewApartmentdata){

        var picData = pics['pictures'];
        for (var picArray in picData){
          var img = picArray['imageUrl'];

          Picture_Id = picArray['id'];
          print('img....');
          print(img);
           ViewApartmentList.add(img);
           PicArrayList.add(Picture_Id);

        }
      }
      print('View Apartment success....');
     // print(ViewApartmentList);
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }


  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    getData();
    //pics = fetchpics();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.green
          ),
          title: Text('ABISINIYA',textAlign: TextAlign.center,
              style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

        ),
      body: FutureBuilder<dynamic>(
          //future: ViewgetData(),
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

                                    Container(
                                      height: 100,
                                      width: 340,
                                      color: Colors.black12,
                                      child: Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Apartment belonging to:",
                                                style: TextStyle(
                                                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                              )
                                          ),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                (snapshot.data?['data'].isEmpty ? 'Empty name'
                                                    : snapshot.data?["data"][0]['user_detail']?['name']?.toString()
                                                    ?? 'empty'),
                                                style: TextStyle(
                                                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                              )
                                          ),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                (snapshot.data?['data'].isEmpty ? 'Empty name'
                                                    : snapshot.data?["data"][0]['user_detail']?['email']?.toString()
                                                    ?? 'empty'),
                                                style: TextStyle(
                                                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),

                                    ListView.separated(
                                        //scrollDirection:Axis.horizontal,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        //itemCount:50,
                                        itemCount: snapshot.data?['data'].length ?? '',
                                        //itemCount: ViewApartmentList.length ,
                                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return Container(
                                            height: 250,
                                            width: 100,
                                            alignment: Alignment.center,
                                            color: Colors.black12,
                                            child: InkWell(

                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 250,
                                                    width: 340,
                                                    color: Colors.black12,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('Name:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['name']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Address:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['address']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('City:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['city']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Country:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['country']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('No Guests:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['guest']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Bedroom:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['bedroom']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('Bathroom:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['bathroom']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Price:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['price']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                          );
                                          //return  Text('Some text');
                                        }),

                                    Column(
                                      children:<Widget>[
                                        Text('Property Images',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black54)),),
                                        ListView.builder(
                                           physics: NeverScrollableScrollPhysics(),
                                            //scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            //itemCount: snapshot.data?['data'].length ?? '',
                                            itemCount: ViewApartmentList.length,

                                            itemBuilder: (context,index){
                                            Picture_Id = PicArrayList[index];
                                              //return  Text(' Vehicles',style: TextStyle(fontSize: 22),);
                                              return Column(
                                                children: [
                                                  InkWell(
                                                    child:Container(
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(image: NetworkImage(ViewApartmentList[index]),
                                                              fit: BoxFit.cover)
                                                      ),
                                                    ),
                                                    onTap: () {

                                                      Picture_Id = PicArrayList[index];
                                                      print('pic id..');
                                                      print(Picture_Id);
                                                    },
                                                  ),



                                                ],
                                              ) ;
                                            }),
                                        InkWell(
                                          child: Container(
                                            color: Colors.green,
                                            child: Container(
                                              width: 360,
                                              height: 50,
                                              color: Colors.transparent,
                                              child:Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Manage Pictures",
                                                    style: TextStyle(
                                                        color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
                                                  )
                                              ),
                                            ),                                                              ),
                                          onTap: () async{

                                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                              builder: (_) => ViewManagePictures(),
                                            ),);

                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            prefs.setInt('userbookingId', ApartmentId);
                                           prefs.setInt('Picturekey', Picture_Id);
                                            prefs.setString('tokenkey', RetrivedBearertoekn);

                                            print("value of your text");},
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
