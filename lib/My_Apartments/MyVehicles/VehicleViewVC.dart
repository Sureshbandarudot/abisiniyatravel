
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

import '../../UserDashboard_Screens/newDashboard.dart';
import 'VehicleManagePicturesVC.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import 'VehicleReviewRatingVC.dart';

import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';


//import 'ViewManagePicturesVC.dart';
//import 'NewUserbooking.dart';
class ViewVehicle extends StatefulWidget {
  const ViewVehicle({super.key});
  @override
  State<ViewVehicle> createState() => _userDashboardState();
}
class _userDashboardState extends State<ViewVehicle> {
  //suresh
  final baseDioSingleton = BaseSingleton();
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String RetrivedBearertoekn = '';
  int VehicleId = 0;
  int Rating_review = 0;
  String AvgRating_review = '';
  int avgRating = 0;
  var avglistMessage = '';
  var ViewApartmentList = [];
  var Reviewlist = [];
  var scoreRatinglist = [];
  var ReviewcreateDatelist = [];
  var PicArrayList = [];
  int Picture_Id = 0;
  String RetrivedProfileNamestr = '';
  String RetrivedProfileEmailstr = '';
  var controller = ScrollController();
  int count = 15;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      RetrivedEmail = prefs.getString('emailkey') ?? "";
      RetrivedPwd = prefs.getString('passwordkey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      VehicleId = prefs.getInt('userbookingId') ?? 0;
      print(RetrivedBearertoekn);
      RetrivedProfileNamestr = prefs.getString('Profilenamekey') ?? "";
      RetrivedProfileEmailstr = prefs.getString('Profileemailkey') ?? "";
    });
  }
//@override
  Future<dynamic> Review() async {
    //https://staging.abisiniya.com/api/v1/rating/vehicle/avgrating/81
    String url = baseDioSingleton.AbisiniyaBaseurl + 'rating/vehicle/avgrating/$VehicleId';
    print('avg vehicle rating...');
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
     // var data1 = jsonDecode(response.body.toString());
      var ReviewData = data1['data']['ratingDetails'];
      print('Review data.....');
      print(ReviewData);
      AvgRating_review = data1['data']['avgRating'];
      for (var Reviewmsg in ReviewData){
        var picReviewData = Reviewmsg['rating_comment'];
        var scoreArray = Reviewmsg['rating_score'];
        var createDateArray = Reviewmsg['created_at'];
        print('review array...');
        print(picReviewData);
        Reviewlist.add(picReviewData);
        scoreRatinglist.add(scoreArray);
        ReviewcreateDatelist.add(createDateArray);
        print('count...');
        print(ReviewcreateDatelist.length);
      }
      // print(ViewApartmentList);
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  Future<dynamic> getData() async {
    // String url = 'https://staging.abisiniya.com/api/v1/vehicle/auth/show/' + VehicleId.toString();
    String url = baseDioSingleton.AbisiniyaBaseurl + 'vehicle/auth/show/' + VehicleId.toString();

    print('url.....');
    print(url);
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
      var getpicsData = [];
      var viewApartmentdata = data1['data'];
      print('vehicle data.....');
      print(viewApartmentdata);
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
          leading: BackButton(
            onPressed: () async{
              print("back Pressed");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => newuserDashboard()),
              );
            },
          ),  iconTheme: IconThemeData(
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
                                                "Vehicle belonging to:",
                                                style: TextStyle(
                                                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                              )
                                          ),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                (RetrivedProfileNamestr),
                                                style: TextStyle(
                                                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                                              )
                                          ),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                (RetrivedProfileEmailstr),
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
                                            height: 400,
                                            width: 100,
                                            alignment: Alignment.center,
                                            color: Colors.black12,
                                            child: InkWell(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 400,
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
                                                              child: Text('Make:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['make']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Model:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['model']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('Year:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['year']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Engine Size:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['engine_size']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('Fuel Type:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['fuel_type']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Weight:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['weight']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('Color:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['color']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white,
                                                              child: Text('Transmission:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white,
                                                              child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                  : snapshot.data?["data"][index]?['transmission']?.toString() ?? 'empty'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.white70,
                                                              child: Text('Price:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.white70,
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
                                              builder: (_) => VehicleViewManagePictures(),
                                            ),);

                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            prefs.setInt('userbookingId', VehicleId);
                                            prefs.setInt('Picturekey', Picture_Id);
                                            prefs.setString('tokenkey', RetrivedBearertoekn);

                                            print("value of your text");},
                                        ),
                                      ],
                                    ),

                                    Column(
                                      children:<Widget>[
                                        FutureBuilder<dynamic>(
                                            future: Review(),
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
                                                    print('avg...');
                                                    print(AvgRating_review);
                                                    var myDouble = double.parse(AvgRating_review);
                                                    print(myDouble);
                                                    print(ReviewcreateDatelist.length);
                                                    avglistMessage = '${AvgRating_review}  average based on ${ReviewcreateDatelist.length} reviews.';
                                                    return Column(
                                                      children: [
                                                        Column(
                                                          children: [
                                               //Text('User Ratings',style: TextStyle(fontSize: 25,fontWeight:FontWeight.w900),),
                                                          Container(
                                                            height: 50,
                                                            width: 340,
                                                            child:                                                //Text('User Ratings',style: TextStyle(fontSize: 25,fontWeight:FontWeight.w900),),
                                                            Text('User Ratings',style: TextStyle(fontSize: 25,fontWeight:FontWeight.w900),),),
                                                            Container(
                                                              child: Column(
                                                                children: [
                                                                  RatingBarIndicator(
                                                                      rating: double.parse(AvgRating_review),
                                                                      itemCount: 5,
                                                                      itemSize: 40.0,
                                                                      itemBuilder: (context, _) => const Icon(
                                                                        Icons.star,
                                                                        color: Colors.orange,
                                                                      )),
                                                                ],
                                                              ),

                                                            ),
                                                            Container(
                                                              child:Text(avglistMessage,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w900),),
                                                              // child:Text('${(snapshot.data['data'][index]['price'].toString())}.00/Day.',textAlign: TextAlign.left,
                                                              //   style: (TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.green)),),
                                                            ),
                                                          ],),
                                                        //Text('User Ratings',style: TextStyle(fontSize: 25,fontWeight:FontWeight.w900),),
                                                        ListView.separated(
                                                            physics: NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            //itemCount:50,
                                                           // itemCount: snapshot.data['data'].length ?? '',
                                                            itemCount: snapshot.data["data"]['ratingDetails'].length ?? '',

                                                            //itemCount: snapshot.data?['data']['bookings'].length ?? "" ,
                                                            //itemCount: snapshot.data!['data'][0]['bookings'][0].length ?? 0,
                                                            //itemCount: snapshot.data?.length ?? 0,
                                                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                                                            itemBuilder: (BuildContext context, int index) {
                                                              //bookingID = snapshot.data['data'][index]['id'];
                                                              // (snapshot.data?['data'].isEmpty ? 'Empty name'
                                                              //     : snapshot.data?["data"][0]['user_detail']?['name']?.toString()
                                                              //     ?? 'empty'),
                                                              print('rating....');
                                                              print(Reviewlist[index].toString());
                                                              //print(scoreRatinglist[index].toString());
                                                              Rating_review = scoreRatinglist[index];
                                                              print('review score....');
                                                              print(Rating_review);
                                                             // print(snapshot.data['data']['ratingDetails']['rating_comment']);
                                                              // print((snapshot.data?['data']['ratingDetails'].isEmpty ? 'Empty name'
                                                              //     : snapshot.data?["data"]['ratingDetails'][index]['user_detail']['full_name']
                                                              //     ?? 'empty'),);
//                                                              Rating_review = snapshot.data['data'][index]['score'];
//                                                              print(Rating_review.toDouble());
// //    itemBuilder: (context,index){
                                                              return Container(
                                                                height: 220,
                                                                width: 100,
                                                                alignment: Alignment.center,
                                                                color: Colors.white,
                                                                child: InkWell(
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 20,
                                                                      ),
                                                                      Container(
                                                                        height: 190,
                                                                        width: 340,
                                                                        color: Colors.black12,
                                                                        child: Column(
                                                                          children: [
                                                                            Column(
                                                                              children: [
                                                                                Text(RetrivedProfileNamestr,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w900),),
                                                                              ],
                                                                            ),
                                                                        RatingBarIndicator(
                                                                                        rating: Rating_review.toDouble(),
                                                                                        itemCount: 5,
                                                                                        itemSize: 40.0,
                                                                                        itemBuilder: (context, _) => const Icon(
                                                                                          Icons.star,
                                                                                          color: Colors.orange,
                                                                                        )),
                                                                            Row(
                                                                              children: [
                                                                                Container(
                                                                                  height: 60,
                                                                                  width: 140,
                                                                                  color: Colors.white,
                                                                                  child: Text('Review:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                                ),
                                                                                Container(
                                                                                  height: 60,
                                                                                  width: 200,
                                                                                  color: Colors.white,
                                                                                  //child:Text(snapshot.data['data'][index]['name'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.green)),),

                                                                                  // child:Text(snapshot.data?['data'].isEmpty ? 'Empty name'
                                                                                  //     : snapshot.data?["data"][index]?['comment']?.toString() ?? 'empty',style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black))),
                                                                                  child:Text(Reviewlist[index].toString(),style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black))),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Container(
                                                                                  height: 60,
                                                                                  width: 140,
                                                                                  color: Colors.white,
                                                                                  child: Text('Date:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                                                                ),
                                                                                Container(
                                                                                  height: 60,
                                                                                  width: 200,
                                                                                  color: Colors.white,
                                                                                  //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                                                  child:Text(ReviewcreateDatelist[index].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 16,color: Colors.black)),),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),

                                                                    ],
                                                                  ),
                                                                  onTap: () async{
                                                                    // Navigator.push(
                                                                    //   context,
                                                                    //   MaterialPageRoute(
                                                                    //       builder: (context) => RatingScreen()),
                                                                    // );
                                                                    // SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                    //   print('booking id...');
                                                                    //   print(snapshot.data['data'][index]['id']);
                                                                    //   prefs.setString('makekey', snapshot.data['data'][index]['make']);
                                                                    //   prefs.setString('modelkey', snapshot.data['data'][index]['model']);
                                                                    //   prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                                                    //   prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                                    //   prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
                                                                    //   prefs.setString('tokenkey', RetrivedBearertoekn);
                                                                  },
                                                                ),
                                                              );
                                                              //return  Text('Some text');
                                                            })
                                                      ],
                                                    );
                                                  }
                                              }
                                            }
                                        )
                                      ],
                                    ),

                                Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              const Text(
                              'Leave Your Feedback',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),
                              ),

                                  InkWell(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VehicleRatingScreen()),
                                      );
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      print('Vehicle id...');
                                      prefs.setInt('userbookingId', VehicleId);
                                      prefs.setString('tokenkey', RetrivedBearertoekn);
                                    }, // Handle your onTap
                                    child:Container(
                                      height: 50,
                                      width: 340,
                                      color: Colors.green,
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('Review',
                                            style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w800
                                            ),
                                            textAlign: TextAlign.center),
                                      ),
                                    ),

                                  )

                                  // Container(
                                  //   height: 50,
                                  //   width: 340,
                                  //   color: Colors.green,
                                  //   child: const Align(
                                  //     alignment: Alignment.center,
                                  //     child: Text('Review',
                                  //         style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w800
                                  //         ),
                                  //         textAlign: TextAlign.center),
                                  //   ),
                                  // ),
                              ],
                              ),

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
