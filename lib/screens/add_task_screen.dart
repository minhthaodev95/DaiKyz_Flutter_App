import 'package:Dailoz/widgets/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool isChecked = false;
  int index = 1;

  // Style
  TextStyle titleStyle = const TextStyle(
    color: Color(0xff8A8BB3),
    fontSize: 14.0,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );
  TextStyle contentStyle = const TextStyle(
    color: Color(0xff10275a),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
  );
  // Time Picker
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 00);
  TimeOfDay _timeEnd = const TimeOfDay(hour: 7, minute: 30);
  // Date Picker
  DateTime selectedDate = DateTime.now();
  String dateInput = DateFormat('dd-MM-yyyy').format(DateTime.now());

  _selectDate(BuildContext context) async {
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
        dateInput = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

  _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      helpText: 'Edit time',
      context: context,
      initialTime: _time,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  _selectTimeEnd() async {
    final TimeOfDay? newTime = await showTimePicker(
      helpText: 'Edit time',
      context: context,
      initialTime: _timeEnd,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        _timeEnd = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 50, bottom: 50, left: 15.0, right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/back_arrow.svg',
                        ),
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Add Task',
                    style: TextStyle(
                      color: Color(0xff10275A),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            //Title field
            Text(
              'Title',
              style: titleStyle,
            ),
            TextFormField(
              style: contentStyle,
              decoration: const InputDecoration(
                hintText: "Plan for a month",
              ),
            ),
            const SizedBox(height: 25.0),
            //Date field
            Text(
              'Date',
              style: titleStyle,
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                  hintText: dateInput,
                  hintStyle: contentStyle,
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset('assets/icons/date_icon.svg',
                        width: 25, height: 25),
                    onPressed: () => _selectDate(context),
                  )),
            ),
            const SizedBox(height: 25.0),
            //Time field
            Text(
              'Time',
              style: titleStyle,
            ),
            FocusTraversalGroup(
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  Form.of(primaryFocus!.context!)!.save();
                },
                child: Wrap(spacing: 20.0, children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.tight(
                        Size(MediaQuery.of(context).size.width / 2 - 25, 30)),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1.0, color: Colors.grey)),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: _selectTime,
                          child:
                              Text(_time.format(context), style: contentStyle),
                        ),
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tight(
                        Size(MediaQuery.of(context).size.width / 2 - 25, 30)),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1.0, color: Colors.grey)),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: _selectTimeEnd,
                          child: Text(_timeEnd.format(context),
                              style: contentStyle),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 25.0),
            // Décription field
            Text(
              'Description',
              style: titleStyle,
            ),
            TextFormField(
              style: contentStyle,
              decoration: const InputDecoration(
                hintText: "Description for work plan",
              ),
            ),
            const SizedBox(height: 25.0),
            // Type field
            Text(
              'Type',
              style: titleStyle,
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  SizedBox(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 1;
                        });
                      },
                      child: index == 1
                          ? SvgPicture.asset(
                              'assets/icons/checkbox_checked.svg')
                          : SvgPicture.asset(
                              'assets/icons/checkbox.svg',
                              width: 11,
                              height: 11,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Personal'),
                  const SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 2;
                        });
                      },
                      child: index == 2
                          ? SvgPicture.asset(
                              'assets/icons/checkbox_checked.svg')
                          : SvgPicture.asset(
                              'assets/icons/checkbox.svg',
                              width: 11,
                              height: 11,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Private'),
                  const SizedBox(width: 50),
                  SizedBox(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 3;
                        });
                      },
                      child: index == 3
                          ? SvgPicture.asset(
                              'assets/icons/checkbox_checked.svg')
                          : SvgPicture.asset(
                              'assets/icons/checkbox.svg',
                              width: 11,
                              height: 11,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Secret'),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            // Tags field
            Text(
              'Tags',
              style: titleStyle,
            ),
            const SizedBox(height: 20.0),
            Wrap(
              spacing: 15.0,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 15.0, bottom: 8.0, right: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.0),
                    color: const Color(0xffECEAFF),
                  ),
                  child: const Text('Office',
                      style: TextStyle(
                        color: Color(0xff8F81FE),
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                      )),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 15.0, bottom: 8.0, right: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.0),
                    color: const Color(0xffFFEFEB),
                  ),
                  child: const Text('Home',
                      style: TextStyle(
                        color: Color(0xffF0A58E),
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                      )),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 15.0, bottom: 8.0, right: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.0),
                    color: const Color(0xffFFE9ED),
                  ),
                  child: const Text('Urgent',
                      style: TextStyle(
                        color: Color(0xffF57C96),
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                      )),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 15.0, bottom: 8.0, right: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.0),
                    color: const Color(0xffD1FEFF),
                  ),
                  child: const Text('Work',
                      style: TextStyle(
                        color: Color(0xff1EC1C3),
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                      )),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            const Align(
              alignment: Alignment.center,
              child: Text(
                '+ Add new tag',
                style: TextStyle(
                  color: Color(0xffA8AEDF),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            //Create button field
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                primary: const Color(0xff5B67CA),
                minimumSize: const Size(double.infinity,
                    50), // double.infinity is the width and 30 is the height
              ),
              onPressed: () {},
              child: const Text(
                'Create',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ],
        ),
      )),
      bottomNavigationBar: const BottomAppbar(currentIndex: 2),
      extendBody: true,
    );
  }
}
