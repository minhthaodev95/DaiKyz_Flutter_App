import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:Dailoz/screens/authscreens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
      padding: const EdgeInsets.only(
            top: 50.0, bottom: 60.0, left: 15.0, right: 15.0),
      child: Column(
          children: [
            const SizedBox(
              height: 60.0,
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5B67CA),
                ),
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Username',
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Email ID',
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextFormField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                icon: const Icon(Icons.lock),
                hintText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: _obscureText
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
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
              height: 50.0,
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
              onPressed: () {},
              child: const Text(
                'Sign Up',
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
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Have any account ?  "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Text(
                    "Sign In",
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
        ));
  }
}
