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


  // Future<void> sendEmail() async {
  //
  //   String username = 'sureshbandaruios@gmail.com'; //Your Email
  //   String password =
  //       '****************'; // 16 Digits App Password Generated From Google Account
  //
  //   // final smtpServer = gmail(username, password);
  //   // // Use the SmtpServer class to configure an SMTP server:
  //   // // final smtpServer = SmtpServer('smtp.domain.com');
  //   // // See the named arguments of SmtpServer for further configuration
  //   // // options.
  //   //
  //   // // Create our message.
  //   // final message = Message()
  //   //   ..from = Address(username, 'Ahmed Usman')
  //   //   ..recipients.add('recipient-email@gmail.com')
  //   // // ..ccRecipients.addAll(['abc@gmail.com', 'xyz@gmail.com']) // For Adding Multiple Recipients
  //   // // ..bccRecipients.add(Address('a@gmail.com')) For Binding Carbon Copy of Sent Email
  //   //   ..subject = 'Mail from Mailer'
  //   //   ..text = 'Hello dear, I am sending you email from Flutter application';
  //   //
  //
  //   // final smtpServer = SmtpServer('<your_smtp_server>',
  //   //     username: '<your_username>', password: '<your_password>');
  //   final smtpServer = gmail(username, password);
  //
  //   // final message = Message()
  //   //   ..from = Address(username, 'Ahmed Usman')
  //   final message = Message()
  //     ..from = Address(username, 'Ahmed Usman')
  //
  //     ..recipients.add(_toController.text)
  //     ..subject = _subjectController.text
  //     ..text = _bodyController.text;
  //
  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     //print('Message sent: ${sendReport.sent}');
  //     // Additional code for feedback to the user
  //   } catch (e) {
  //     print('Error occurred while sending email: $e');
  //     // Additional code for error handling
  //   }
  // }

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