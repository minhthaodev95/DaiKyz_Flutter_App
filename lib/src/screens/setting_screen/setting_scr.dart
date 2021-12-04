/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-12-03 13:33:48
 ///  Description:
 */

import 'package:Dailoz/src/blocs/localizaton_bloc/localization_bloc.dart';
import 'package:Dailoz/src/repository/user_repository.dart';
import 'package:Dailoz/src/screens/authscreens/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String language = 'English';
  bool _value = false;
  bool _valueR = false;

  void setDefaultValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('language')) {
      return;
    } else {
      prefs.setString('language', language);
      prefs.setBool('notifacation', _value);
      prefs.setBool('notifacationRing', _valueR);
    }
  }

  void getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      language = (prefs.getString('language') ?? 'English');
      _value = (prefs.getBool('notifacation') ?? false);
      _valueR = (prefs.getBool('notifacationRing') ?? false);
    });
  }

  void changeLanguague(String languageInput) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      language = languageInput;
      print('Lan: $language');
    });
    prefs.setString('language', languageInput);
  }

  void _deletePopup() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  height: 200,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Delete Account',
                        style: TextStyle(
                          color: Color(0xff10275A),
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const Text(
                        'Are you sure to delete this account ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff10275A),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto'),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        constraints: const BoxConstraints(minHeight: 52.0),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: OverflowBar(
                          spacing: 18,
                          children: [
                            SizedBox(
                              width: 80.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .white, //change background color of button
                                  onPrimary: const Color(
                                      0xff5B67CA), //change text color of button
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          width: 1.0,
                                          color: Color(0xff5B67CA))),
                                  // elevation: 5.0,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                            ),
                            SizedBox(
                              width: 80.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(
                                      0xff5B67CA), //change background color of button
                                  onPrimary: const Color(
                                      0xffffffff), //change text color of button
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          width: 1.0,
                                          color: Color(0xff5B67CA))),
                                  // elevation: 5.0,
                                ),
                                onPressed: () {
                                  // code delete account and all data.
                                  UserRepository()
                                      .deleteUserandData()
                                      .whenComplete(() => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const OnboardingScreen(),
                                          )));
                                },
                                child: const Text('Sure'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )));
        });
  }

  void _languagePopup() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  height: 200,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Language',
                        style: TextStyle(
                          color: Color(0xff10275A),
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Wrap(runSpacing: 10.0, children: [
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<LocalizationBloc>(context)
                                .add(ChangeToEnglish());
                            changeLanguague('English');
                            setState(() {
                              language = 'English';
                            });
                          },
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'English',
                                  style: TextStyle(
                                    color: Color(0xff10275A),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                if (language == 'English')
                                  SvgPicture.asset(
                                      'assets/icons/checkbox_checked.svg',
                                      width: 18,
                                      height: 18)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<LocalizationBloc>(context)
                                .add(ChangeToVietnamese());
                            changeLanguague('Vietnamese');
                            setState(() {
                              language = 'Vietnamese';
                            });
                          },
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Vietnamese',
                                  style: TextStyle(
                                    color: Color(0xff10275A),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                if (language == 'Vietnamese')
                                  SvgPicture.asset(
                                      'assets/icons/checkbox_checked.svg',
                                      width: 18,
                                      height: 18)
                              ],
                            ),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  void initState() {
    // setDefaultValue();
    getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
          child: Wrap(
            // direction: Axis.vertical,
            runSpacing: 25.0,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffF1F7FF),
                              offset: Offset(-3, 7.0), //(x,y)
                              blurRadius: 13.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        // margin: const EdgeInsets.only(right: 24.0),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/back_arrow.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // width: 45,
                    height: 45,
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Setting',
                      style: TextStyle(
                        color: Color(0xff10275A),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  Container(
                    width: 45,
                    height: 45,
                    padding: const EdgeInsets.all(8.0),
                  ),
                ],
              ),
              const Text(
                'General',
                style: TextStyle(
                    color: Color(0xff10275A),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                      child: Text(
                    'Language',
                    style: TextStyle(
                        color: Color(0xff10275A),
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto'),
                  )),
                  GestureDetector(
                    onTap: _languagePopup,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          (language == 'English') ? 'English' : 'Tiếng Việt',
                          style: const TextStyle(
                              color: Color(0xff10275A),
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Roboto'),
                        ),
                        RotationTransition(
                            turns: const AlwaysStoppedAnimation(180 / 360),
                            child:
                                SvgPicture.asset('assets/icons/back_arrow.svg'))
                      ],
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: _deletePopup,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Delete Acount',
                    style: TextStyle(
                        color: Color(0xff10275A),
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto'),
                  ),
                ),
              ),
              const Text(
                'Notifications',
                style: TextStyle(
                    color: Color(0xff10275A),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Allow Notification',
                    style: TextStyle(
                        color: Color(0xff10275A),
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto'),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      trackColor: const Color(0xffB1C0DE),
                      activeColor: const Color(0xff5B67CA),
                      value: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Allow the Notification Ring',
                    style: TextStyle(
                        color: Color(0xff10275A),
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto'),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      trackColor: const Color(0xffB1C0DE),
                      activeColor: const Color(0xff5B67CA),
                      value: _valueR,
                      onChanged: (value) {
                        setState(() {
                          _valueR = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
