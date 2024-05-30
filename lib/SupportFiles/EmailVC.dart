import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:url_launcher/url_launcher.dart';


class EmailComposer extends StatefulWidget {
  @override
  _EmailComposerState createState() => _EmailComposerState();
}

class _EmailComposerState extends State<EmailComposer> {
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  //_toController.text == '';
  void initState() {
    // TODO: implement initState
    super.initState();
    _toController.text = 'info@abisiniya.com';
  }
  Future<void> sendEmail() async {
    _toController.text = 'info@abisiniya.com';
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: _toController.text,
      queryParameters: {'subject': _subjectController.text},
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email app';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Compose Email'),
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
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text('Compose Email',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _toController,
              decoration: InputDecoration(
                labelText: 'To',
              ),
            ),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
              ),
            ),
            // TextField(
            //   controller: _bodyController,
            //   maxLines: null,
            //   keyboardType: TextInputType.multiline,
            //   decoration: InputDecoration(
            //     labelText: 'Body',
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: sendEmail,
              child: Text('Send Email'),
            ),
          ],
        ),
      ),
    );
  }
}