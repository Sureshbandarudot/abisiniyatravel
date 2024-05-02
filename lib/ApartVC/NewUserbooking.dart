import 'dart:convert';
//import 'package:apartmentdataparsing/models/Apartmentdata.dart';
import 'package:tourstravels/ApartVC/ApartmentAddmodel/Apartmentdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import 'package:intl/intl.dart';
import 'package:tourstravels/userDashboardvc.dart';
import 'package:tourstravels/UserDashboard_Screens/newDashboard.dart';

import '../MyBookings/MybookingVC.dart';
import 'Apartment.dart';




//import 'models/user.dart';

class UserBooking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<UserBooking> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController surnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController pwd_confirmcontroller = TextEditingController();
  TextEditingController FromdateInputController = TextEditingController();
  TextEditingController TodateInputController = TextEditingController();

   final baseDioSingleton = BaseSingleton();
//   print(baseDioSingleton.Appname);
  //List listUsers= [];
  //Future? listUsers;;

  String RetrivedBearertoekn = '';
  String newBookingUser = '';
  bool isLoading = false;
  int Bookable_iD = 0;
  String Bookable_type = '';
  String result = '';
  String fromDatestr = '';
  String toDatestr = '';


  int idnum = 0;
  int aptId = 0;
  int RetrivedId = 0;
  String Retrivedcityvalue = '';
  String RetrivedAdress = '';
  String RetrivedBathromm = '';
  String RetrivedBedroom = '';
  String RetrivedPrice = '';
  String NewUsertxt = 'This will automatically create a new account for you. If you already have an account please login here.';
  //Future<List<User>> listUsers;
  late Future<List<Apart>> listUsers ;
  late Future<List<Picture>> pics ;

  List<Picture> welcomeFromJson(String str) => List<Picture>.from(json.decode(str).map((x) => Picture.fromJSON(x)));
  String welcomeToJson(List<Picture> data) => json.encode(List<dynamic>.from(data.map((x) => x.toString())));
  @override
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print('url...');
      print(baseDioSingleton.AbisiniyaBaseurl);
      Retrivedcityvalue = prefs.getString('citykey') ?? "";
      RetrivedId = prefs.getInt('imgkeyId') ?? 0;
      RetrivedAdress = prefs.getString('addresskey') ?? "";
      RetrivedBathromm = prefs.getString('bathroomkey') ?? "";
      RetrivedBedroom = prefs.getString('bedroomkey') ?? "";
      RetrivedPrice = prefs.getString('pricekey') ?? "";
      Bookable_iD = prefs.getInt('imgkeyId') ?? 0;
      print('book...');
      print(Bookable_iD);
      Bookable_type = prefs.getString('Property_type') ?? "";
      print(Bookable_type);

      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";


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
      child: Text("Login",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () async{
        Navigator.of(context, rootNavigator: true).pop();
        await Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) => Login()));
        setState((){
          //Navigator.pop(context);
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Abisiniya",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24,color: Colors.green),),
      content: Text("If Already registered Phone and Email,Please Login and try again or Please enter different Email and Phone numbers and try again..... ",
        style:TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black54) ,),
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

  Phonenumber_showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Login",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () async{
        Navigator.of(context, rootNavigator: true).pop();
        await Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) => Login()));
        setState((){
          //Navigator.pop(context);
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Abisiniya",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24,color: Colors.green),),
      content: Text("If Already registered Phone number,Please Login and try again else Please enter different Phone number and try again. ",
        style:TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black54) ,),
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
  Email_showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Login",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () async{
        Navigator.of(context, rootNavigator: true).pop();
        await Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) => Login()));
        setState((){
          //Navigator.pop(context);
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Abisiniya",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24,color: Colors.green),),
      content: Text("If Already registered Email ,Please Login and try again else Please enter different Email and try again. ",
        style:TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black54) ,),
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

  Future<void> _postData() async {
    try {
      String apiUrl = '';
      apiUrl = baseDioSingleton.AbisiniyaBaseurl + 'booking/apartment/booking/newuser';
      print('url.....1');
      print(apiUrl);
      print('bearer token');
      print(RetrivedBearertoekn);
      print('book...');
      print(Bookable_iD);
     // Bookable_type = prefs.getString('Property_type') ?? "";
      print(Bookable_type);
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          "Content-Type": "application/json",
          "Accept": "application/json",
          //"Authorization": "Bearer $RetrivedBearertoekn",
        },
        body: jsonEncode(<String, dynamic>{
          'name': namecontroller.text,
          'surname': surnamecontroller.text,
          'email': emailcontroller.text,
          'phone': phonecontroller.text,
          'password': passwordcontroller.text,
          'password_confirmation': pwd_confirmcontroller.text,
          'start_date': FromdateInputController.text,
          'end_date': TodateInputController.text,
          'bookable_type': Bookable_type,
          'bookable_id': Bookable_iD
          // Add any other data you want to send in the body
        }),
      );

      print('status code...');
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(response.body);
        print('Apartment fresh user data successfully posted');
        print(responseData);
        var data = jsonDecode(response.body.toString());
        print('message......k');
        print(data['message']);
        // RetrivedBearertoekn = data['data']['token'];
        // print('token generated...');
        // print(RetrivedBearertoekn);
        // // String datestr = '';
        // // datestr = data['message'].toString();
        // print('date status...');
       // print(datestr);

        if (data['message'] == 'Thank you for booking request')
          {
            print('not calling....');
            final snackBar = SnackBar(
              content: Text(data['message']),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (data['message'] == 'Start date should be greater or equal to booking day'){
          print('Start date should be greater or equal to booking day.......');
          final snackBar = SnackBar(
            content: Text('Start date should be greater or equal to booking day'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (_) => MyBookingScreen(),
          ),);
          print('calling token....');
          print(RetrivedBearertoekn);
          RetrivedBearertoekn = data['data']['token'];
          print('token generated...');
          print(RetrivedBearertoekn);
          newBookingUser = 'NewBookingUser';
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('tokenkey', RetrivedBearertoekn);
          prefs.setString('newBookingUserkey', newBookingUser);

        }
    }
      if (response.statusCode == 422) {
        print('already entered existing data1...');
        var data = jsonDecode(response.body);
        print('email...');
        print(data['message']['email']);
        //String emailstr = (data['message']['email']);
        //print(emailstr);
        print(data['message']['phone']);

        print(data['message']['password']);
        print(data['message']['end_date']);
        if ((data['message']['phone']) != null && (data['message']['email']) != null) {
          showAlertDialog(context);
          // final snackBar = SnackBar(
          //       content: Text('The email and phone has already been taken.'),
          //     );
          //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if ((data['message']['phone']) != null) {
          Phonenumber_showAlertDialog(context);
          // final snackBar = SnackBar(
          //   content: Text('The phone has already been taken.'),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);

        } else if ((data['message']['email']) != null) {
          Email_showAlertDialog(context);
          // final snackBar = SnackBar(
          //   content: Text('The  email has already been taken.'),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if ((data['message']['password']) != null) {
          final snackBar = SnackBar(
            content: Text('The password confirmation does not match.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if ((data['message']['end_date']) != null) {
          print('date....');
          final snackBar = SnackBar(
            content: Text('The end date must be a date after start date.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          print('nullll.....');
        }
        // if ((data['message']['email']) != '[The email has already been taken.]' && (data['message']['phone']) != '[The phone has already been taken.]'){
        //   final snackBar = SnackBar(
        //     content: Text('The email and phone has already been taken.'),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //
        // }  else if ((data['message']['email']) != '[The email has already been taken.]') {
        //   final snackBar = SnackBar(
        //     content: Text('The email  has already been taken.'),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // } else if ((data['message']['phone']) != '[The phone has already been taken.]'){
        //   final snackBar = SnackBar(
        //     content: Text('The  phone has already been taken.'),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // } else if ((data['message']['end_date']) != '[The end date must be a date after start date.]') {
        //   final snackBar = SnackBar(
        //     content: Text('The end date must be a date after start date.'),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // }
      }  else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  //@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    listUsers = fetchUsers();
    pics = fetchpics();
    // _postData();
  }
  //String url = 'https://staging.abisiniya.com/api/v1/apartment/list';
  // String url = baseDioSingleton.AbisiniyaBaseurl+ 'apartment/list';

  Future<List<Apart>> fetchUsers() async {

    //String url = baseDioSingleton.AbisiniyaBaseurl+ 'apartment/show/57';
    //String url = 'https://staging.abisiniya.com/api/v1/apartment/show/57';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    RetrivedId = prefs.getInt('imgkeyId') ?? 0;
    RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
    String url = (baseDioSingleton.AbisiniyaBaseurl + 'apartment/show/$RetrivedId');
    print('api url...');
    print(url);


    print('tokenva.....1');
    print(RetrivedBearertoekn);

    //final response = await http.get(Uri.parse(url));
    var response = await http.get(
      Uri.parse(
          url),
      headers: {
        "Authorization": "Bearer $RetrivedBearertoekn",
      },
    );
    if (response.statusCode == 200) {
      final data1 = jsonDecode(response.body);
      var getUsersData = data1['data'] as List;
      //print(getUsersData);
      var listUsers = getUsersData.map((i) => Apart.fromJSON(i)).toList();
      // print('list.....');
      // print(listUsers);
      return listUsers;
      //var recordsList = data["records"];
      // for (var record in tagsJson) {
      //   //var apartmentlists = record['name'];
      //   print('name...');
      //   //print(name);
      //   var pictures = record['pictures'];
      //   for(var pics in pictures) {
      //     var picname = pics['imageUrl'];
      //     print('pictures...');
      //     print(picname);
      //   }
      // }
      //List<Apart> list = parseAgents(response.body);
      //return list;
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Picture>> fetchpics() async {
    //String url = baseDioSingleton.AbisiniyaBaseurl+ 'apartment/show/57';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    RetrivedId = prefs.getInt('imgkeyId') ?? 0;
    RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
    String url = (baseDioSingleton.AbisiniyaBaseurl + 'apartment/show/$RetrivedId');
    print('api url...1');
    print(url);
    //String url = 'https://staging.abisiniya.com/api/v1/apartment/show/57';

    print('tokenva..');
    print(RetrivedBearertoekn);

    //final response = await http.get(Uri.parse(url));
    var response = await http.get(
      Uri.parse(
          url),
      headers: {
        "Authorization": "Bearer $RetrivedBearertoekn",
      },
    );
    if (response.statusCode == 200) {
      final data1 = jsonDecode(response.body);
      var getpicsData = [];
      var picstrr = data1['data'];
      for (var record in picstrr) {
        idnum = record['id'];
        var pictures = record['pictures'];
        for (var picid in pictures) {
          aptId = picid['apartmentId'];
        }
        print('RetrivedId.. id.....');
        print(RetrivedId);
        print('aptId.. id.....');
        print(aptId);

        if (aptId == RetrivedId) {
          for (var pics in pictures) {
            print(pics);
            getpicsData.add(pics);
            print('imgs.....');
            print(getpicsData);
          }
        }

      }
      var pics = getpicsData.map((i) => Picture.fromJSON(i)).toList();
      return pics;

    } else {
      throw Exception('Error');
    }
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
                  builder: (context) => Apartmentscreen()),
            );
          },
        ),
        title: Text('APARTMENT',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
      ),
      body: FutureBuilder(
          future: pics,
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
                  //return Column(
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: LayoutBuilder(
                            builder: (context, constraint) {
                              return SingleChildScrollView(
                                //scrollDirection: Axis.horizontal,
                                physics: ScrollPhysics(),

                              child: Column(
                                children: [

                                  ListView.separated(
                                    //scrollDirection:Axis.horizontal,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: (snapshot.data as List<Picture>).length,
                                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                                    itemBuilder: (BuildContext context, int index) {
                                      var abisiniyapic = (snapshot.data as List<Picture>)[index];
                                      return Container(
                                        height: 220,
                                        width: 300,
                                        color: Colors.white,
                                        child: InkWell(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(image: NetworkImage(abisiniyapic.imageUrl),
                                                        fit: BoxFit.cover)
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: ()
                                          {
                                            print('calling.......');
                                            print([index]);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  Column(
                                    children: [

                                      Container(
                                        constraints:
                                        BoxConstraints(minHeight: constraint.maxHeight),
                                        child: IntrinsicHeight(
                                          child: Column(
                                            children: [
                                              // SizedBox(
                                              //   height: 10,
                                              // ),
                                              Column(
                                                  children: [
                                                    Column(
                                                        children: [
                                                          Container(
                                                            height: 40,
                                                            width: 340,
                                                            alignment: Alignment.topLeft,
                                                            color: Colors.white,
                                                            child: Text('Information',style: (TextStyle(fontSize: 22,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                          )
                                                          // Container(
                                                          //   height: 50,
                                                          //   width: 280,
                                                          //   color: Colors.orange,
                                                          //   // child:Text(snapshot.data['data'][10]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),
                                                          // ),
                                                        ]
                                                    ),
                                                  ]
                                              ),
                                              // middle widget goes here

                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    // SizedBox(
                                                    //   height: 5,
                                                    // ),
                                                    // Container(
                                                    //   height: 400,
                                                    //   width: 340,
                                                    //   alignment: Alignment.topLeft,
                                                    //   color: Colors.red,
                                                    //   child: Text('Information',style: (TextStyle(fontSize: 22,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                    // ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: 150,
                                                          color: Colors.white,
                                                          child: Text('Category:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: 175,
                                                          color: Colors.white,
                                                          child: Text('Accommodation',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 60,
                                                          width: 150,
                                                          color: Colors.white,
                                                          child: Text('Address:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                        ),
                                                        Container(
                                                          height: 60,
                                                          width: 175,
                                                          color: Colors.white,
                                                          child: Text(RetrivedAdress,style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: 150,
                                                          color: Colors.white,
                                                          child: Text('Location:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: 175,
                                                          color: Colors.white,
                                                          child: Text(Retrivedcityvalue,style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: 150,
                                                          color: Colors.white,
                                                          child: Text('Price:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: 175,
                                                          color: Colors.white,
                                                          child: Text('${(RetrivedPrice)} /night',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 60,
                                                          width: 150,
                                                          color: Colors.white,
                                                          child: Text('Specs & Utilities:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                                                        ),
                                                        Container(
                                                          height: 60,
                                                          width: 175,
                                                          color: Colors.white,
                                                          child: Text('${(RetrivedBathromm)} Bath, ${(RetrivedBedroom)} BedRoom',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),

                                                        )
                                                      ],
                                                    ),

                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          height: 100,
                                                          width: 340,
                                                          color: Colors.white,
                                                          child: Text(NewUsertxt,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),) ,
                                                        ),

                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 45,
                                                          width: 340,
                                                          child: TextField(

                                                            decoration: InputDecoration(
                                                                border:OutlineInputBorder(),
                                                                labelText: 'Firstname',
                                                                hintText: 'Firstname'
                                                            ), controller: namecontroller,),),

                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 45,
                                                          width: 340,
                                                          child: TextField(
                                                            decoration: InputDecoration(
                                                                border:OutlineInputBorder(),
                                                                labelText: 'surname',
                                                                hintText: 'surname'
                                                            ),controller: surnamecontroller,),),

                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 45,
                                                          width: 340,
                                                          child: TextField(
                                                              keyboardType:TextInputType.number,
                                                            decoration: InputDecoration(
                                                                border:OutlineInputBorder(),
                                                                labelText: 'Phone',
                                                                hintText: 'Phone'
                                                            ),controller: phonecontroller,),),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 70,
                                                          width: 340,
                                                          child: TextField(
                                                            maxLines: 1,
                                                            maxLength: 35,
                                                            //autofocus: true,
                                                            //textInputAction: TextInputAction.done,
                                                            keyboardType: TextInputType.text,

                                                            decoration: InputDecoration(
                                                                border:OutlineInputBorder(),
                                                                labelText: 'Email',
                                                                hintText: 'Email',
                                                              counterStyle: TextStyle(height: double.minPositive,),

                                                          ),controller: emailcontroller,)



                                                          ,),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 45,
                                                          width: 340,
                                                          child: TextField(
                                                            obscureText: true,
                                                            decoration: InputDecoration(
                                                                border:OutlineInputBorder(),
                                                                labelText: 'Password',
                                                                hintText: 'Password'
                                                            ),controller: passwordcontroller,),),

                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 45,
                                                          width: 340,
                                                          child: TextField(
                                                            obscureText: true,
                                                            decoration: InputDecoration(
                                                                border:OutlineInputBorder(),
                                                                labelText: 'Confirm Password ',
                                                                hintText: 'Confirm Password'
                                                            ),controller: pwd_confirmcontroller,),),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          height: 45,
                                                          width: 340,
                                                          child: Text('Booking Details',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w800,fontSize: 22),
                                                          ),),
                                                        SizedBox(height: 10,),
                                                        Container(
                                                          height: 45,
                                                          width: 340,
                                                          child: TextField(
                                                              decoration: const InputDecoration(
                                                                suffixIcon: Icon(Icons.calendar_month),
                                                                hintText: 'From Date',
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide(color: Colors.blue, width: 1)),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(color: Colors.blue, width: 1)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(color: Colors.blue, width: 1)),
                                                              ),
                                                              controller: FromdateInputController,
                                                              readOnly: true,
                                                              onTap: () async {

                                                                DateTime? pickedDate = await showDatePicker(
                                                                    context: context,
                                                                    initialDate: DateTime.now(),
                                                                    firstDate: DateTime(1950),
                                                                    lastDate: DateTime(2050));
                                                                if (pickedDate != null) {
                                                                  // FromdateInputController.text =pickedDate.toString();
                                                                  fromDatestr = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                                                                  FromdateInputController.text = fromDatestr;
                                                                }

                                                              }

                                                          ),),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 45,
                                                          width: 340,
                                                          child: TextField(
                                                              decoration: const InputDecoration(
                                                                suffixIcon: Icon(Icons.calendar_month),
                                                                hintText: 'To Date',
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide(color: Colors.blue, width: 1)),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(color: Colors.blue, width: 1)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(color: Colors.blue, width: 1)),
                                                              ),
                                                              controller: TodateInputController,
                                                              readOnly: true,
                                                              onTap: () async {

                                                                DateTime? pickedDate = await showDatePicker(
                                                                    context: context,
                                                                    initialDate: DateTime.now(),
                                                                    firstDate: DateTime(1950),
                                                                    lastDate: DateTime(2050));
                                                                if (pickedDate != null) {
                                                                  //TodateInputController.text =pickedDate.toString();
                                                                  toDatestr = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                                                                  TodateInputController.text = toDatestr;
                                                                }

                                                              }

                                                          ),),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          child:isLoading
                                                              ? Center(child: CircularProgressIndicator())
                                                              : TextButton(
                                                            style: TextButton.styleFrom(
                                                                fixedSize: const Size(340, 50),
                                                                foregroundColor: Colors.white,
                                                                backgroundColor: Colors.blue,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(00),
                                                                ),
                                                                textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                                                            child: Text('Book Now'),
                                                            onPressed: () async {
                                                              setState(() => isLoading = true);
                                                              _postData();
                                                              print('new booking calling token1....');
                                                              print(RetrivedBearertoekn);
                                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                                              prefs.setString('tokenkey', RetrivedBearertoekn);

                                                              await Future.delayed(Duration(seconds: 3), () => () {});
                                                              setState(() => isLoading = false);
                                                            },
                                                          ),
                                                        )

                                                        // Container(
                                                        //     child: TextButton(
                                                        //       style: TextButton.styleFrom(
                                                        //           fixedSize: const Size(340, 50),
                                                        //           foregroundColor: Colors.white,
                                                        //           backgroundColor: Colors.blue,
                                                        //           shape: RoundedRectangleBorder(
                                                        //             borderRadius: BorderRadius.circular(00),
                                                        //           ),
                                                        //           textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                                                        //       onPressed: () {
                                                        //         // Navigator.push(
                                                        //         //   context,
                                                        //         //   MaterialPageRoute(
                                                        //         //       builder: (context) => ForgotpwdOTPVerified()
                                                        //         //   ),
                                                        //         // );
                                                        //       },
                                                        //       child: const Text('Book Now'),
                                                        //     )
                                                        // ),
                                                        // TextField (
                                                        //   //readOnly: true,
                                                        //   //controller: emailController,
                                                        //   decoration: InputDecoration(
                                                        //       border:OutlineInputBorder(),
                                                        //       labelText: 'Email',
                                                        //       hintText: 'Email'
                                                        //   ),
                                                        // ),
                                                        //Text(NewUsertxt,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),)
                                                      ],
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],


                                  )

                                ],
                              ),





                              //   child: Container(
                              //     constraints:
                              //     BoxConstraints(minHeight: constraint.maxHeight),
                              //     child: IntrinsicHeight(
                              //       child: Column(
                              //         children: [
                              //           // SizedBox(
                              //           //   height: 10,
                              //           // ),
                              //           Column(
                              //               children: [
                              //                 Column(
                              //                     children: [
                              //                       Padding(
                              //                         padding: const EdgeInsets.all(8.0),
                              //                         child: Container(
                              //                           height: 250,
                              //
                              //                           child:ListView.separated(
                              //                             //scrollDirection:Axis.horizontal,
                              //
                              //                             itemCount: (snapshot.data as List<Picture>).length,
                              //                             separatorBuilder: (BuildContext context, int index) => const Divider(),
                              //                             itemBuilder: (BuildContext context, int index) {
                              //                               var abisiniyapic = (snapshot.data as List<Picture>)[index];
                              //                               return Container(
                              //                                 height: 220,
                              //                                 width: 300,
                              //                                 color: Colors.white,
                              //                                 child: InkWell(
                              //                                   child: Column(
                              //                                     children: [
                              //                                       Container(
                              //                                         height: 200,
                              //                                         decoration: BoxDecoration(
                              //                                             image: DecorationImage(image: NetworkImage(abisiniyapic.imageUrl),
                              //                                                 fit: BoxFit.cover)
                              //                                         ),
                              //                                       ),
                              //                                     ],
                              //                                   ),
                              //                                   onTap: ()
                              //                                   {
                              //                                     print('calling.......');
                              //                                     print([index]);
                              //                                   },
                              //                                 ),
                              //                               );
                              //                             },
                              //                           ),
                              //
                              //
                              //                         ),
                              //                       ),
                              //                       Container(
                              //                         height: 40,
                              //                         width: 340,
                              //                         alignment: Alignment.topLeft,
                              //                         color: Colors.white,
                              //                         child: Text('Information',style: (TextStyle(fontSize: 22,fontWeight: FontWeight.w900,color: Colors.black)),),
                              //                       )
                              //                       // Container(
                              //                       //   height: 50,
                              //                       //   width: 280,
                              //                       //   color: Colors.orange,
                              //                       //   // child:Text(snapshot.data['data'][10]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Colors.green)),),
                              //                       // ),
                              //                     ]
                              //                 ),
                              //               ]
                              //           ),
                              //           // middle widget goes here
                              //
                              //           Align(
                              //             alignment: Alignment.topCenter,
                              //             child: Column(
                              //               mainAxisAlignment: MainAxisAlignment.start,
                              //               children: <Widget>[
                              //                 // SizedBox(
                              //                 //   height: 5,
                              //                 // ),
                              //                 // Container(
                              //                 //   height: 400,
                              //                 //   width: 340,
                              //                 //   alignment: Alignment.topLeft,
                              //                 //   color: Colors.red,
                              //                 //   child: Text('Information',style: (TextStyle(fontSize: 22,fontWeight: FontWeight.w900,color: Colors.black)),),
                              //                 // ),
                              //                 Row(
                              //                   children: [
                              //                     SizedBox(
                              //                       width: 10,
                              //                     ),
                              //                     Container(
                              //                       height: 40,
                              //                       width: 150,
                              //                       color: Colors.white,
                              //                       child: Text('Category:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                              //                     ),
                              //                     Container(
                              //                       height: 40,
                              //                       width: 175,
                              //                       color: Colors.white,
                              //                       child: Text('Accommodation',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),
                              //
                              //                     )
                              //                   ],
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     SizedBox(
                              //                       width: 10,
                              //                     ),
                              //                     Container(
                              //                       height: 60,
                              //                       width: 150,
                              //                       color: Colors.white,
                              //                       child: Text('Address:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                              //                     ),
                              //                     Container(
                              //                       height: 60,
                              //                       width: 175,
                              //                       color: Colors.white,
                              //                       child: Text(RetrivedAdress,style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),
                              //
                              //                     )
                              //                   ],
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     SizedBox(
                              //                       width: 10,
                              //                     ),
                              //                     Container(
                              //                       height: 40,
                              //                       width: 150,
                              //                       color: Colors.white,
                              //                       child: Text('Location:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                              //                     ),
                              //                     Container(
                              //                       height: 40,
                              //                       width: 175,
                              //                       color: Colors.white,
                              //                       child: Text(Retrivedcityvalue,style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),
                              //
                              //                     )
                              //                   ],
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     SizedBox(
                              //                       width: 10,
                              //                     ),
                              //                     Container(
                              //                       height: 40,
                              //                       width: 150,
                              //                       color: Colors.white,
                              //                       child: Text('Price:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                              //                     ),
                              //                     Container(
                              //                       height: 40,
                              //                       width: 175,
                              //                       color: Colors.white,
                              //                       child: Text('${(RetrivedPrice)} /night',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),
                              //
                              //                     )
                              //                   ],
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     SizedBox(
                              //                       width: 10,
                              //                     ),
                              //                     Container(
                              //                       height: 60,
                              //                       width: 150,
                              //                       color: Colors.white,
                              //                       child: Text('Specs & Utilities:',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black)),),
                              //                     ),
                              //                     Container(
                              //                       height: 60,
                              //                       width: 175,
                              //                       color: Colors.white,
                              //                       child: Text('${(RetrivedBathromm)} Bath, ${(RetrivedBedroom)} BedRoom',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black)),),
                              //
                              //                     )
                              //                   ],
                              //                 ),
                              //
                              //                 SizedBox(
                              //                   height: 20,
                              //                 ),
                              //                 Column(
                              //                   children: [
                              //                     Container(
                              //                       height: 100,
                              //                       width: 340,
                              //                       color: Colors.white,
                              //                       child: Text(NewUsertxt,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),) ,
                              //                     ),
                              //
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Container(
                              //                       height: 45,
                              //                       width: 340,
                              //                       child: TextField(
                              //
                              // decoration: InputDecoration(
                              //       border:OutlineInputBorder(),
                              //       labelText: 'Firstname',
                              //       hintText: 'Firstname'
                              //   ), controller: namecontroller,),),
                              //
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Container(
                              //                       height: 45,
                              //                       width: 340,
                              //                       child: TextField(
                              //                         decoration: InputDecoration(
                              //                             border:OutlineInputBorder(),
                              //                             labelText: 'surname',
                              //                             hintText: 'surname'
                              //                         ),controller: surnamecontroller,),),
                              //
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Container(
                              //                       height: 45,
                              //                       width: 340,
                              //                       child: TextField(
                              //                         decoration: InputDecoration(
                              //                             border:OutlineInputBorder(),
                              //                             labelText: 'Phone',
                              //                             hintText: 'Phone'
                              //                         ),controller: phonecontroller,),),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Container(
                              //                       height: 45,
                              //                       width: 340,
                              //                       child: TextField(
                              //                         decoration: InputDecoration(
                              //                             border:OutlineInputBorder(),
                              //                             labelText: 'Email',
                              //                             hintText: 'Email'
                              //                         ),controller: emailcontroller,),),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Container(
                              //                       height: 45,
                              //                       width: 340,
                              //                       child: TextField(
                              //                         decoration: InputDecoration(
                              //                             border:OutlineInputBorder(),
                              //                             labelText: 'Password',
                              //                             hintText: 'Password'
                              //                         ),controller: passwordcontroller,),),
                              //
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Container(
                              //                       height: 45,
                              //                       width: 340,
                              //                       child: TextField(
                              //                         decoration: InputDecoration(
                              //                             border:OutlineInputBorder(),
                              //                             labelText: 'Confirm Password ',
                              //                             hintText: 'Confirm Password'
                              //                         ),controller: pwd_confirmcontroller,),),
                              //                     SizedBox(
                              //                       height: 20,
                              //                     ),
                              //                     Container(
                              //                       height: 45,
                              //                       width: 340,
                              //                       child: Text('Booking Details',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w800,fontSize: 22),
                              //                         ),),
                              //                     SizedBox(height: 10,),
                              //                     Container(
                              //                       height: 45,
                              //                       width: 340,
                              // child: TextField(
                              // decoration: const InputDecoration(
                              //   suffixIcon: Icon(Icons.calendar_month),
                              //   hintText: 'From Date',
                              // border: OutlineInputBorder(
                              // borderSide: BorderSide(color: Colors.blue, width: 1)),
                              // focusedBorder: OutlineInputBorder(
                              // borderSide: BorderSide(color: Colors.blue, width: 1)),
                              // enabledBorder: OutlineInputBorder(
                              // borderSide: BorderSide(color: Colors.blue, width: 1)),
                              // ),
                              //     controller: FromdateInputController,
                              //     readOnly: true,
                              //     onTap: () async {
                              //
                              //       DateTime? pickedDate = await showDatePicker(
                              //           context: context,
                              //           initialDate: DateTime.now(),
                              //           firstDate: DateTime(1950),
                              //           lastDate: DateTime(2050));
                              //       if (pickedDate != null) {
                              //        // FromdateInputController.text =pickedDate.toString();
                              //         fromDatestr = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                              //
                              //         FromdateInputController.text = fromDatestr;
                              //       }
                              //
                              //     }
                              //
                              // ),),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              //                     Container(
                              //                       height: 45,
                              //                       width: 340,
                              //                       child: TextField(
                              //                           decoration: const InputDecoration(
                              //                             suffixIcon: Icon(Icons.calendar_month),
                              //                             hintText: 'To Date',
                              //                             border: OutlineInputBorder(
                              //                                 borderSide: BorderSide(color: Colors.blue, width: 1)),
                              //                             focusedBorder: OutlineInputBorder(
                              //                                 borderSide: BorderSide(color: Colors.blue, width: 1)),
                              //                             enabledBorder: OutlineInputBorder(
                              //                                 borderSide: BorderSide(color: Colors.blue, width: 1)),
                              //                           ),
                              //                           controller: TodateInputController,
                              //                           readOnly: true,
                              //                           onTap: () async {
                              //
                              //                             DateTime? pickedDate = await showDatePicker(
                              //                                 context: context,
                              //                                 initialDate: DateTime.now(),
                              //                                 firstDate: DateTime(1950),
                              //                                 lastDate: DateTime(2050));
                              //                             if (pickedDate != null) {
                              //                               //TodateInputController.text =pickedDate.toString();
                              //                               toDatestr = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                              //
                              //                               TodateInputController.text = toDatestr;
                              //                             }
                              //
                              //                           }
                              //
                              //                       ),),
                              // SizedBox(
                              //                       height: 20,
                              //                     ),
                              //                     Container(
                              //                       child:isLoading
                              //                           ? Center(child: CircularProgressIndicator())
                              //                           : TextButton(
                              //                         style: TextButton.styleFrom(
                              //                             fixedSize: const Size(340, 50),
                              //                             foregroundColor: Colors.white,
                              //                             backgroundColor: Colors.blue,
                              //                             shape: RoundedRectangleBorder(
                              //                               borderRadius: BorderRadius.circular(00),
                              //                             ),
                              //                             textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                              //                         child: Text('Book Now'),
                              //                         onPressed: () async {
                              //                           setState(() => isLoading = true);
                              //                           _postData();
                              //                           print('new booking calling token1....');
                              //                           print(RetrivedBearertoekn);
                              //                           SharedPreferences prefs = await SharedPreferences.getInstance();
                              //                           prefs.setString('tokenkey', RetrivedBearertoekn);
                              //
                              //                           await Future.delayed(Duration(seconds: 3), () => () {});
                              //                           setState(() => isLoading = false);
                              //                         },
                              //                       ),
                              //                     )
                              //
                              //                     // Container(
                              //                     //     child: TextButton(
                              //                     //       style: TextButton.styleFrom(
                              //                     //           fixedSize: const Size(340, 50),
                              //                     //           foregroundColor: Colors.white,
                              //                     //           backgroundColor: Colors.blue,
                              //                     //           shape: RoundedRectangleBorder(
                              //                     //             borderRadius: BorderRadius.circular(00),
                              //                     //           ),
                              //                     //           textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                              //                     //       onPressed: () {
                              //                     //         // Navigator.push(
                              //                     //         //   context,
                              //                     //         //   MaterialPageRoute(
                              //                     //         //       builder: (context) => ForgotpwdOTPVerified()
                              //                     //         //   ),
                              //                     //         // );
                              //                     //       },
                              //                     //       child: const Text('Book Now'),
                              //                     //     )
                              //                     // ),
                              //                     // TextField (
                              //                     //   //readOnly: true,
                              //                     //   //controller: emailController,
                              //                     //   decoration: InputDecoration(
                              //                     //       border:OutlineInputBorder(),
                              //                     //       labelText: 'Email',
                              //                     //       hintText: 'Email'
                              //                     //   ),
                              //                     // ),
                              //                     //Text(NewUsertxt,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),)
                              //                   ],
                              //                 ),
                              //
                              //
                              //               ],
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
                }
            }
          }
      ),
    );
  }
}


