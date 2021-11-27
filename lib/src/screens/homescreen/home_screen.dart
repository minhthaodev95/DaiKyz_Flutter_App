/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-27 17:21:48
 ///  Description:
 */

import 'package:Dailoz/src/blocs/auth_bloc/bloc/auth_bloc.dart';
import 'package:Dailoz/src/blocs/task_bloc/task_bloc.dart';
import 'package:Dailoz/src/models/task_model.dart';
import 'package:Dailoz/src/repository/task_repository.dart';
import 'package:Dailoz/src/repository/user_repository.dart';
import 'package:Dailoz/src/screens/authscreens/login_screen.dart';
import 'package:Dailoz/src/screens/setting_screen/setting_scr.dart';
import 'package:Dailoz/src/screens/taskscreen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:Dailoz/src/screens/homescreen/widget_homescreen/custom_gridview_task.dart';
import 'package:Dailoz/src/screens/widgets/dot_navigation_bar.dart';
import 'package:Dailoz/src/screens/widgets/task_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserRepository _userRepository = UserRepository();
  late AuthenticationBloc _authenticationBloc;
  late TaskBloc _taskBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
    _taskBloc = TaskBloc();
    _taskBloc.add(SelectedDayTask(daySelected: DateTime.now()));
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

  _onDeleteTask(BuildContext context, id) {
    TaskRepository().deleteTask(id);
    BlocProvider.of<TaskBloc>(context)
        .add(SelectedDayTask(daySelected: DateTime.now()));
  }

  _onDisableTask(BuildContext context, id) {
    TaskRepository().disableTask(id);
    BlocProvider.of<TaskBloc>(context)
        .add(SelectedDayTask(daySelected: DateTime.now()));
  }

  _onEnableTask(BuildContext context, id) {
    TaskRepository().enableTask(id);
    BlocProvider.of<TaskBloc>(context)
        .add(SelectedDayTask(daySelected: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    // final _authenticationBloc = context.select(
    //     (AuthenticationBloc _authenticationBloc) => _authenticationBloc);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50.0),
            BlocProvider(
              create: (context) => _authenticationBloc,
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  late String userName;
                  late String photoUrl;
                  if (state is Authenticated) {
                    (state.currentUser.displayName != null)
                        ? userName = state.currentUser.displayName!
                        : userName = "Bob";

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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi $userName',
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0,
                              color: Color(0xFF12175E),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text('Let’s make this day productive',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                              ))
                        ],
                      ),
                      PopupMenuButton<int>(
                        elevation: 4,
                        offset: const Offset(5, 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.brown.shade800,
                          backgroundImage: NetworkImage(photoUrl),
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
                      // CircleAvatar(
                      //   backgroundColor: Colors.brown.shade800,
                      //   backgroundImage: NetworkImage(photoUrl),
                      // )
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 50.0),
            const Text(
              'My Task',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF12175E),
              ),
            ),
            const SizedBox(height: 10.0),
            const CustomGridViewTask(), //Task view
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today Task',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF12175E),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TaskScreens()));
                  },
                  child: const Text('View all',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          color: Color(0xff393F93))),
                ),
              ],
            ),

            BlocProvider(
              create: (context) => _taskBloc,
              child:
                  BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
                if (state is TaskInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TaskDaySelectedLoaded) {
                  List<Task>? tasks = state.taskSelectedDay;
                  if (tasks.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/image_svg/task_empty.svg'),
                            const SizedBox(
                              height: 15.0,
                            ),
                            const Text(
                              'You don’t have any schedule today.\nTap the plus button to create new to-do.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff575757),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (tasks.length < 3) ? tasks.length : 3,
                      itemBuilder: (context, index) => StackWidget(
                        id: tasks[index].id,
                        title: tasks[index].title,
                        description: tasks[index].description,
                        tags: tasks[index].tags,
                        typeId: tasks[index].typeId,
                        process: tasks[index].process,
                        start: tasks[index].dateStart,
                        end: tasks[index].dateEnd,
                        cTitleWidth: 200,
                        kWidth: 220,
                        onDelete: () => _onDeleteTask(context, tasks[index].id),
                        onDisable: () =>
                            _onDisableTask(context, tasks[index].id),
                        onEnable: () => _onEnableTask(context, tasks[index].id),
                      ),
                    );
                  }
                }
                return const Center(child: CircularProgressIndicator());
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppbar(currentIndex: 0),
      extendBody: true,
    );
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }
}
