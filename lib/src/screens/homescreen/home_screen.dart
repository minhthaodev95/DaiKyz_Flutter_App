/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-24 17:57:50
 ///  Description:
 */

import 'package:Dailoz/src/blocs/auth_bloc/bloc/auth_bloc.dart';
import 'package:Dailoz/src/blocs/task_bloc/task_bloc.dart';
import 'package:Dailoz/src/models/task_model.dart';
import 'package:Dailoz/src/repository/user_repository.dart';
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
  final TaskBloc _taskBloc = TaskBloc();
  List<Task> todayTasks = [];

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);

    _authenticationBloc.add(AppStarted());
    // getTodayTask(todayTasks);
  }

  // void getTodayTask(todayTasks) async {
  //   todayTasks = await TaskRepository().getAllTasks();
  // }

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
                      CircleAvatar(
                        backgroundColor: Colors.brown.shade800,
                        backgroundImage: NetworkImage(photoUrl),
                      )
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
                  BlocProvider.of<TaskBloc>(context)
                      .add(SelectedDayTask(daySelected: DateTime.now()));
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
                      itemCount: 3,
                      itemBuilder: (context, index) => StackWidget(
                        title: tasks[index].title,
                        description: tasks[index].description,
                        tags: tasks[index].tags,
                        typeId: tasks[index].typeId,
                        process: tasks[index].process,
                        start: tasks[index].dateStart,
                        end: tasks[index].dateEnd,
                        cTitleWidth: 200,
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
