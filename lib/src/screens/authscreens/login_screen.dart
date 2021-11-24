/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-24 17:53:51
 ///  Description:
 */

import 'dart:ui';

import 'package:Dailoz/src/blocs/auth_bloc/bloc/auth_bloc.dart';
import 'package:Dailoz/src/blocs/login_bloc/bloc/login_bloc.dart';
import 'package:Dailoz/src/blocs/login_bloc/bloc/login_event.dart';
import 'package:Dailoz/src/blocs/login_bloc/bloc/login_state.dart';
import 'package:Dailoz/src/repository/user_repository.dart';
import 'package:Dailoz/src/screens/authscreens/signup_screen.dart';
import 'package:Dailoz/src/screens/homescreen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  final UserRepository _userRepository = UserRepository();
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passController = TextEditingController();
  final _emailController = TextEditingController();

  bool _obscureText = true;
  late LoginBloc _loginBloc;
  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(userRepository: _userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
          create: (context) => _loginBloc,
          child: BlocListener<LoginBloc, LoginState>(
            bloc: _loginBloc,
            listener: (BuildContext context, LoginState state) async {
              if (state.isFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Login Failure'),
                        Icon(Icons.error)
                      ],
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
                        Text('Logging In...'),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
              }
              if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('You are successfully logged in...'),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                });
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              bloc: _loginBloc,
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 50.0, bottom: 10.0, left: 15.0, right: 15.0),
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
                            height: 50.0,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 10), // add padding to adjust text
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
                            controller: _passController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 10), // add padding to adjust text
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
                                  child: SvgPicture.asset(
                                      'assets/icons/password_icon.svg',
                                      width: 25,
                                      height: 25),
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
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginWithCredentialsPressed(
                                      email: _emailController.text.trim(),
                                      password: _passController.text));
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
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                            'Tính năng này hiện chưa khả dụng !!'),
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
                              onPressed: () {
                                context
                                    .read<LoginBloc>()
                                    .add(LoginWithGooglePressed());
                              },
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
                                          builder: (context) =>
                                              const SignupScreen()));
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
                );
              },
            ),
          )),
    );
  }

  // @override
  // void dispose() {
  //   _loginBloc.close();
  //   super.dispose();
  // }
}
