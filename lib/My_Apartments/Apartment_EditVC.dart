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
class AptmentEdit extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<AptmentEdit> {

  String RetrivedBearertoekn = '';
  String RetrivedName = '';
  String RetrivedAddress = '';
  String RetrivedCity = '';
  String RetrivedCountry = '';
  int RetrivedGuest = 0;
  int RetrivedBedroom = 0;
  int RetrivedBathroom = 0;
  int RetrivedPrice = 0;
  int ApartmentID = 0;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
      nameController.text = prefs.getString('namekey') ?? "";
      addressController.text = prefs.getString('addresskey') ?? "";
      cityController.text = prefs.getString('citykey') ?? "";
      countryController.text = prefs.getString('countrykey') ?? "";
      RetrivedGuest = prefs.getInt('guestkey') ?? 0;
      RetrivedBedroom = prefs.getInt('bedroomkey') ?? 0;
      RetrivedBathroom = prefs.getInt('bathroomkey') ?? 0;
      RetrivedPrice = prefs.getInt('pricekey') ?? 0;
      ApartmentID = prefs.getInt('userbookingId') ?? 0;
      print('price...');
      print(RetrivedPrice);
      print(ApartmentID);
      guestController.text = RetrivedGuest.toString();
      bedroomController.text = RetrivedBedroom.toString();
      bathroomController.text = RetrivedBathroom.toString();
      priceController.text = RetrivedPrice.toString();
      // guestController.text = prefs.getInt(''guestkey'') ?? 0.toString();
      //ApartmentId = prefs.getInt('userbookingId') ?? 0;
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      print('create Apartment token');
      print(RetrivedBearertoekn);
    });
  }

  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController guestController = TextEditingController();
  TextEditingController bedroomController = TextEditingController();
  TextEditingController bathroomController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  // nameController.text = RetrivedName;
  // String tokenvalue = '';

  String dropdownvalue = 'Active';

// List of items in our dropdown menu
  var items = [
    'Select Status',
    'Active',
    'Inactive',
    'Pending',
  ];
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
  }
  File? galleryFile;
  final picker = ImagePicker();
  @override
  //Update API Request
  Future<String> Update() async {
    final response = await http.put(
      // Uri.parse('https://staging.abisiniya.com/api/v1/apartment/update/$ApartmentID'),
      Uri.parse(baseDioSingleton.AbisiniyaBaseurl + 'apartment/update/$ApartmentID'),

      headers: {
    "Authorization":"Bearer $RetrivedBearertoekn"
    },
      body: {
        'name': nameController.text,
        'address': addressController.text,
        'city': cityController.text,
        'country': countryController.text,
        'guest': guestController.text.toString(),
        'bedroom': bedroomController.text.toString(),
        'bathroom': bathroomController.text.toString(),
        'price': priceController.text.toString(),
        'status': dropdownvalue,
      },
    );

    print('status code...');
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('succesfully Edited');
      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (_) => MyApartmentScreen(),
      ),);
      return response.body;
    } else {
      return "Error ${response.statusCode}: ${response.body}";
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
        body: Column(
          children: <Widget>[
            Container(color: Colors.white, height: 50),
            Expanded(
              child: Container(
                color: Colors.white,
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              Container(
                                  height: 700.0,
                                  width: 325.0,
                                  decoration: const BoxDecoration(
                                    //color: Color(0xFFffffff),
                                    color: Colors.white70,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 15.0, // soften the shadow
                                        spreadRadius: 5.0, //extend the shadow
                                        offset: Offset(
                                          5.0, // Move to right 5  horizontally
                                          5.0, // Move to bottom 5 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 125,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 60.0,
                                            child: Image.asset(
                                                "images/logo2.png",
                                                height: 100.0,
                                                width: 125.0,
                                                fit: BoxFit.fill
                                            ),
                                          )
                                      ),
                                      Text(
                                        "Create Apartment",
                                        textAlign: TextAlign.center ,
                                        style: TextStyle(
                                            color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26),),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(00.0),
                                        padding: EdgeInsets.only(top: 05.0,
                                            left: 15.0,
                                            right: 05.0),
                                        //color: Colors.white30,
                                        color: Colors.white,
                                        width: 300.0,
                                        height: 40.0,
                                        child: TextField(
                                            controller: nameController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field

                                            new InputDecoration.collapsed(
                                                hintText: 'name')),
                                      ),

                                      SizedBox(height: 10,),
                                      Container(
                                        margin: const EdgeInsets.all(00.0),
                                        padding: EdgeInsets.only(top: 05.0,
                                            left: 15.0,
                                            right: 05.0),
                                        //color: Colors.white30,
                                        color: Colors.white,
                                        width: 300.0,
                                        height: 40.0,
                                        child: TextField(
                                            controller: addressController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'address')),
                                      ),


                                      SizedBox(height: 10,),
                                      Container(
                                        margin: const EdgeInsets.all(00.0),
                                        padding: EdgeInsets.only(top: 05.0,
                                            left: 15.0,
                                            right: 05.0),
                                        //color: Colors.white30,
                                        color: Colors.white,
                                        width: 300.0,
                                        height: 40.0,
                                        child: TextField(
                                            controller: cityController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'city')),
                                      ),

                                      SizedBox(height: 10,),
                                      Container(
                                        margin: const EdgeInsets.all(00.0),
                                        padding: EdgeInsets.only(top: 05.0,
                                            left: 15.0,
                                            right: 05.0),
                                        //color: Colors.white30,
                                        color: Colors.white,
                                        width: 300.0,
                                        height: 40.0,
                                        child: TextField(
                                            controller: countryController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'country')),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        margin: const EdgeInsets.all(00.0),
                                        padding: EdgeInsets.only(top: 05.0,
                                            left: 15.0,
                                            right: 05.0),
                                        //color: Colors.white30,
                                        color: Colors.white,
                                        width: 300.0,
                                        height: 40.0,
                                        child: TextField(
                                            controller: guestController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Guest')),
                                      ),        SizedBox(height: 10,),
                                      Container(
                                        margin: const EdgeInsets.all(00.0),
                                        padding: EdgeInsets.only(top: 05.0,
                                            left: 15.0,
                                            right: 05.0),
                                        //color: Colors.white30,
                                        color: Colors.white,
                                        width: 300.0,
                                        height: 40.0,
                                        child: TextField(
                                            controller: bedroomController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Bedroom')),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        margin: const EdgeInsets.all(00.0),
                                        padding: EdgeInsets.only(top: 05.0,
                                            left: 15.0,
                                            right: 05.0),
                                        //color: Colors.white30,
                                        color: Colors.white,
                                        width: 300.0,
                                        height: 40.0,
                                        child: TextField(
                                            controller: bathroomController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Bathroom')),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        margin: const EdgeInsets.all(00.0),
                                        padding: EdgeInsets.only(top: 05.0,
                                            left: 15.0,
                                            right: 05.0),
                                        //color: Colors.white30,
                                        color: Colors.white,
                                        width: 300.0,
                                        height: 40.0,
                                        child: TextField(
                                            controller: priceController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Price')),
                                      ),

                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 300,
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            DropdownButton(

                                              isExpanded: true,

                                              // Initial Value
                                              value: dropdownvalue,

                                              // Down Arrow Icon
                                              icon: const Icon(Icons.keyboard_arrow_down),

                                              // Array list of items
                                              items: items.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              // After selecting the desired option,it will
                                              // change button value to selected value
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownvalue = newValue!;
                                                });
                                              },
                                            ),
                                          ],

                                        ),

                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child:isLoading
                                            ? Center(child: CircularProgressIndicator())
                                            : TextButton(
                                          style: TextButton.styleFrom(
                                              fixedSize: const Size(300, 45),
                                              foregroundColor: Colors.white,
                                              backgroundColor: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(00),
                                              ),
                                              textStyle: const TextStyle(fontSize: 20)),
                                          // child: Text('Book Now'),

                                          child: const Text('Update',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

                                          onPressed: () async {
                                            setState(() => isLoading = true);
                                          Update();
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            prefs.setString('tokenkey', RetrivedBearertoekn);
                                            await Future.delayed(Duration(seconds: 2), () => () {});
                                            setState(() => isLoading = false);
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              // middle widget goes here
                              Expanded(
                                child: Container(),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    //Icon(Icons.star),
                                    // Text("Bottom Text")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
    );
  }


  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
      ImageSource img,
      ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
          () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}

