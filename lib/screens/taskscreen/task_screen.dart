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
        child: Column(
          children: [
            const SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: SearchForm(),
            ),
            const SizedBox(height: 30.0),
            IntrinsicWidth(
              child: Container(
                // padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                width: MediaQuery.of(context).size.width - 30,
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
                                DateFormat('MMMM \n yyyy').format(selectedDate),
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
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: TableCalendarWeek(selectedDay: selectedDate),
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
            tasks.isEmpty
                ? Container(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Center(
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
                  )
                : ListView.builder(
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
                                    description: tasks[index].description,
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
