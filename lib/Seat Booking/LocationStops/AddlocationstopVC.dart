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
import 'BuslocationsVC.dart';
class AddBusLocationVC extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<AddBusLocationVC> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  String RetrivedBearertoekn = '';
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController locationController = TextEditingController();
  String tokenvalue = '';

  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      print('create Apartment token');
      print(RetrivedBearertoekn);
    });
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () async{
        Navigator.of(context, rootNavigator: true).pop();
        await Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) => MybusLocationStopscreen()));
        setState((){
          //Navigator.pop(context);
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Abisiniya",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24,color: Colors.green),),
      content: Text("Do you want Add Location?",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.black54),),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void locationAdd(String buslocation) async {
    try{
      Response response = await post(
          Uri.parse(baseDioSingleton.AbisiniyaBaseurl +'bus/buslocation/add'),
          body: {
            'buslocation' : locationController.text.toString(),
          },
          headers: {
      "Authorization":"Bearer $RetrivedBearertoekn",
      "Accept": "application/json",
      //"Content-Type": "application/json"

      }
      );
      print('loc sts..');
      print(response.statusCode);
      isLoading = true;
      if(response.statusCode == 201){
        isLoading = false;
        print('success api response');
        var data = jsonDecode(response.body.toString());
        var data1 = jsonDecode(response.body.toString());
        print(data1['data']);
        showAlertDialog(context);
      } else if(response.statusCode == 422) {
        final snackBar = SnackBar(
          content: Text('Please provide new location value.If Already Exist'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
        else {
        print('failed');
        final snackBar = SnackBar(
          content: Text('Please provide new location value.If Already Exist'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }catch(e){
      print(e.toString());
    }
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
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
          actions: <Widget>[
          ],
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          title: Text('LOCATION',textAlign: TextAlign.center,
              style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

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
                                  height: 320.0,
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
                                        "Create Bus Stop",
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
                                            controller: locationController,
                                            textAlign: TextAlign.left,
                                            autocorrect: false,
                                            decoration:
                                            new InputDecoration.collapsed(
                                                hintText: 'Bus Stop / Location name')),
                                      ),
                                      SizedBox(
                                        height: 30,
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
                                          child: const Text('Create',style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
                                          onPressed: () async {
                                            setState(() => isLoading = true);
                                            // _postData();
                                            locationAdd(locationController.text.toString());
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
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
                                    // Icon(Icons.star),
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
}