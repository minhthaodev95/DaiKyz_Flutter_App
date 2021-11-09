import 'package:Dailoz/dymmyData/task_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Dailoz/screens/taskscreen/widget_taskscreen/search_form.dart';
import 'package:Dailoz/screens/taskscreen/widget_taskscreen/table_calendar.dart';
import 'package:Dailoz/widgets/dot_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:Dailoz/widgets/task_widget.dart';

// ignore: must_be_immutable
class TaskScreens extends StatefulWidget {
  TaskScreens({Key? key}) : super(key: key);

  @override
  State<TaskScreens> createState() => _TaskScreensState();
}

class _TaskScreensState extends State<TaskScreens> {
  var dateString = DateFormat.jm().format(DateTime.now());

  DateTime selectedDate = DateTime.now();

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        cancelText: 'Cancel',
        confirmText: 'Save');

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50.0),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: SearchForm(),
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
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
                  const SizedBox(width: 190.0),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _selectDate,
                          child: SvgPicture.asset('assets/icons/date_icon.svg',
                              height: 20, width: 20),
                        ),
                        const SizedBox(width: 5.0),
                        ConstrainedBox(
                          constraints:
                              const BoxConstraints.tightFor(width: 65.0),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text('November 2021',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    color: Color(0xff525F77))),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TableCalendarWeek(),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
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
            ),
            ListView.builder(
              padding: const EdgeInsets.only(top: 5),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Divider(
                        thickness: 1.0,
                        color: Color(0xffE0E3E8),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50, child: Text('0$index:00')),
                        SizedBox(
                          height: 120.0,
                          width: (MediaQuery.of(context).size.width - 65),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: tasks.length,
                            itemBuilder: (context, index) => StackWidget(
                              title: tasks[index].title,
                              tags: tasks[index].tags,
                              typeId: tasks[index].typeId,
                              process: tasks[index].process,
                              start: tasks[index].dateStart,
                              cTitleWidth: 125,
                              end: tasks[index].dateEnd,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppbar(currentIndex: 1),
      extendBody: true,
    );
  }
}
