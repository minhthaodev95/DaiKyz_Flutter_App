import 'package:Dailoz/widgets/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  //declare variable
  bool isChecked = false;
  int index = 1;
  List<String> tags = [];

  // Declare Style
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

  void _selectDate(BuildContext context) {
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
                      dateInput = DateFormat('dd-MM-yyyy').format(selectedDate);
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

  void _newTagDialog() {
    var _controller = TextEditingController();
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
                        'New Tag',
                        style: TextStyle(
                          color: Color(0xff10275A),
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
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
                            hintText: "Tag's name",
                            hintStyle: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Roboto",
                                color: Color(0xffB0B5DD)),
                          ),
                        ),
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
                                  setState(() {
                                    tags.add(_controller.value.text.toString());
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text('Save'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntrinsicHeight(
          child: Container(
        height: MediaQuery.of(context).size.height - 70,
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
            // Description field
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
                        const Text('Personal'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 50),
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
                        const Text('Private'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 50),
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
                        const Text('Secret'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            // Tags field
            Text(
              'Tags',
              style: titleStyle,
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              child: Wrap(
                  spacing: 15.0,
                  children: List<Widget>.generate(
                    tags.length,
                    (int idx) {
                      return Chip(
                        deleteIcon: const Icon(
                          Icons.close,
                          size: 15,
                        ),
                        onDeleted: () {
                          setState(() {
                            tags.remove(tags[idx]);
                          });
                        },
                        label: Text(tags[idx],
                            style: const TextStyle(
                              color: Color(0xff8F81FE),
                              fontSize: 14.0,
                              fontFamily: 'Roboto',
                            )),
                      );
                    },
                  ).toList()),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: _newTagDialog,
                child: const Text(
                  '+ Add new tag',
                  style: TextStyle(
                    color: Color(0xffA8AEDF),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            //Create button field
            Expanded(
              child: Container(),
            ),
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
