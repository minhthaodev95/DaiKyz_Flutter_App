/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-12-04 10:36:53
 ///  Description:
 */

import 'package:Dailoz/generated/l10n.dart';
import 'package:Dailoz/src/blocs/auth_bloc/bloc/auth_bloc.dart';
import 'package:Dailoz/src/blocs/localizaton_bloc/localization_bloc.dart';
import 'package:Dailoz/src/repository/user_repository.dart';
import 'package:Dailoz/src/screens/add_task_screen/add_task_screen.dart';
import 'package:Dailoz/src/screens/authscreens/login_screen.dart';
import 'package:Dailoz/src/screens/authscreens/onboarding_screen.dart';
import 'package:Dailoz/src/screens/graphicscreen/analytic_screen.dart';
import 'package:Dailoz/src/screens/homescreen/home_screen.dart';
import 'package:Dailoz/src/screens/profilescreen/profile_screen.dart';
import 'package:Dailoz/src/screens/taskscreen/task_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  // await TaskRepository().outOfDateToCanceled();
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
  late LocalizationBloc _localizationBloc;
  String language = 'English';

  void _getLanguages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      language = (prefs.getString('language') ?? 'English');
    });
  }

  @override
  void initState() {
    _getLanguages();

    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
    _localizationBloc = LocalizationBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _authenticationBloc,
        ),
        BlocProvider(
          create: (context) => _localizationBloc,
        ),
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          late String userName;
          late String userEmail;
          late String photoUrl;
          if (state is Authenticated) {
            (state.currentUser.displayName != null)
                ? userName = state.currentUser.displayName!
                : userName = "Bob";
            (state.currentUser.email != null)
                ? userEmail = state.currentUser.email!
                : userEmail = "user@admin.com";

            (state.currentUser.photoURL != null)
                ? photoUrl = state.currentUser.photoURL!
                : photoUrl =
                    "https://yorktonrentals.com/wp-content/uploads/2017/06/usericon.png";
          }
          if (state is Uninitialized) {
            userName = 'Bob';
            photoUrl =
                "https://yorktonrentals.com/wp-content/uploads/2017/06/usericon.png";
          }
          return BlocBuilder<LocalizationBloc, LocalizationState>(
            builder: (context, localeState) {
              if (language == 'Vietnamese') {
                BlocProvider.of<LocalizationBloc>(context)
                    .add(ChangeToVietnamese());
              }
              return MaterialApp(
                localizationsDelegates: const [
                  // AppLocalizations.delegate,
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: (localeState is EnglishState)
                    ? const Locale('en')
                    : const Locale('vi'),
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                routes: {
                  // '/': (context) => const OnboardingScreen(),
                  '/home': (context) => const HomeScreen(),
                  '/taskScreen': (context) => const TaskScreens(),
                  '/addtask': (context) => const AddTaskScreen(),
                  '/analyticScreen': (context) => const AnalyticScreen(),
                  '/folderScreen': (context) => ProfileScreen(
                      username: userName, photoUrl: photoUrl, email: userEmail),
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
