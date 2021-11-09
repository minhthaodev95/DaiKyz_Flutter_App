import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Dailoz/screens/authscreens/login_screen.dart';
import 'package:Dailoz/screens/authscreens/signup_screen2.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
            top: 50.0, bottom: 60.0, left: 10.0, right: 10.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Center(
                  child: SvgPicture.asset('assets/image_svg/logo.svg',
                      width: 300, height: 300),
                ),
              ),
              const Expanded(
                child: Text(
                  'DaiKey',
                  style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Roboto',
                      color: Color(0XFF5B67CA)),
                ),
                flex: 1,
              ),
              const Expanded(
                child: Text(
                  'Plan what you will do to be more organized for today, tomorrow and beyond',
                  style: TextStyle(
                      fontSize: 14, fontFamily: 'Roboto', color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                flex: 1,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 30,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    primary: const Color(0xff5B67CA),
                    minimumSize: const Size(double.infinity,
                        50), // double.infinity is the width and 30 is the height
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Color(0xff5B67CA),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
