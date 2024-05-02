import 'package:flutter/material.dart';

import 'ServiceDasboardVC.dart';

import 'package:flutter/material.dart';

import 'SupportFiles/EmailVC.dart';
import 'SupportFiles/SupportCallVC.dart';
import 'SupportFiles/WhatsAppMsgVC.dart';
class supportScreen extends StatefulWidget {
  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}
class _ModalBottomSheetState extends State<supportScreen> {
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
        leading: BackButton(
          onPressed: () async{
            print("back Pressed");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServiceDashboardScreen()),
            );
          },

        ),
        // iconTheme: IconThemeData(
        //     color: Colors.green,
        // ),
        title: Text('Abisiniya',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "How would you like to contact Abisiniya team?",
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w600,fontSize: 14),

            ),
            SizedBox(
              height: 20,
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
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // ListTile(
                          //   leading: new Icon(Icons.photo),
                          //   title: new Text('Photo'),
                          //   onTap: () {
                          //     Navigator.pop(context);
                          //   },
                          // ),

                          ListTile(
                            leading: new Icon(Icons.share),
                            title: new Text('WhatsApp'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WhatsAppScreen()
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.call),
                            title: new Text('Call'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CallToAbisiniya()
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.email_rounded),
                            title: new Text('Email'),
                            onTap: () {
                              print('email...');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmailComposer()
                                ),
                              );
                             // Navigator.pop(context);
                            },
                          ),
                          // ListTile(
                          //   leading: new Icon(Icons.help_center),
                          //   title: new Text('help'),
                          //   onTap: () {
                          //     Navigator.pop(context);
                          //   },
                          // ),
                        ],
                      );
                    });
              },
              // padding:
              // EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
              // color: Colors.pink,
              child: Text(
                'Support Abisiniya Team',
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
