/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-20 03:26:37
 ///  Description:
 */

import 'package:Dailoz/dymmyData/task_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Dailoz/widgets/search_form.dart';
import 'package:Dailoz/screens/taskscreen/widget_taskscreen/table_calendar.dart';
import 'package:Dailoz/widgets/dot_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:Dailoz/widgets/task_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// ignore: must_be_immutable
class TaskScreens extends StatefulWidget {
  const TaskScreens({Key? key}) : super(key: key);

  @override
  State<TaskScreens> createState() => _TaskScreensState();
}

class _TaskScreensState extends State<TaskScreens> {
  var dateString = DateFormat.jm().format(DateTime.now());

  DateTime selectedDate = DateTime.now();

  void _selectDate() {
    showDialog(
        context: context,
        builder: (context) {
          return Align(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white),
              height: 400,
              width: 300,
              child: SfDateRangePicker(
                onSubmit: (value) {
                  if (value is DateTime) {
                    setState(() {
                      selectedDate = value;
                    });
                  }
                  Navigator.pop(context);
                },
                initialSelectedRange: PickerDateRange(
                  DateTime.now(),
                  DateTime.now().add(
                    const Duration(days: 3),
                  ),
                ),
                showNavigationArrow: true,
                view: DateRangePickerView.month,
                selectionShape: DateRangePickerSelectionShape.circle,
                selectionTextStyle: const TextStyle(
                  decoration: TextDecoration.none,
                ),
                viewSpacing: 5,
                showActionButtons: true,
                confirmText: 'Save',
                cancelText: 'Cancel',
                selectionMode: DateRangePickerSelectionMode.single,
                monthCellStyle: const DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      GestureDetector(
                        onTap: _selectDate,
                        child: Row(
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TableCalendarWeek(selectedDay: selectedDate),
              const SizedBox(height: 5.0),
              Row(
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
                  const SizedBox(width: 220.0),
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
              tasks.isEmpty
                  ? Center(
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
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tasks.length,
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
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppbar(currentIndex: 1),
      extendBody: true,
    );
  }
}
