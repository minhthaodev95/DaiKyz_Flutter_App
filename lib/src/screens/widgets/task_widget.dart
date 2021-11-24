/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-24 17:59:41
 ///  Description:
 */

import 'package:Dailoz/src/screens/detail_task_screen/detail_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class StackWidget extends StatelessWidget {
  const StackWidget({
    required this.title,
    required this.description,
    required this.tags,
    required this.typeId,
    required this.process,
    required this.start,
    required this.end,
    required this.cTitleWidth,
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final DateTime start;
  final DateTime end;
  final List<String> tags;
  final String typeId;
  final String process;
  final double cTitleWidth;

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
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xffD6E1F8),
            borderRadius: BorderRadius.circular(15.0)),
        height: 114,
        width: 220,
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    width: 2.5,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _lineColor(process),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: cTitleWidth,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailTask(
                                          title: title,
                                          description: description,
                                          tags: tags,
                                          typeId: typeId,
                                          process: process,
                                          start: start,
                                          end: end,
                                        )),
                              );
                            },
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              strutStyle: const StrutStyle(fontSize: 12.0),
                              text: TextSpan(
                                text: title,
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
                              DateFormat.Hm().format(start),
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
                              DateFormat.Hm().format(end),
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
                          if (process == 'pending')
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
                          if (process == 'ongoing')
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
                          if (process != 'completed')
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
                          if (process == 'completed' || process == 'canceled')
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
                      tags[index],
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 10.0,
                        color: Color(0xff707DEB),
                      ),
                    ),
                  ),
                ),
                itemCount: tags.length,
              ),
            )
          ],
        ));
  }
}
