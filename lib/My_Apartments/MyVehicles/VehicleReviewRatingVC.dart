import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
import '../ViewApartmentVC.dart';
import 'VehicleViewVC.dart';

class VehicleRatingScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<VehicleRatingScreen> {
  final baseDioSingleton = BaseSingleton();
  String RetrivedBearertoekn = '';
  int VehicleID = 0;
  int Picture_Id = 0;
  late final _ratingController;
  late double _rating;
  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 1.0;
  bool _isRTLMode = false;
  bool _isVertical = false;
  IconData? _selectedIcon;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // RetrivedEmail = prefs.getString('emailkey') ?? "";
      // RetrivedPwd = prefs.getString('passwordkey') ?? "";
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      VehicleID = prefs.getInt('userbookingId') ?? 0;
      Picture_Id = prefs.getInt('Picturekey') ?? 0;
      print('Retrived Ids....');
      print(VehicleID);
      print(Picture_Id);
      print('view Apartment... ');
      print(RetrivedBearertoekn);
    });
  }
  Future<void> _postReviewData() async {
    try {
      String apiUrl = '';
      //apiUrl = baseDioSingleton.AbisiniyaBaseurl + 'booking/vehicle/booking/newuser';
      // apiUrl = 'https://staging.abisiniya.com/api/v1/rating/add';
      apiUrl = baseDioSingleton.AbisiniyaBaseurl + 'rating/add';
      print('vehicle url.....1');
      print(apiUrl);
      print(VehicleID);
      print('call rat...');
      print(_rating.toInt());
      print(RetrivedBearertoekn);
      //print(bookable_type);
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $RetrivedBearertoekn",
        },
        body: jsonEncode(<String, dynamic>{
          'rating_type': 'App\\Models\\Vehicle',
          'rating_id': VehicleID,
          'score': _rating.toInt(),
          'comment': _ratingController.text,
          // Add any other data you want to send in the body
        }),
      );

      print('vehicle sts...');
      print(response.statusCode);
      if (response.statusCode == 201) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(response.body);
        print('Vehicle fresh user data successfully posted');
        print(responseData);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ViewVehicle()
          ),
        );

      } else if (response.statusCode == 422) {
        final responseData = jsonDecode(response.body);
        print('false.....');

        print(responseData);
        var data = jsonDecode(response.body.toString());
        final snackBar = SnackBar(
          content: Text('The email or phone has already been taken.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      setState(() {
        //result = 'Error: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //_ratingController = TextEditingController(text: '3.0');
    _ratingController = TextEditingController();

    _rating = _initialRating;

    _retrieveValues();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        appBarTheme: AppBarTheme(
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.white),
        ),
      ),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Flutter Rating Bar'),
          ),
          body: Directionality(
            textDirection: _isRTLMode ? TextDirection.rtl : TextDirection.ltr,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  _heading('Leave your review'),
                  _ratingBar(_ratingBarMode),
                  SizedBox(height: 20.0),
                  Text(
                    'Rating: $_rating',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),

                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: 340,
                          child:TextFormField(
                            controller: _ratingController,
                            //keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Review',
                              labelText: 'Review',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          child:TextButton(
                            child: Text(
                              'Send',
                              style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () {
                              print('rating....');
                              print(_rating);
                              _postReviewData();
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                elevation: 2,
                                backgroundColor: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

              ),

            ),
          ),
        ),
      ),
    );
  }
  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          initialRating: _initialRating,
          minRating: 1,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 50.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      case 2:
        return RatingBar(
          initialRating: _initialRating,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          ratingWidget: RatingWidget(
            full: _image('assets/heart.png'),
            half: _image('assets/heart_half.png'),
            empty: _image('assets/heart_border.png'),
          ),
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      case 3:
        return RatingBar.builder(
          initialRating: _initialRating,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.redAccent,
                );
              case 2:
                return Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 4:
                return Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
              default:
                return Container();
            }
          },
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      default:
        return Container();
    }
  }

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      color: Colors.amber,
    );
  }

  Widget _heading(String text) => Column(
    children: [
      Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 24.0,
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
    ],
  );
}

class IconAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select Icon',
        style: TextStyle(
          fontWeight: FontWeight.w300,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      titlePadding: EdgeInsets.all(12.0),
      contentPadding: EdgeInsets.all(0),
      content: Wrap(
        children: [
          _iconButton(context, Icons.home),
          _iconButton(context, Icons.airplanemode_active),
          _iconButton(context, Icons.euro_symbol),
          _iconButton(context, Icons.beach_access),
          _iconButton(context, Icons.attach_money),
          _iconButton(context, Icons.music_note),
          _iconButton(context, Icons.android),
          _iconButton(context, Icons.toys),
          _iconButton(context, Icons.language),
          _iconButton(context, Icons.landscape),
          _iconButton(context, Icons.ac_unit),
          _iconButton(context, Icons.star),
        ],
      ),
    );
  }

  Widget _iconButton(BuildContext context, IconData icon) => IconButton(
    icon: Icon(icon),
    onPressed: () => Navigator.pop(context, icon),
    splashColor: Colors.amberAccent,
    color: Colors.amber,
  );
}