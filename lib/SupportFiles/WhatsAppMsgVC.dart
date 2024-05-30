import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../ServiceDasboardVC.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:tourstravels/shared_preferences.dart';
import 'package:tourstravels/Auth/forgotpwdemailVerify.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import 'package:http/http.dart' as http;
class WhatsAppScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<WhatsAppScreen> {
  final baseDioSingleton = BaseSingleton();
  String RetrivedBearertoekn = '';
  int bookingID = 0;
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
  String dropdownvalue = 'Please select Country';

// List of items in our dropdown menu
  var items = [
    'Please select Country',
    'Zimbabwe',
    'South Africa',
  ];
  final globalKey = GlobalKey<ScaffoldState>();
  String tokenvalue = '';
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    //_phoneController.text = '27 65 532 6408';

  }

  @override
  TextEditingController _countryCodeController = TextEditingController();
  late TextEditingController _messageController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.white, Colors.green]),
            ),
          ),
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          title: Text('WhatsApp',textAlign: TextAlign.center,
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
                                  height: 450.0,
                                  width: 325.0,
                                  decoration: const BoxDecoration(
                                    //color: Color(0xFFffffff),
                                    color: Colors.white,
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
                                  SizedBox(
                                    height: 30,
                                  ),
                                    SizedBox(
                                        width: 310,
                                        height: 45,

                                      child:DropdownButton(

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
                                            print('new value...');
                                            print(newValue);
                                            if(newValue == 'Zimbabwe') {
                                              print('zim num..');
                                              //263 777 223 158
                                              _phoneController.text = '263 777 223 158';

                                            } else {

                                              _phoneController.text = '27 65 532 6408';

                                            }
                                          });
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 310,
                                      height: 45,
                                       child: TextField(
                                         controller: _phoneController,
                                           // maxLines: null,
                                           // expands: true,
                                           keyboardType: TextInputType.phone,

                                          decoration: InputDecoration(
                                            hintText: 'Mobile number',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1, color: Colors.black54), //<-- SEE HERE
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1, color: Colors.black54),
                                            ),
                                          ),
                                        )
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    SizedBox(
                                      width: 310,
                                      height: 120,
                                        child: TextField(
                                          controller: _messageController,
                                          maxLines: null,
                                          expands: true,
                                          //keyboardType: TextInputType.phone,

                                          decoration: InputDecoration(
                                            hintText: 'Enter a message',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1, color: Colors.black54), //<-- SEE HERE
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1, color: Colors.black54),
                                            ),
                                          ),
                                        )
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                     // onTap: () {},

                                      onTap: () async {
                                        //To remove the keyboard when button is pressed
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        var whatsappUrl =
                                            "whatsapp://send?phone=${_countryCodeController.text + _phoneController.text}" +
                                                "&text=${Uri.encodeComponent(_messageController.text)}";
                                        try {
                                          launch(whatsappUrl);
                                        } catch (e) {
                                          final snackBar = SnackBar(
                                            content: Text('Unable to open WhatsApp'),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }
                                      },
                                      child: Container(
                                        // height: Dimensions.boxHeight * 6,
                                        // width: Dimensions.boxWidth * 40,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade800,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Open WhatsApp",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

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

}

