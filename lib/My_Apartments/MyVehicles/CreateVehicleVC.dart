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

import 'MyvehicleVC.dart';

//import 'My_AprtmetsVC.dart';






class CreateVehice extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<CreateVehice> {
  String RetrivedBearertoekn = '';
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // RetrivedEmail = prefs.getString('emailkey') ?? "";
      // RetrivedPwd = prefs.getString('passwordkey') ?? "";
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
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController enginesizeController = TextEditingController();
  TextEditingController fuelsizeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController transmisionController = TextEditingController();
  TextEditingController priceController = TextEditingController();





  String tokenvalue = '';
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
  }


  File? galleryFile;
  final picker = ImagePicker();
  @override
  Future addProduct() async{
    print('entered.....');
    var header = {
      "Authorization":"Bearer $RetrivedBearertoekn",
    "Accept": "application/json",
    "Content-Type": "application/json"
    };
    final request = await http.MultipartRequest(
      'POST',
      // Uri.parse('https://staging.abisiniya.com/api/v1/vehicle/add'),
      Uri.parse(baseDioSingleton.AbisiniyaBaseurl + 'vehicle/add'),

    );
    request.headers.addAll(header);
    request.fields['name'] = nameController.text;
    request.fields['address'] = addressController.text;
    request.fields['city'] = cityController.text;
    request.fields['country'] = countryController.text;
    request.fields['make'] = makeController.text.toString();
    request.fields['model'] = modelController.text.toString();
    request.fields['year'] = yearController.text.toString();
    request.fields['engine_size'] = enginesizeController.text;
    request.fields['fuel_type'] = fuelsizeController.text.toString();
    request.fields['weight'] = weightController.text;
    request.fields['color'] = colorController.text.toString();
    request.fields['transmission'] = transmisionController.text.toString();
    request.fields['price'] = priceController.text.toString();
    request.fields['pictures[]'] = '[]';
    var takenPicture = await http.MultipartFile.fromPath("pictures[]",galleryFile!.path);
    print(takenPicture);
    request.files.add(takenPicture);
    var response = await request.send();
    print(response);
    if(response.statusCode == 200) {
      print('Vehicles........');
      var responseData = await response.stream.toBytes();
      var responseToString = String.fromCharCodes(responseData);
      // final List parsedList = json.decode(responseToString);
      // final snackBar = SnackBar(
      //   content: Text('Apartment created successfully'),
      // );
      // // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyVehicleScreen()
        ),
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => MyApartmentScreen()
      //   ),
      // );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('tokenkey', RetrivedBearertoekn);

      var jsonBody = jsonDecode(responseToString);
      setState(() {
        print(jsonBody);
      });
    } else {
      final snackBar = SnackBar(
        content: Text(''),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                                  height: 1150.0,
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
                                        "Create Vehicle",
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
                                            controller: makeController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Make')),
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
                                            controller: modelController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Model')),
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
                                            controller: yearController,
                                            keyboardType: TextInputType.number,

                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Year')),
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
                                            controller: enginesizeController,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Engine Size')),
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
                                            controller: fuelsizeController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Fuel Type')),
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
                                            controller: weightController,
                                            keyboardType: TextInputType.number,

                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Weight')),
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
                                            controller: colorController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Color')),
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
                                            controller: transmisionController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Transmission')),
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
                                            keyboardType: TextInputType.number,

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
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.green)),
                                        child: const Text('Select Image from Gallery and Camera',style: TextStyle(color: Colors.white),),
                                        onPressed: () {
                                          _showPicker(context: context);
                                        },
                                      ),
                                      SizedBox(
                                        height: 200.0,
                                        width: 300.0,
                                        child: galleryFile == null
                                            ? const Center(child: Text('Sorry nothing selected!!',style: TextStyle(color: Colors.red),))
                                            : Center(child: Image.file(galleryFile!)),
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

                                          child: const Text('Send',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

                                          onPressed: () async {
                                            // setState(() => isLoading = true);
                                            // addProduct();
                                            if(nameController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill name'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(addressController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill address'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(cityController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill city'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(countryController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill country'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(makeController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill make'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(modelController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill model'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(yearController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill year'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(enginesizeController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill enginesize'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(fuelsizeController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill fueltype'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(weightController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill weight'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(colorController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill color'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(transmisionController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill transimission'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(priceController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: Text('Please Fill price'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else if(galleryFile == null) {
                                              final snackBar = SnackBar(
                                                content: Text('Please select image from gallery..'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            } else {
                                              print('product calling...');
                                              addProduct();

                                            }
                                            // _postData();
                                            //login(emailController.text.toString(), passwordController.text.toString());

                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            // print('booking id...');
                                            // print(snapshot.data['data'][index]['id']);
                                            // prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                            // prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                            // prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
                                            prefs.setString('tokenkey', RetrivedBearertoekn);


                                            print('token value....');
                                            print(tokenvalue);
                                            prefs.setString('tokenkey', tokenvalue);
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

