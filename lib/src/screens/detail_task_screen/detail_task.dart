/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-12-09 15:27:24
 ///  Description:
 */

import 'package:Dailoz/src/data/data.dart';
import 'package:Dailoz/src/models/task_model.dart';
import 'package:Dailoz/src/models/type_model.dart';
import 'package:Dailoz/src/repository/task_repository.dart';
import 'package:Dailoz/src/screens/edit_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:string_extensions/string_extensions.dart';

class DetailTask extends StatefulWidget {
  const DetailTask({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  _DetailTaskState createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  late Task task;
  _onDeleteTask(BuildContext context, id) {
    TaskRepository().deleteTask(id);
    Navigator.pop(context);
  }

  _onDisableTask(BuildContext context, id) {
    TaskRepository().disableTask(id);
    setState(() {});
  }

  _onEnableTask(BuildContext context, id) {
    TaskRepository().enableTask(id);
    setState(() {});
  }

  _onRestoreTask(BuildContext context, id) {
    TaskRepository().restoreTask(id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  // List<String> tags = ['Office', 'Home', 'Urgent'];
  void selectedItem(item) {
    switch (item) {
      case 0:
        _onEnableTask(context, widget.id);
        break;
      case 1:
        // widget.onDisable!();
        _onDisableTask(context, widget.id);
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
        // widget.onRestore!();
        // setState(() {});
        _onRestoreTask(context, widget.id);
        break;
      case 4:
        _onDeleteTask(context, widget.id);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(task.title);

    return Scaffold(
      body: FutureBuilder(
        future: TaskRepository().getTaskById(widget.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            TaskType taskType = typeTask
                .where((element) => element.id == snapshot.data.typeId)
                .elementAt(0);
            String estDate =
                DateFormat('dd MMMM yyyy').format(snapshot.data.dateStart);
            String estTime1 = DateFormat.Hm().format(snapshot.data.dateStart);
            String estTime2 = DateFormat.Hm().format(snapshot.data.dateEnd);
            String estTime3 = DateFormat('a').format(snapshot.data.dateEnd);
            return SingleChildScrollView(
              child: Padding(
                // height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(
                    top: 50.0, bottom: 50, left: 15.0, right: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
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
                          child: const Text(
                            'Detail',
                            style: TextStyle(
                              color: Color(0xff10275A),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                          child: Container(
                            width: 45,
                            height: 45,
                            padding: const EdgeInsets.all(4.0),
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
                            child: PopupMenuButton<int>(
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
                                if (snapshot.data.process == 'pending')
                                  PopupMenuItem<int>(
                                    value: 0,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/enable.svg'),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        const Text("Enable")
                                      ],
                                    ),
                                  ),
                                if (snapshot.data.process == 'ongoing')
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
                                if (snapshot.data.process != 'completed')
                                  PopupMenuItem<int>(
                                    value: 2,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/edit.svg'),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        const Text("Edit")
                                      ],
                                    ),
                                  ),
                                if (snapshot.data.process == 'completed' ||
                                    snapshot.data.process == 'canceled')
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
                                      SvgPicture.asset(
                                          'assets/icons/delete.svg'),
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
                    const SizedBox(height: 20.0),
                    Center(
                      child: Text(
                        snapshot.data.title.toString().capitalize!,
                        style: TextStyle(
                            decoration: (snapshot.data.process == 'completed')
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: const Color(0xff10275A),
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto'),
                        textAlign: TextAlign.center,
                      ),
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
                                      color: const Color(0xffffffff)
                                          .withOpacity(0.5),
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
                                      color: const Color(0xffffffff)
                                          .withOpacity(0.5),
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
                      child: (snapshot.data.description == '')
                          ? const Text(
                              'This task don\'t have a description',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 16.0,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          : Text(
                              snapshot.data.description,
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
                      child: snapshot.data.tags.isEmpty
                          ? const Center(
                              child: Text(
                                'This task don\'t have any tags',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )
                          : Wrap(
                              spacing: 15.0,
                              children: List<Widget>.generate(
                                snapshot.data.tags.length,
                                (int idx) {
                                  return Chip(
                                    label: Text(snapshot.data.tags[idx],
                                        style: const TextStyle(
                                          color: Color(0xff8F81FE),
                                          fontSize: 14.0,
                                          fontFamily: 'Roboto',
                                        )),
                                  );
                                },
                              ).toList(),
                            ),
                    ),
                    const SizedBox(height: 20.0),

                    if (snapshot.data.process != 'completed')
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          primary: const Color(0xff5B67CA),
                          minimumSize: const Size(double.infinity,
                              50), // double.infinity is the width and 30 is the height
                        ),
                        onPressed: () async {
                          await TaskRepository().completedTask(widget.id);
                          setState(() {});
                        },
                        child: const Text(
                          'Completed!',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
