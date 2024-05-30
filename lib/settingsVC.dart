
import 'package:flutter/material.dart';
import 'ServiceDasboardVC.dart';
import 'package:url_launcher/url_launcher.dart';
import 'SupportFiles/AboutUsVC.dart';
import 'SupportFiles/ContactusVC.dart';
void main() {
  runApp(settingsScreen());
}
class settingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'ListView.builder Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListViewBuilderExample(),
    );
  }
}

class ListViewBuilderExample extends StatelessWidget {
  final List<String> itemList = [
    'About Us',
    'Contact Us',
    'Privacy Policy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Services'),
      // ),
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
        title: Text('Abisiniya',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
      ),
      body: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.green,
                      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                      //padding: EdgeInsets.all(0),
                      alignment: Alignment.centerLeft,
              child: ListTile(
                title: Text(
                  itemList[index],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22,color: Colors.white),
                ),
                onTap: () {

                  if(itemList[index] == 'About Us'){
                    print('abt...');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutUsScreen()),
                    );
                  } else if (itemList[index] == 'Contact Us'){
                    print('cnt...');

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactUsScreen()),
                    );
                  }
                  // else if (itemList[index] == 'Other Services'){
                  //   print('cnt...');
                  // }
                  else if (itemList[index] == 'Privacy Policy'){
                    //js.context.callMethod('open', ['https://www.google.com/']);
                    _launchURL();

                  }
                  // print(itemList[0]);
                  // print(itemList[1]);
                },
              ),
            );
          }),
    );

  }
  _launchURL() async {
    final Uri url = Uri.parse('https://www.abisiniya.com/privacy');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch ');
    }
  }
}
