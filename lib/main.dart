import 'package:Dailoz/screens/add_task_screen.dart';
import 'package:Dailoz/screens/authscreens/onboarding_screen.dart';
import 'package:Dailoz/screens/graphicscreen/analytic_screen.dart';
import 'package:Dailoz/screens/homescreen/home_screen.dart';
import 'package:Dailoz/screens/process_taskscreen/process_task_screen.dart';
import 'package:Dailoz/screens/profilescreen/profile_screen.dart';
import 'package:Dailoz/screens/taskscreen/task_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
        '/taskScreen': (context) => TaskScreens(),
        '/addtask': (context) => const AddTaskScreen(),
        '/analyticScreen': (context) => const AnalyticScreen(),
        '/folderScreen': (context) => ProfileScreen(),
      },
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        fontFamily: 'Roboto',
      ),
    );
  }
}
