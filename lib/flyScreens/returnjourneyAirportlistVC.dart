import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ServiceDasboardVC.dart';
import 'Flights.dart';



void main() => runApp(new returnjourneyAirportListScreen());

class returnjourneyAirportListScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Departure Airport',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class myclass {
  String word1;
  String word2;

  myclass(this.word1, this.word2);
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  //MyHomePage({Key? key, required this.title}): super(key: key);

  //final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedStr = '';
  final baseDioSingleton = BaseSingleton();


  int selectedIndex = 0;

  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  //var items = List<String>();
  var items = [];

  List<myclass> words = [
    myclass("Start", "دەستپێدکت"),
    myclass("Go", "دچت"),
    myclass("Drive", "دهاژوت"),
    myclass("Sleep", "دنڤت"),
  ];

  List<String> AirportdropdownList = [];

  Future<List<String>> AirportList() async {
    // var baseUrl = "https://staging.abisiniya.com/api/v1/flight/airlinelist";
    //String baseUrl = 'https://staging.abisiniya.com/api/v1/flight/airlinelist';
    String baseUrl = baseDioSingleton.AbisiniyaBaseurl+ 'flight/airportlist';

    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body);
      print(jsonData.toString());
      var namestr = jsonData['data'];
      for (var nameArray in namestr) {
        String namestrvalue = nameArray['name'];
        // print(namestrvalue);
        AirportdropdownList.add(namestrvalue);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }


  @override
  void initState() {
    super.initState();
    //AirlineList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,   //new line

      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          onPressed: () async{
            print("back Pressed");

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => ServiceDashboardScreen()),
            // );
          },

        ),
        // iconTheme: IconThemeData(
        //     color: Colors.green,
        // ),
        title: Text('Return',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

      ),
      body: Column(
        //child: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    print('tapped selected value..');
                  });
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              ),
            ),
          ),
          Expanded(child: Container(

            child:SingleChildScrollView(
              //child: SizedBox(
              // height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder<dynamic>(
                      future: AirportList(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text('');
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          case ConnectionState.active:
                            print('imagename......');
                            return Text('');
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text(
                                '${snapshot.error}',
                                style: TextStyle(color: Colors.white),
                              );
                            } else {

                              return Column(
                                children: [
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: AirportdropdownList.length,
                                      itemBuilder: (context, index) {
                                        // print('selected value...');
                                        // print(AirportdropdownList[index]);
                                        if (editingController.text.isEmpty) {
                                          return ListTile(
                                            title:
                                            Text('${AirportdropdownList[index]}'),
                                            onTap: () async {
                                              // print("clicked........");
                                              setState(() async {
                                                //isSelected = true;
                                                selectedStr = (AirportdropdownList[index]);
                                                print('calling....');
                                                editingController.text = selectedStr;
                                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                                prefs.setString('retrun_airportstrkey', (selectedStr));
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => FlightScreen()),
                                                );

                                                //print(selectedStr);
                                              });
                                            },
                                          );
                                        } else if (AirportdropdownList[index].toLowerCase()
                                            .contains(editingController.text)) {
                                          return ListTile(
                                            title:
                                            Text('${AirportdropdownList[index]}'),
                                            onTap: () async {
                                              print("clicked111........");
                                              setState(() async {
                                                //isSelected = true;
                                                selectedStr = (AirportdropdownList[index]);
                                                print('calling111....');
                                                editingController.text = selectedStr;
                                                print(selectedStr);
                                                selectedStr = (AirportdropdownList[index]);
                                                print('calling....');
                                                editingController.text = selectedStr;
                                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                                prefs.setString('retrun_airportstrkey', (selectedStr));
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => FlightScreen()),
                                                );
                                              });
                                            },
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                ],
                              );
                            }
                        }
                      }
                  )
                ],
              ),
              // ),
            ),
          ))
        ],
        // ),
      ),
    );
  }
}