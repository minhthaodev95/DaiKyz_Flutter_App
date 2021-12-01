/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-12-01 11:11:36
 ///  Description:
 */

import 'package:Dailoz/src/blocs/task_bloc/task_bloc.dart';
import 'package:Dailoz/src/models/task_model.dart';
import 'package:Dailoz/src/repository/task_repository.dart';
import 'package:Dailoz/src/screens/taskscreen/widget_taskscreen/table_calendar.dart';
import 'package:Dailoz/src/screens/widgets/dot_navigation_bar.dart';
import 'package:Dailoz/src/screens/widgets/search_form.dart';
import 'package:Dailoz/src/screens/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TaskScreens extends StatefulWidget {
  const TaskScreens({Key? key}) : super(key: key);

  @override
  State<TaskScreens> createState() => _TaskScreensState();
}

class _TaskScreensState extends State<TaskScreens> {
  var dateString = DateFormat.jm().format(DateTime.now());

  DateTime selectedDate = DateTime.now();
  late TaskBloc _taskBloc;

  // void _selectDate() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return BlocProvider(
  //           create: (context) => _taskBloc,
  //           child: BlocBuilder<TaskBloc, TaskState>(
  //             builder: (context, state) {
  //               return Align(
  //                 child: Container(
  //                   padding: const EdgeInsets.all(15.0),
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(20.0),
  //                       color: Colors.white),
  //                   height: 400,
  //                   width: 300,
  //                   child: SfDateRangePicker(
  //                     onCancel: () {
  //                       Navigator.pop(context);
  //                     },
  //                     onSubmit: (value) {
  //                       if (value is DateTime) {
  //                         setState(() {
  //                           selectedDate = value;
  //                           BlocProvider.of<TaskBloc>(context).add(
  //                               SelectedDayTask(daySelected: selectedDate));
  //                         });
  //                       }
  //                       // Navigator.pop(context);
  //                     },
  //                     initialSelectedRange: PickerDateRange(
  //                       DateTime.now(),
  //                       DateTime.now().add(
  //                         const Duration(days: 3),
  //                       ),
  //                     ),
  //                     showNavigationArrow: true,
  //                     view: DateRangePickerView.month,
  //                     selectionShape: DateRangePickerSelectionShape.circle,
  //                     selectionTextStyle: const TextStyle(
  //                       decoration: TextDecoration.none,
  //                     ),
  //                     viewSpacing: 5,
  //                     showActionButtons: true,
  //                     confirmText: 'Save',
  //                     cancelText: 'Cancel',
  //                     selectionMode: DateRangePickerSelectionMode.single,
  //                     monthCellStyle: const DateRangePickerMonthCellStyle(
  //                       textStyle: TextStyle(fontSize: 15, color: Colors.black),
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         );
  //       });
  // }

  _onDeleteTask(BuildContext context, id) {
    TaskRepository().deleteTask(id);
    BlocProvider.of<TaskBloc>(context)
        .add(SelectedDayTask(daySelected: selectedDate));
  }

  _onDisableTask(BuildContext context, id) {
    TaskRepository().disableTask(id);
    BlocProvider.of<TaskBloc>(context)
        .add(SelectedDayTask(daySelected: selectedDate));
  }

  _onEnableTask(BuildContext context, id) {
    TaskRepository().enableTask(id);
    BlocProvider.of<TaskBloc>(context)
        .add(SelectedDayTask(daySelected: selectedDate));
  }

  _onRestoreTask(BuildContext context, id) {
    TaskRepository().restoreTask(id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _taskBloc = TaskBloc();
    _taskBloc.add(SelectedDayTask(daySelected: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    // print(selectedDate);
    return Scaffold(
      body: BlocProvider(
        create: (context) => _taskBloc,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 35.0),
                SearchForm(),
                const SizedBox(height: 30.0),
                IntrinsicWidth(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Text(
                          'Task',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF12175E),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/date_icon.svg',
                                height: 20, width: 20),
                            const SizedBox(width: 5.0),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                  DateFormat('MMMM \n yyyy')
                                      .format(selectedDate),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      color: Color(0xff525F77))),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                TableCalendarWeek(
                    selectedDay: selectedDate,
                    date: (date) {
                      selectedDate = date;
                    }),
                const SizedBox(height: 5.0),
                IntrinsicWidth(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color(0xff10275A),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          dateString,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Color(0xff000000),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
                  // print('State ScreecTask : $state');
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
                              SvgPicture.asset(
                                  'assets/image_svg/task_empty.svg'),
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
                        itemCount: tasks.length,
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
                          kWidth: 200,
                          onDelete: () =>
                              _onDeleteTask(context, tasks[index].id),
                          onDisable: () =>
                              _onDisableTask(context, tasks[index].id),
                          onEnable: () =>
                              _onEnableTask(context, tasks[index].id),
                          onRestore: () =>
                              _onRestoreTask(context, tasks[index].id),
                        ),
                      );
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppbar(currentIndex: 1),
      extendBody: true,
    );
  }

  @override
  void dispose() {
    _taskBloc.close();
    super.dispose();
  }
}
