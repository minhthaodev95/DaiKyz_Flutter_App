/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-12-09 18:04:38
 ///  Description:
 */

import 'package:Dailoz/src/screens/detail_task_screen/detail_task.dart';
import 'package:Dailoz/src/screens/edit_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_tts/flutter_tts.dart';

class StackWidget extends StatefulWidget {
  const StackWidget({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.typeId,
    required this.process,
    required this.start,
    required this.end,
    required this.cTitleWidth,
    required this.kWidth,
    this.displayDate,
    this.onDelete,
    this.onDisable,
    this.onEnable,
    this.onRestore,
    Key? key,
  }) : super(key: key);
  final VoidCallback? onDelete;
  final VoidCallback? onDisable;
  final VoidCallback? onEnable;
  final VoidCallback? onRestore;
  final String id;
  final String title;
  final String description;
  final DateTime start;
  final DateTime end;
  final List<String> tags;
  final String typeId;
  final String process;
  final double cTitleWidth;
  final double kWidth;
  final bool? displayDate;

  @override
  State<StackWidget> createState() => _StackWidgetState();
}

class _StackWidgetState extends State<StackWidget> {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _speak(text, timeStart, timeEnd) async {
    await flutterTts.setVoice({'name': 'en-au-x-auc-local', 'locale': 'en-AU'});
    //?!@ if build for ios delete setQueueMode ...
    await flutterTts.setQueueMode(1);
    // await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.1);
    // await flutterTts.speak('Your Task is');
    await flutterTts.speak(text);
    await flutterTts.speak('Start at');
    await flutterTts.speak(DateFormat.jm().format(timeStart));
    await flutterTts.speak('to');
    await flutterTts.speak(DateFormat.jm().format(timeEnd));
  }

  Color? _lineColor(process) {
    switch (process) {
      case 'pending':
        {
          return const Color(0xff8F99EB);
        }
      case 'completed':
        {
          return const Color(0xff7DC8E7);
        }
      case 'ongoing':
        {
          return const Color(0xff81E89E);
        }
      case 'canceled':
        {
          return const Color(0xffE88B8C);
        }
    }
  }

  void selectedItem(item) {
    switch (item) {
      case 0:
        widget.onEnable!();
        break;
      case 1:
        widget.onDisable!();
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditTaskScreen(
                    id: widget.id,
                  )),
        );
        break;
      case 3:
        widget.onRestore!();
        break;
      case 4:
        widget.onDelete!();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _speak(widget.title, widget.start, widget.end),
      child: Container(
          decoration: BoxDecoration(
              color: const Color(0xffD6E1F8),
              borderRadius: BorderRadius.circular(15.0)),
          height: 114,
          width: widget.kWidth,
          margin: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      width: 2.5,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _lineColor(widget.process),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: widget.cTitleWidth,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailTask(
                                      id: widget.id,
                                    ),
                                  ),
                                );
                              },
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: const StrutStyle(fontSize: 12.0),
                                text: TextSpan(
                                  text: widget.title,
                                  style: const TextStyle(
                                      color: Color(0xff2C406E),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                DateFormat.Hm().format(widget.start),
                                style: const TextStyle(
                                    color: Color(0xff9AA8C7),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    fontFamily: 'Roboto'),
                              ),
                              const Text(
                                ' - ',
                                style: TextStyle(
                                    color: Color(0xff9AA8C7),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    fontFamily: 'Roboto'),
                              ),
                              Text(
                                DateFormat.Hm().format(widget.end),
                                style: const TextStyle(
                                    color: Color(0xff9AA8C7),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    fontFamily: 'Roboto'),
                              ),
                              if (widget.displayDate == true)
                                const Text(
                                  ' | ',
                                  style: TextStyle(
                                      color: Color(0xff9AA8C7),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      fontFamily: 'Roboto'),
                                ),
                              if (widget.displayDate == true)
                                Text(
                                  DateFormat('dd-MM-yyyy').format(widget.end),
                                  style: const TextStyle(
                                      color: Color(0xff9AA8C7),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      fontFamily: 'Roboto'),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // if (widget.displayDate == null)
                    Expanded(child: Container()),
                    //Button more_vertical inside task Widget
                    SizedBox(
                      width: 25,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        child: PopupMenuButton<int>(
                          elevation: 4,
                          offset: const Offset(5, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          icon: const Icon(
                            Icons.more_vert,
                            size: 18,
                          ),
                          color: Colors.white,
                          itemBuilder: (context) => [
                            if (widget.process == 'pending')
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
                            if (widget.process == 'ongoing')
                              PopupMenuItem<int>(
                                value: 1,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/disable.svg'),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    const Text("Disable")
                                  ],
                                ),
                              ),
                            if (widget.process != 'completed')
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
                            if (widget.process == 'completed' ||
                                widget.process == 'canceled')
                              PopupMenuItem<int>(
                                value: 3,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/restore.svg'),
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
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              //tags
              SizedBox(
                height: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 25, bottom: 10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff8F99EB).withOpacity(0.25),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      margin: const EdgeInsets.only(right: 6.0),
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.tags[index],
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 10.0,
                          color: Color(0xff707DEB),
                        ),
                      ),
                    ),
                  ),
                  itemCount: widget.tags.length,
                ),
              )
            ],
          )),
    );
  }
}
