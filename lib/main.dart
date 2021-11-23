/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-21 18:56:53
 ///  Description:
 */

import 'package:Dailoz/repository/user_repository.dart';
import 'package:Dailoz/screens/add_task_screen/add_task_screen.dart';
import 'package:Dailoz/screens/authscreens/login_screen.dart';
import 'package:Dailoz/screens/authscreens/onboarding_screen.dart';
import 'package:Dailoz/screens/graphicscreen/analytic_screen.dart';
import 'package:Dailoz/screens/homescreen/home_screen.dart';
import 'package:Dailoz/screens/profilescreen/profile_screen.dart';
import 'package:Dailoz/screens/taskscreen/task_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth_bloc/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              // '/': (context) => const OnboardingScreen(),
              '/home': (context) => const HomeScreen(),
              '/taskScreen': (context) => const TaskScreens(),
              '/addtask': (context) => const AddTaskScreen(),
              '/analyticScreen': (context) => const AnalyticScreen(),
              '/folderScreen': (context) => ProfileScreen(),
            },
            theme: ThemeData(
              // Define the default brightness and colors.
              primaryColor: Colors.green,
              brightness: Brightness.light,
              fontFamily: 'Roboto',
            ),
            home: state is Uninitialized
                ? const OnboardingScreen()
                : state is Unauthenticated
                    ? LoginScreen()
                    : state is Authenticated
                        ? const HomeScreen()
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }
}

// class App extends StatefulWidget {
//   const App({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _AppState createState() => _AppState();
// }

// //state
// class _AppState extends State<App> {
//   final UserRepository _userRepository = UserRepository();
//   late AuthenticationBloc _authenticationBloc;

//   @override
//   void initState() {
//     super.initState();
//     _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
//     _authenticationBloc.add(AppStarted());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => _authenticationBloc,
//       child: Scaffold(
//         body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//           builder: (BuildContext context, AuthenticationState state) {
//             if (state is Uninitialized) {
//               print('onboarding');
//               return OnboardingScreen();
//             }
//             if (state is Unauthenticated) {
//               print('login screen');
//               return LoginScreen();
//             }
//             if (state is Authenticated) {
//               print('authed');
//               return HomeScreen();
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _authenticationBloc.close();
//     super.dispose();
//   }
// }
