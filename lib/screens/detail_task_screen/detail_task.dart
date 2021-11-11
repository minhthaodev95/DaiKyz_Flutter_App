import 'package:Dailoz/dymmyData/data.dart';
import 'package:Dailoz/models/task_model.dart';
import 'package:Dailoz/models/type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DetailTask extends StatefulWidget {
  DetailTask(
      {required this.title,
      required this.description,
      required this.tags,
      required this.typeId,
      required this.process,
      required this.start,
      required this.end,
      Key? key})
      : super(key: key);
  final String title;
  final String description;
  final DateTime start;
  final DateTime end;
  final List<String> tags;
  final String typeId;
  final ProcessType process;

  @override
  _DetailTaskState createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  bool isChecked = false;
  // List<String> tags = ['Office', 'Home', 'Urgent'];
  void selectedItem(item) {
    switch (item) {
      case 0:
        print('Enable');
        break;
      case 1:
        print("Disable");
        break;
      case 2:
        print("Edit");
        break;
      case 3:
        print("Restore");
        break;
      case 4:
        print("Delete");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    TaskType taskType =
        typeTask.where((element) => element.id == widget.typeId).elementAt(0);
    String estDate = DateFormat('dd MMMM yyyy').format(widget.start);
    String estTime1 = DateFormat.Hm().format(widget.start);
    String estTime2 = DateFormat.Hm().format(widget.end);
    String estTime3 = DateFormat('a').format(widget.end);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          // height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(
              top: 50.0, bottom: 50, left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Row appbar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
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
                  const Center(
                    child: Text(
                      'Detail',
                      style: TextStyle(
                        color: Color(0xff10275A),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  PopupMenuButton<int>(
                    elevation: 4,
                    offset: const Offset(5, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/more_horiz.svg',
                    ),
                    color: Colors.white,
                    itemBuilder: (context) => [
                      if (widget.process == ProcessType.pending)
                        PopupMenuItem<int>(
                          value: 0,
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/enable.svg'),
                              const SizedBox(
                                width: 7,
                              ),
                              const Text("Enable")
                            ],
                          ),
                        ),
                      if (widget.process == ProcessType.ongoing)
                        PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/disable.svg'),
                              const SizedBox(
                                width: 7,
                              ),
                              const Text("Disable")
                            ],
                          ),
                        ),
                      if (widget.process != ProcessType.completed)
                        PopupMenuItem<int>(
                          value: 2,
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/edit.svg'),
                              const SizedBox(
                                width: 7,
                              ),
                              const Text("Edit")
                            ],
                          ),
                        ),
                      if (widget.process == ProcessType.completed ||
                          widget.process == ProcessType.canceled)
                        PopupMenuItem<int>(
                          value: 3,
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/restore.svg'),
                              const SizedBox(
                                width: 7,
                              ),
                              const Text("Restore")
                            ],
                          ),
                        ),
                      PopupMenuItem<int>(
                        value: 4,
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/delete.svg'),
                            const SizedBox(
                              width: 7,
                            ),
                            const Text("Delete")
                          ],
                        ),
                      ),
                    ],
                    onSelected: (item) => selectedItem(item),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                widget.title,
                style: const TextStyle(
                    color: Color(0xff10275A),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              const SizedBox(height: 20.0),

              RichText(
                text: TextSpan(
                    text: taskType.title,
                    style: const TextStyle(
                        color: Color(0xff2E426E),
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto'),
                    children: const [
                      TextSpan(
                        text: ' Type',
                        style: TextStyle(
                            color: Color(0xff2E426E),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto'),
                      )
                    ]),
              ),
              const SizedBox(height: 20.0),

              // date and time row
              OverflowBar(
                alignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment
                              .topRight, // 10% of the width, so there are ten blinds.
                          colors: <Color>[
                            Color(0xffE77D7D),
                            Color(0xffFE9D9D),
                          ], // red to yellow
                          tileMode: TileMode
                              .clamp, // repeats the gradient over the canvas
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      height: 100,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Est. Date',
                            style: TextStyle(
                                color: const Color(0xffffffff).withOpacity(0.5),
                                fontSize: 24.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto'),
                          ),
                          Text(
                            estDate,
                            style: const TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto'),
                          ),
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment
                              .topRight, // 10% of the width, so there are ten blinds.
                          colors: <Color>[
                            Color(0xffE77D7D),
                            Color(0xffFE9D9D),
                          ], // red to yellow
                          tileMode: TileMode
                              .clamp, // repeats the gradient over the canvas
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      height: 100,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Est. Time',
                            style: TextStyle(
                                color: const Color(0xffffffff).withOpacity(0.5),
                                fontSize: 24.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto'),
                          ),
                          RichText(
                            text: TextSpan(
                                text: estTime1,
                                style: const TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto'),
                                children: [
                                  const TextSpan(
                                    text: ' - ',
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto'),
                                  ),
                                  TextSpan(
                                    text: estTime2,
                                    style: const TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto'),
                                  ),
                                  const TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto'),
                                  ),
                                  TextSpan(
                                    text: estTime3,
                                    style: const TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto'),
                                  ),
                                ]),
                          ),
                        ],
                      )),
                ],
              ),
              const SizedBox(height: 20.0),

              const Text(
                'Task',
                style: TextStyle(
                    color: Color(0xff10275A),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, left: 15.0, bottom: 15.0, right: 15.0),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: isChecked
                            ? SvgPicture.asset(
                                'assets/icons/checkbox_checked.svg',
                                width: 24.0)
                            : SvgPicture.asset(
                                'assets/icons/checkbox.svg',
                                width: 24,
                                height: 24,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Flexible(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          decoration: isChecked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontSize: 22.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5.0),

              const Text(
                'Description',
                style: TextStyle(
                    color: Color(0xff10275A),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              const SizedBox(height: 20.0),

              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.description,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 18.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              const Text(
                'Tags',
                style: TextStyle(
                    color: Color(0xff10275A),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              const SizedBox(height: 20.0),

              SizedBox(
                child: Wrap(
                    spacing: 15.0,
                    children: List<Widget>.generate(
                      widget.tags.length,
                      (int idx) {
                        return Chip(
                          label: Text(widget.tags[idx],
                              style: const TextStyle(
                                color: Color(0xff8F81FE),
                                fontSize: 14.0,
                                fontFamily: 'Roboto',
                              )),
                        );
                      },
                    ).toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
