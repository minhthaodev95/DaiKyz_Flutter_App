import 'package:Dailoz/dymmyData/task_data.dart';
import 'package:Dailoz/screens/taskscreen/widget_taskscreen/search_form.dart';
import 'package:Dailoz/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';

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

  late DateTimeRange selectedDate;
  _selectDate() async {
    final DateTimeRange? picked = await showDateRangePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: DateTimeRange(
        end: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 5),
        start: DateTime.now(),
      ),
      cancelText: 'Cancel',
      confirmText: 'Save',
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
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
              child: Stack(
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
                  Center(
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
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Expanded(child: SearchForm()),
                  const SizedBox(width: 5.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color(0xffE0DEDE),
                    ),
                    width: 50.0,
                    height: 50.0,
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset('assets/icons/filter.svg'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _selectDate,
                    child: SvgPicture.asset('assets/icons/date_icon.svg',
                        height: 30, width: 30),
                  ),
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
