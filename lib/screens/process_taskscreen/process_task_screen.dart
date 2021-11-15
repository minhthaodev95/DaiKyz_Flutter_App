import 'package:Dailoz/dymmyData/task_data.dart';
import 'package:Dailoz/widgets/search_form.dart';
import 'package:Dailoz/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:flutter/material.dart';

class ProcessTask extends StatefulWidget {
  const ProcessTask({Key? key, required this.processTitle}) : super(key: key);

  final String processTitle;
  @override
  _ProcessTaskState createState() => _ProcessTaskState();
}

class _ProcessTaskState extends State<ProcessTask> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('en_US', '');
  }

  String _oneDayFromNow(int numdays) {
    return DateFormat('dd MMMM yyyy', 'en_US').format(DateTime.now()
        .add(Duration(days: numdays))); // To get yesterday use "Subtract"
  }

  // show Date Rang Picker
  late DateTimeRange selectedDate;
  void _selectDate() {
    showDialog(
        context: context,
        builder: (context) {
          return Align(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              height: 400,
              width: 300,
              child: SfDateRangePicker(
                onSubmit: (value) {
                  if (value is PickerDateRange) {
                    print(value.startDate);
                    print(value.endDate);
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
                selectionMode: DateRangePickerSelectionMode.range,
                monthCellStyle: const DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
            ),
          );
        });
  }

  List<String> tags = ['Office', 'Home', 'Urgent', 'Work'];
  // show Dialog Filter
  List selectedIndex = [];
  void _selectFilter() {
    showDialog(
        context: context,
        builder: (context) {
          bool _selected = false;
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                height: 400,
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sort by tag',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Color(0xff000000),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto'),
                    ),
                    SizedBox(
                      width: 300,
                      height: 80,
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 200, minWidth: 200),
                        child: ListView.builder(
                          itemCount: tags.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.only(right: 5.0),
                            child: ChoiceChip(
                              onSelected: (bool selected) {
                                setState(() {
                                  if (!selectedIndex.contains(index)) {
                                    selectedIndex.add(index);
                                  } else if (selectedIndex.contains(index)) {
                                    selectedIndex.remove(index);
                                  }
                                });
                              },
                              backgroundColor: index == 0
                                  ? const Color(0xffECEAFF)
                                  : index == 1
                                      ? const Color(0xffFFEFEB)
                                      : index == 2
                                          ? const Color(0xffFFE9ED)
                                          : const Color(0xffD1FEFF),
                              label: Text(
                                tags[index],
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: index == 0
                                      ? const Color(0xff8F81FE)
                                      : index == 1
                                          ? const Color(0xffF0A58E)
                                          : index == 2
                                              ? const Color(0xffF57C96)
                                              : const Color(0xff1EC1C3),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                ),
                              ),
                              selected: selectedIndex.contains(index),
                              disabledColor: const Color(0xff000000),
                              selectedColor: const Color(0xff8F99EB),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Sort by type',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Color(0xff000000),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto'),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 5.0, top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: const Color(0xff8F99EB)),
                            width: 80,
                            height: 31,
                            child: const Center(
                              child: Text(
                                'Private',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 5.0, top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: const Color(0xffE88B8C)),
                            width: 80,
                            height: 31,
                            child: const Center(
                              child: Text(
                                'Personal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 5.0, top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: const Color(0xff7EC8E7)),
                            width: 80,
                            height: 31,
                            child: const Center(
                              child: Text(
                                'Secret',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Sort by ',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Color(0xff000000),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto'),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 10.0, top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: const Color(0xffDDDEE1)),
                            width: 80,
                            height: 31,
                            child: const Center(
                              child: Text(
                                'Newest',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 10.0, top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: const Color(0xffDDDEE1)),
                            width: 80,
                            height: 31,
                            child: const Center(
                              child: Text(
                                'Farthest',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                                        width: 1.0, color: Color(0xff5B67CA))),
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
                                        width: 1.0, color: Color(0xff5B67CA))),
                                // elevation: 5.0,
                              ),
                              onPressed: () {},
                              child: const Text('Filter'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
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
                    child: Text(
                      widget.processTitle,
                      style: const TextStyle(
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
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(child: SearchForm()),
                  const SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: _selectFilter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xffE0DEDE),
                      ),
                      width: 50.0,
                      height: 50.0,
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('assets/icons/filter.svg'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: GestureDetector(
                onTap: _selectDate,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/date_icon.svg',
                        height: 30, width: 30),
                    const SizedBox(width: 5.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                          DateFormat('MMMM \n yyyy').format(DateTime.now()),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              color: Color(0xff000000))),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.only(top: 5),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 0),
                child: Column(
                  children: [
                    const SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          _oneDayFromNow(index),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: Color(0xff525F77),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        SizedBox(
                          height: 120.0,
                          width: (MediaQuery.of(context).size.width - 5),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
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
      )),
    );
  }
}
