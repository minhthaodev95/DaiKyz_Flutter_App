/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-12-12 18:46:26
 ///  Description:
 */

import 'package:Dailoz/src/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:Dailoz/src/repository/user_repository.dart';
import 'package:Dailoz/src/screens/authscreens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureText = true;
  late RegisterBloc _registerBloc;
  final UserRepository _userRepository = UserRepository();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _registerBloc = RegisterBloc(userRepository: _userRepository);
    _emailController.addListener(_onEmailChanged);
    _passController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: BlocProvider(
        create: (context) => _registerBloc,
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('SignUp Failure'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state.isSubmitting) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Signing Up...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            }
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Sign Up Successed !...'),
                    ],
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.only(
                top: 50.0, bottom: 60.0, left: 15.0, right: 15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50.0,
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                          'assets/icons/user_login_icon.svg',
                          width: 12,
                          height: 12),
                    ),
                    hintText: 'Your Name',
                    hintStyle: const TextStyle(
                        color: Color(0xffC6CEDD),
                        fontSize: 16,
                        fontFamily: 'Roboto'),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      prefixIcon:
                          Icon(Icons.email_outlined, color: Color(0xffA4A4A6)),
                      hintText: 'Email ID',
                      hintStyle: TextStyle(
                        color: Color(0xffC6CEDD),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                      )),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _passController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset('assets/icons/password_icon.svg',
                          width: 25, height: 25),
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                        color: Color(0xffC6CEDD),
                        fontSize: 16,
                        fontFamily: 'Roboto'),
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
                  onPressed: _onFormSubmitted,
                  child: const Text(
                    'Create',
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
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Tính năng này hiện chưa khả dụng !!'),
                            ],
                          ),
                          backgroundColor: Colors.blue[600],
                        ),
                      );
                    },
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
                                builder: (context) => LoginScreen()));
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
        ),
      ),
    ));
  }

  void _onEmailChanged() {
    // _loginBloc.emit(EmailChanged(email: email));
    _registerBloc.add(EmailChanged(email: _emailController.text.trim()));
  }

  void _onPasswordChanged() {
    _registerBloc.add(PasswordChanged(password: _passController.text));
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      SignUpWithCredentialsPressed(
        userName: _nameController.text,
        email: _emailController.text.trim(),
        password: _passController.text,
      ),
    );
  }
}
