// importing dependencies
import 'package:flutter/material.dart';
// cupertino package was unuses
import 'package:url_launcher/url_launcher.dart';

import '../supportVC.dart';


class CallToAbisiniya extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<CallToAbisiniya> {
  late TextEditingController _phoneController = TextEditingController();
  String dropdownvalue = 'Please select Country';

// List of items in our dropdown menu
  var items = [
    'Please select Country',
    'Zimbabwe',
    'South Africa',
  ];
  void initState() {
    // TODO: implement initState
    super.initState();
    //_phoneController.text = '27 65 532 6408';
  }
  _makingPhoneCall() async {
    //var url = Uri.parse();
    var url = Uri.parse("tel:${_phoneController.text.toString()}");
   // var url = Uri.parse("tel:9776765434");
    print('url...');
    print(url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
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
              // print("back Pressed");
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // prefs.setString('logoutkey', ('LogoutDashboard'));
              // prefs.setString('Property_type', ('Apartment'));
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => supportScreen()),
              );
            },
          ),
          title: Text('Call',textAlign: TextAlign.center,
              style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
        ), // AppBar
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 50.0,
                ),//Container
                const Text(
                  'Call To Abisiniya Team?',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),//TextStyle
                ),//Text
                Container(
                  height: 20.0,
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
                // const Text(
                //   'For further Updates',
                //   style: TextStyle(
                //     fontSize: 20.0,
                //     color: Colors.green,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                Container(
                  height: 20.0,
                  width: 200,
                  //color: Colors.green,
                ),
                ElevatedButton(
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(10.0))),

                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        // Change your radius here
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _makingPhoneCall();

                  },
                  // padding:
                  // EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                  // color: Colors.pink,
                  child: Text(
                    'Call To Abisiniya',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,fontSize: 18),
                  ),
                ),
                // ElevatedButton(
                //
                //   onPressed: _makingPhoneCall,
                //   style: ButtonStyle(
                //     padding:
                //     MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                //     textStyle: MaterialStateProperty.all(
                //       const TextStyle(color: Colors.black),
                //     ),
                //   ),
                //   child: const Text('   Call   '),
                // ), // ElevatedButton

              ],
            ),
          ),
        ),
      ),
    );
  }
}
