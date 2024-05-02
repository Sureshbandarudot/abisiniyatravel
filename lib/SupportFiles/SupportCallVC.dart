// importing dependencies
import 'package:flutter/material.dart';
// cupertino package was unuses
import 'package:url_launcher/url_launcher.dart';

import '../supportVC.dart';


// function to trigger the app build
//void main() => runApp(const MyApp());

// _makingPhoneCall() async {
//   var url = Uri.parse(_phoneController);
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
class CallToAbisiniya extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<CallToAbisiniya> {

//class CallToAbisiniya extends StatelessWidget {


  //CallToAbisiniya({Key? key}) : super(key: key);
  late TextEditingController _phoneController = TextEditingController();
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneController.text = '27 65 532 6408';
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


                // DEPRECATED
                // RaisedButton(
                // onPressed: _makingPhoneCall,
                // child: Text('Call'),
                // textColor: Colors.black,
                // padding: const EdgeInsets.all(5.0),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
