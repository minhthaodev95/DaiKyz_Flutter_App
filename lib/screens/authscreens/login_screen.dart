import 'dart:ui';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:Dailoz/screens/homescreen/home_screen.dart';
import 'package:Dailoz/screens/authscreens/signup_screen2.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
            top: 50.0, bottom: 60.0, left: 15.0, right: 15.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 80.0,
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5B67CA),
                  ),
                ),
              ),
              const SizedBox(
                height: 80.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      top: 20, bottom: 10), // add padding to adjust text
                  isDense: true,
                  hintText: "Email ID or Username",
                  hintStyle: const TextStyle(
                      color: Color(0xffC6CEDD),
                      fontSize: 16,
                      fontFamily: 'Roboto'),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                        top: 10), // add padding to adjust icon
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                          'assets/icons/user_login_icon.svg',
                          width: 25,
                          height: 25),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFormField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      top: 20, bottom: 10), // add padding to adjust text
                  isDense: true,
                  hintText: "Password",
                  hintStyle: const TextStyle(
                      color: Color(0xffC6CEDD),
                      fontSize: 16,
                      fontFamily: 'Roboto'),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                        top: 10), // add padding to adjust icon
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/icons/password_icon.svg',
                          width: 25, height: 25),
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: _obscureText
                        ? const Icon(Icons.visibility_off,
                            color: Color(0xffC6CEDD))
                        : const Icon(Icons.visibility,
                            color: Color(0xffC6CEDD)),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      color: Color(0xff5B67CA),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              const SizedBox(
                height: 60.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
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
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text('or with',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: SignInButton(
                  Buttons.Facebook,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 10,
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: SignInButton(
                  Buttons.GoogleDark,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 10,
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have a account ?  "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff2C406E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
