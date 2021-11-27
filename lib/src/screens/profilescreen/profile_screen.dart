/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-27 14:57:32
 ///  Description:
 */

import 'package:Dailoz/src/blocs/auth_bloc/bloc/auth_bloc.dart';
import 'package:Dailoz/src/blocs/board_bloc/board_bloc.dart';
import 'package:Dailoz/src/data/dymmyData/data.dart';
import 'package:Dailoz/src/models/type_model.dart';
import 'package:Dailoz/src/repository/user_repository.dart';
import 'package:Dailoz/src/screens/authscreens/login_screen.dart';
import 'package:Dailoz/src/screens/board_task_screen/board_task_scr.dart';
import 'package:Dailoz/src/screens/setting_screen/setting_scr.dart';
import 'package:flutter/material.dart';
import 'package:Dailoz/src/screens/widgets/dot_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(
      {Key? key,
      required this.username,
      required this.photoUrl,
      required this.email})
      : super(key: key);
  final String username;
  final String email;
  final String photoUrl;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late List<TaskType> taskType = typeTask;
  int index = 1;
  final UserRepository _userRepository = UserRepository();
  late AuthenticationBloc _authenticationBloc;
  late BoardBloc _boardBloc;
  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
    _boardBloc = BoardBloc();
    _boardBloc.add(LoadBoard());
  }

  void selectedItem(item) {
    switch (item) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingScreen()),
        );
        break;
      case 1:
        _logOutPopup();
        break;
    }
  }

  void _logOutPopup() {
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
                        'Log Out',
                        style: TextStyle(
                          color: Color(0xff10275A),
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const Text(
                        'Are you sure to log out from this account ?',
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
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(LoggedOut());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
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

  void _newBoardPopup() {
    var _controller = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    height: 350,
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Create Board',
                            style: TextStyle(
                              color: Color(0xff10275A),
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Wrap(children: [
                          const Text(
                            'Board Name',
                            style: TextStyle(
                              color: Color(0xff10275A),
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 55.0,
                              child: TextFormField(
                                controller: _controller,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Roboto",
                                    color: Color(0xff727EE0)),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffE0DEDE),
                                  hintText: "Board's name",
                                  hintStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: "Roboto",
                                      color: Color(0xffB0B5DD)),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        Wrap(children: [
                          const Text(
                            'Type',
                            style: TextStyle(
                              color: Color(0xff10275A),
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      index = 1;
                                    });
                                  },
                                  child: Wrap(
                                    spacing: 3.0,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      index == 1
                                          ? SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: SvgPicture.asset(
                                                  'assets/icons/checkbox_checked.svg',
                                                  width: 12,
                                                  height: 12),
                                            )
                                          : SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: SvgPicture.asset(
                                                'assets/icons/checkbox.svg',
                                                width: 12,
                                                height: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                      const Text(
                                        'Personal',
                                        style: TextStyle(
                                          color: Color(0xff10275A),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.0,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      index = 2;
                                    });
                                  },
                                  child: Wrap(
                                    spacing: 3.0,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      index == 2
                                          ? SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: SvgPicture.asset(
                                                  'assets/icons/checkbox_checked.svg',
                                                  width: 12,
                                                  height: 12),
                                            )
                                          : SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: SvgPicture.asset(
                                                'assets/icons/checkbox.svg',
                                                width: 12,
                                                height: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                      const Text(
                                        'Private',
                                        style: TextStyle(
                                          color: Color(0xff10275A),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.0,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      index = 3;
                                    });
                                  },
                                  child: Wrap(
                                    spacing: 3.0,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      index == 3
                                          ? SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: SvgPicture.asset(
                                                  'assets/icons/checkbox_checked.svg',
                                                  width: 12,
                                                  height: 12),
                                            )
                                          : SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: SvgPicture.asset(
                                                'assets/icons/checkbox.svg',
                                                width: 12,
                                                height: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                      const Text(
                                        'Secret',
                                        style: TextStyle(
                                          color: Color(0xff10275A),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.0,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
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
                                  onPressed: () {},
                                  child: const Text('Save'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )));
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Center(
          child: SingleChildScrollView(
              child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => _authenticationBloc,
              ),
              BlocProvider(
                create: (context) => BoardBloc(),
              ),
            ],
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              bloc: _authenticationBloc,
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                          child: Container(
                            width: 45,
                            height: 45,
                            padding: const EdgeInsets.all(4.0),
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
                            margin: const EdgeInsets.only(right: 24.0),
                            child: PopupMenuButton<int>(
                              elevation: 4,
                              offset: const Offset(5, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              icon: SvgPicture.asset(
                                'assets/icons/more_horiz.svg',
                                // width: 24,
                              ),
                              color: Colors.white,
                              itemBuilder: (context) => [
                                PopupMenuItem<int>(
                                  value: 0,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/setting_icon.svg'),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      const Text(
                                        "Setting",
                                        style: TextStyle(
                                          color: Color(0xff10275A),
                                          fontFamily: 'Roboto',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/log_out_icon.svg'),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      const Text(
                                        "Log Out",
                                        style: TextStyle(
                                          color: Color(0xff10275A),
                                          fontFamily: 'Roboto',
                                          fontSize: 16.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (item) => selectedItem(item),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffF1F7FF),
                            offset: Offset(-3, 7.0), //(x,y)
                            blurRadius: 13.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.brown.shade800,
                        backgroundImage: NetworkImage(widget.photoUrl),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      widget.username,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color(0xff10275A),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      widget.email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xff10275A),
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 24.0, bottom: 15.0, right: 24.0),
                      child: BlocBuilder<BoardBloc, BoardState>(
                        bloc: _boardBloc,
                        builder: (context, state) {
                          if (state is BoardInitial) {
                            BlocProvider.of<BoardBloc>(context)
                                .add(LoadBoard());
                          } else if (state is BoardLoaded) {
                            List<TaskType> boards = state.allBoards;
                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                                shrinkWrap: true,
                                itemCount: (boards.length + 1),
                                itemBuilder: (context, index) {
                                  if (index == (boards.length)) {
                                    return GestureDetector(
                                      onTap: _newBoardPopup,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFFEFEB),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xffF0A58E),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              height: 60,
                                              width: 60,
                                              child: const Icon(
                                                  Icons.add_box_outlined),
                                            ),
                                            const SizedBox(height: 8.0),
                                            const Text(
                                              'Create Board',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff10275A),
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                          ],
                                        )),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BoardTask(
                                                  boardTitle:
                                                      boards[index].title,
                                                  id: boards[index].id)),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(int.parse(
                                                  boards[index].color))
                                              .withOpacity(
                                                  boards[index].opacity),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              decoration: BoxDecoration(
                                                color: Color(int.parse(
                                                    boards[index]
                                                        .colorBoxIcon)),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              height: 60,
                                              width: 60,
                                              child: SvgPicture.asset(
                                                  boards[index].icon),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              boards[index].title,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff10275A),
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            RichText(
                                              text: TextSpan(
                                                text: boards[index]
                                                    .totalTask
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff393939),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Roboto',
                                                ),
                                                children: const <TextSpan>[
                                                  TextSpan(
                                                      text: ' Task',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff393939),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: 'Roboto',
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                      ),
                                    );
                                  }
                                });
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          )),
        ),
      ),
      bottomNavigationBar: const BottomAppbar(currentIndex: 4),
      extendBody: true,
    );
  }
}
