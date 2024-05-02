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
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import 'MybookingVC.dart';
class AddReplyscreen extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<AddReplyscreen> {

  final baseDioSingleton = BaseSingleton();
  String RetrivedBearertoekn = '';
  int bookingID = 0;

  TextEditingController ReplyController = TextEditingController();



  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // RetrivedEmail = prefs.getString('emailkey') ?? "";
      // RetrivedPwd = prefs.getString('passwordkey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      bookingID = prefs.getInt('userbookingId') ?? 0;
    });
  }

  // final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  final globalKey = GlobalKey<ScaffoldState>();
  String tokenvalue = '';
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
  }


  File? galleryFile;
  final picker = ImagePicker();

  Future addProduct() async{
    print('entered.....');
    var token = '353|9NBSCUPjPAK54iUIwJgZBdapulScrjumr10pwqeM';
    var header = {
      "Authorization":"Bearer $RetrivedBearertoekn"
    };
    final request = await http.MultipartRequest(
      'POST',
      Uri.parse(baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/sendreply'),
    );
    request.headers.addAll(header);
    request.fields['reply'] = ReplyController.text;

    request.fields['booking_id'] = bookingID.toString();
    request.fields['image'] = '';
    var takenPicture = await http.MultipartFile.fromPath("image",galleryFile!.path);
    print(takenPicture);
    request.files.add(takenPicture);
    var response = await request.send();
    print(response);
    print('stscode...');
    print(response.statusCode);
    if(response.statusCode == 200) {
      print('success Add reply');
      var responseData = await response.stream.toBytes();
      var responseToString = String.fromCharCodes(responseData);
      // final List parsedList = json.decode(responseToString);
      // final snackBar = SnackBar(
      //   content: Text('Apartment created successfully'),
      // );
      // // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => MyApartmentScreen()
      //   ),
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyBookingScreen()
        ),
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('tokenkey', RetrivedBearertoekn);

      var jsonBody = jsonDecode(responseToString);
      setState(() {
        print(jsonBody);
      });
    } else {
      final snackBar = SnackBar(
        content: Text('Please fill all fields'),
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
                                  height: 450.0,
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
                                      Text(
                                        "Add a Reply",
                                        textAlign: TextAlign.center ,
                                        style: TextStyle(
                                            color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26),),


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


                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(00.0),
                                        padding: EdgeInsets.only(top: 15.0,
                                            left: 15.0,
                                            right: 05.0),
                                        //color: Colors.white30,
                                        color: Colors.white,
                                        width: 300.0,
                                        height: 60.0,
                                        child: TextField(
                                            controller: ReplyController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            //disable single line border below the text field
                                            new InputDecoration.collapsed(
                                                hintText: 'Reply')),
                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        child:isLoading
                                            ? Center(child: CircularProgressIndicator())
                                            : TextButton(
                                          style: TextButton.styleFrom(
                                              fixedSize: const Size(300, 45),
                                              foregroundColor: Colors.white,
                                              backgroundColor: Colors.deepPurple,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(00),
                                              ),
                                              textStyle: const TextStyle(fontSize: 20)),
                                          // child: Text('Book Now'),

                                          child: const Text('Send Reply',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

                                          onPressed: () async {
                                            setState(() => isLoading = true);
                                            // addProduct();
                                            addProduct();
                                            // _postData();
                                            //login(emailController.text.toString(), passwordController.text.toString());

                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            prefs.setString('tokenkey', RetrivedBearertoekn);
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

