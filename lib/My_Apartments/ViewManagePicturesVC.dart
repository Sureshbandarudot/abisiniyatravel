import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:tourstravels/Auth/ForgotPassword.dart';
import 'package:tourstravels/Auth/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:tourstravels/shared_preferences.dart';
import 'package:tourstravels/Auth/forgotpwdemailVerify.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/UserDashboard_Screens/newDashboard.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'My_AprtmetsVC.dart';
import 'ViewAddPicVC.dart';
class ViewManagePictures extends StatefulWidget {

  const ViewManagePictures({super.key});

  @override
  State<ViewManagePictures> createState() => _userDashboardState();
}

class _userDashboardState extends State<ViewManagePictures> {

  final baseDioSingleton = BaseSingleton();
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String RetrivedBearertoekn = '';
  int ApartmentId = 0;
  int Picture_Id = 0;

  String image = '';
  var ViewApartmentList = [];
  var controller = ScrollController();
  int count = 15;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      RetrivedEmail = prefs.getString('emailkey') ?? "";
      RetrivedPwd = prefs.getString('passwordkey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      ApartmentId = prefs.getInt('userbookingId') ?? 0;
      Picture_Id = prefs.getInt('Picturekey') ?? 0;
      print('Retrived Ids....');
      print(ApartmentId);
      print(Picture_Id);
      print('view Apartment... ');
      print(RetrivedBearertoekn);
    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    getData();
  }
//@override
  File? galleryFile;
  final picker = ImagePicker();
  Future<void> _deleteData(int ApartmentId, int Picture_Id) async {
    try {
      print('delete url...');
      print('delete view Apartment... ');
      print(RetrivedBearertoekn);
      var url = '';
      url = (baseDioSingleton.AbisiniyaBaseurl + 'apartment/pictures/$ApartmentId/$Picture_Id');

      print(url);
      final response = await http
          .delete(Uri.parse(url),
        headers: {
          // 'Authorization':
          // 'Bearer <--your-token-here-->',
          "Authorization": "Bearer $RetrivedBearertoekn",

        },
      );

      //Error: You need to have at least 1 picture
      if (response.statusCode == 200) {
        print('Deleted successfully');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyApartmentScreen()
          ),
        );
      } else if (response.statusCode == 404) {
        final snackBar = SnackBar(
          content: Text('Error: You need to have at least 1 picture'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      else {
        throw Exception('Failed to delete data');
      }
    } catch (error) {
      print(error);
    }
  }


  Future<dynamic> getData() async {
    print('Apartmentid.....');
    print(ApartmentId);
    // String url = 'https://staging.abisiniya.com/api/v1/apartment/auth/show/' + ApartmentId.toString();
    String url = baseDioSingleton.AbisiniyaBaseurl + 'apartment/auth/show/' + ApartmentId.toString();

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
          print('img....');
          print(img);
          ViewApartmentList.add(img);
          print('len....');
          print(ViewApartmentList.length);
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
                                              //return  Text(' Vehicles',style: TextStyle(fontSize: 22),)
                                              return Column(
                                                children: [
                                                  Container(
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(image: NetworkImage(ViewApartmentList[index]),
                                                            fit: BoxFit.cover)
                                                    ),
                                                  ),
                                                  InkWell(
                                                    child: Container(
                                                      color: Colors.red,
                                                      child: Container(
                                                        width: 360,
                                                        height: 50,
                                                        color: Colors.transparent,
                                                        child:Align(
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
                                                            )
                                                        ),
                                                      ),                                                              ),
                                                    onTap: () {

                                                      _deleteData(ApartmentId,Picture_Id);
                                                      // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                      //   builder: (_) => ViewApartmnt(),
                                                      // ),);
                                                      print("value of your text");},
                                                  ),

                                                ],
                                              ) ;
                                            }),

                                      ],
                                    ),

                                    Column(
                                      children:<Widget>[
                                        Text('Add Picture',style: (TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: Colors.black54)),),
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
                                                    "Add",
                                                    style: TextStyle(
                                                        color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
                                                  )
                                              ),
                                            ),                                                              ),
                                          onTap: () async{
                                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                              builder: (_) => AddpicScreen(),
                                            ),);
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            prefs.setInt('userbookingId', ApartmentId);
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
