
import 'package:flutter/material.dart';
//import 'package:tourstravels/ApartVC/Add_Apartment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:tourstravels/ApartVC/Addaprtment.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'NewUserbooking.dart';

class userDashboard extends StatefulWidget {
  const userDashboard({super.key});

  @override
  State<userDashboard> createState() => _userDashboardState();
}

class _userDashboardState extends State<userDashboard> {

  int _counter = 0;
  int selectedIndex = 0;
  int imageID = 0;
  String citystr = '';
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  var controller = ScrollController();

  int count = 15;


  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      RetrivedEmail = prefs.getString('emailkey') ?? "";
      RetrivedPwd = prefs.getString('passwordkey') ?? "";
    });
  }
  //Login Authentication for Fresh or Existing user:
  void login(String email , password) async {

    try{

      Response response = await post(
          Uri.parse('https://staging.abisiniya.com/api/v1/login'),
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => UserBooking()
        //   ),
        // );
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
    controller = ScrollController()..addListener(handleScrolling);


  }
  void handleScrolling() {
    if (controller.offset >= controller.position.maxScrollExtent) {
      setState(() {
        count += 10;
      });
    }
  }
  Future<dynamic> getData() async {
    String url = 'https://staging.abisiniya.com/api/v1/apartment/list';
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
        centerTitle: true,
        title: const Text(
          'Navigation Drawer',
        ),
        backgroundColor: const Color(0xff764abc),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
        body: FutureBuilder<dynamic>(
            future: getData(),
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
                    return ListView.separated(
                      //itemCount: snapshot.data.length ,
                      controller: controller,
                      itemCount: snapshot.data['data'].length ,
                      //itemCount: (snapshot.data['data'] as List).length,
                      //Text(snapshot.data["data"][index]['pictures'][index]['imageUrl']),

                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        //
                        //                    // child:Text('${(snapshot.data['data'][index]['price'].toString())}.00/Night.',textAlign: TextAlign.left,
                        //
                        //                     print('id calling....');
                        //                       print(snapshot.data['data'][index]['id'].toString());
                        //                       int a = (snapshot.data['data'][index]['id']);
                        //                       // if (a == 30){
                        //                         //Image.network(snapshot.data["data"][index]['pictures'][index]['imageUrl']),
                        //                     // Text(snapshot.data['data'][index]['pictures'][index]['imageName']);
                        //                         print('images......');
                        //                         print(snapshot.data['data'][index]['pictures'][index]['imageName']);
                        //

                        var picstrr = snapshot.data['data'];
                        for (var record in picstrr) {
                          var pictures = record['pictures'];
                          print(pictures);
                          for(var pics in pictures) {
                            //var picname = pics['imageUrl'];
                            imageID = (snapshot.data['data'][index]['id']);
                            print('iD value...');
                            print(imageID);
                            if (30 == 30) {
                              var picname = pics['imageUrl'];
                              var picimg = pics['imageName'];
                              print('pic names');
                              print(picname);
                              print(picimg);
                            }
                            // print('pictures...');
                            // print(picname);
                          }
                        }
                        return Container(
                          height: 525,
                          width: 300,
                          color: Colors.white,
                          child: InkWell(
                            child: Column(
                              children: [
                                //Text(snapshot.data["data"][index]['pictures'][index]['imageUrl']),
                                //Image.network(snapshot.data["data"][index]['pictures'][index]['imageUrl']),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  height: 475,
                                  width: 300,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFffffff),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 15.0, // soften the shadow
                                          spreadRadius: 5.0, //extend the shadow
                                          offset: Offset(
                                            5.0, // Move to right 5  horizontally
                                            5.0, // Move to bottom 5 Vertically
                                          ),
                                        )
                                      ],
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 200,
                                        //color: Colors.green,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage(snapshot.data["data"][index]['pictures'][0
                                            ]['imageUrl']),
                                                fit: BoxFit.cover)
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 170,
                                        width: 300,
                                        color: Colors.white,
                                        child: Column(
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 280,
                                              height: 40,
                                              color: Colors.white,
                                              child:Text(snapshot.data['data'][index]['city'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 280,
                                              height: 70,
                                              color: Colors.white,
                                              //child: (Text(snapshot.data['data']['price'] as int)),
                                              child:Row(
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 140,
                                                    color: Colors.white,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 30,
                                                          width: 140,
                                                          child:Text('Start From',textAlign: TextAlign.start,style: (TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Colors.black)),),
                                                        ),
                                                        Container(
                                                          height: 30,
                                                          width: 140,
                                                          child:Text('${(snapshot.data['data'][index]['price'].toString())}.00/Night.',textAlign: TextAlign.left,
                                                            style: (TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.green)),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 60,
                                                    width: 140,
                                                    color: Colors.white,

                                                    child: TextButton(
                                                      style: TextButton.styleFrom(backgroundColor:Colors.green,fixedSize: Size.fromHeight(100)),
                                                      onPressed: () {},
                                                      child: const Text('BookNow'),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),

                                            Container(
                                              height: 50,
                                              width: 280,
                                              color: Colors.white,
                                              child:Text(snapshot.data['data'][index]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),

                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Container(
                                        height: 60,
                                        width: 280,
                                        color: Colors.green,
                                        child: Row(
                                          children: [

                                            Container(
                                              height: 40,
                                              width: 140,
                                              color: Colors.green,
                                              child:Text('${(snapshot.data['data'][index]['bedroom'].toString())} Bedroom(s)',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              width: 140,
                                              color: Colors.green,
                                              child:Text('${(snapshot.data['data'][index]['bathroom'].toString())} Bathroom(s)',textAlign: TextAlign.center,
                                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18), ),
                                            ),
                                          ],
                                        ),
                                        //child:Text(snapshot.data['data'][index]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),

                                      )
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


                              print('email....');
                              print(RetrivedEmail);
                              print('pwd...');
                              print(RetrivedPwd);
                              login(RetrivedEmail, RetrivedPwd);



                              //child:Text('${(snapshot.data['data'][index]['bathroom'].toString())} Bathroom(s)',textAlign: TextAlign.center,



                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => AddApartment()
                              //   ),
                              // );
                              print([index]);
                            },
                          ),
                        );
                      },
                    );
                  }
              }
            }
        )
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
