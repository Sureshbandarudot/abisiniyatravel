import 'package:introduction_screen/introduction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:tourstravels/tabbar.dart';

// void main() {
//   runApp(HabitApp());
// }

// class HabitApp extends StatelessWidget {
//   const HabitApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: OnboardingScreen(),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Onboarding Page Home')),
//       body: Center(child: Text('Home page after the onboarding pages.')),
//     );
//   }
// }

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const tabbar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      skipStyle: ButtonStyle(
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 17)),
          foregroundColor: MaterialStateProperty.all(Colors.redAccent)),
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [
              Text('Booking',
                  style: GoogleFonts.mochiyPopOne(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 248, 64, 64))),
              const SizedBox(height: 20),
              const Image(image: AssetImage('images/onboarding1.png')),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Driving!',
                  style: GoogleFonts.mochiyPopOne(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 248, 64, 64))),
              const Image(image: AssetImage('images/onboard2.png')),
              const SizedBox(height: 20),
              Text('Play Guitar!',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.mochiyPopOne(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 119, 56, 199)))
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Flying!',
                  style: GoogleFonts.mochiyPopOne(
                      fontSize: 33,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 248, 64, 64))),
              const SizedBox(height: 20),
              const Image(image: AssetImage('images/onboard3.png')),
            ],
          ),
        ),

      ],
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      // onChange: (val) {},
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(
        Icons.arrow_forward,
      ),
      done: const Text('Done',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 248, 64, 64))),
      onDone: () => _onIntroEnd(context),
      nextStyle: ButtonStyle(
          foregroundColor:
          MaterialStateProperty.all(Color.fromARGB(255, 248, 64, 64))),
      dotsDecorator: const DotsDecorator(
        size: Size.square(10),
        activeColor: Colors.redAccent,
        activeSize: Size.square(17),
      ),
    );
  }
}