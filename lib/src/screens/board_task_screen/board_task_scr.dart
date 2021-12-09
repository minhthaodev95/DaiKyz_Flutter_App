/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-12-09 15:18:48
 ///  Description:
 */

import 'package:Dailoz/src/repository/task_repository.dart';
import 'package:Dailoz/src/screens/board_task_screen/add_task_board.dart';
import 'package:Dailoz/src/screens/widgets/search_form.dart';
import 'package:Dailoz/src/screens/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:flutter/material.dart';

class BoardTask extends StatefulWidget {
  const BoardTask({Key? key, required this.boardTitle, required this.id})
      : super(key: key);

  final String boardTitle;
  final String id;
  @override
  _BoardTaskState createState() => _BoardTaskState();
}

class _BoardTaskState extends State<BoardTask> {
  late String textSearch;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('en_US', '');
  }

  List<String> tags = ['Office', 'Home', 'Urgent', 'Work'];
  // show Dialog Filter
  List selectedIndex = [];
  void _selectFilter() {
    showDialog(
        context: context,
        builder: (context) {
          // bool _selected = false;
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

  _onDeleteTask(BuildContext context, id) {
    TaskRepository().deleteTask(id);
    setState(() {});
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(
              top: 50, bottom: 50, left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Text(
                      widget.boardTitle,
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
              const SizedBox(height: 25.0),
              Row(
                children: [
                  Expanded(child: SearchForm(
                    search: (searchText) {
                      textSearch = searchText;
                    },
                  )),
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
              const SizedBox(height: 15.0),
              FutureBuilder(
                  future: TaskRepository().getAllTasksByBoard(widget.id),
                  builder: (BuildContext context, AsyncSnapshot snapshots) {
                    // print(widget.id);
                    if (!snapshots.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshots.data.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text(
                            'You don’t have any schedule.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff575757),
                              fontSize: 16.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshots.data!.length,
                        itemBuilder: (context, idx) => StackWidget(
                          id: snapshots.data![idx].id,
                          title: snapshots.data![idx].title,
                          description: snapshots.data![idx].description,
                          tags: snapshots.data![idx].tags,
                          typeId: snapshots.data![idx].typeId,
                          process: snapshots.data![idx].process,
                          start: snapshots.data![idx].dateStart,
                          end: snapshots.data![idx].dateEnd,
                          cTitleWidth: 225,
                          kWidth: 220,
                          displayDate: true,
                          onDelete: () =>
                              _onDeleteTask(context, snapshots.data![idx].id),
                          onDisable: () =>
                              _onDisableTask(context, snapshots.data![idx].id),
                          onEnable: () =>
                              _onEnableTask(context, snapshots.data![idx].id),
                          onRestore: () =>
                              _onRestoreTask(context, snapshots.data![idx].id),
                        ),
                      );
                    }
                  }),
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton(
          child: Container(
            width: 60,
            height: 60,
            child: const Icon(
              Icons.add,
              size: 30,
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0xffA3A9D9), Color(0xff5B67CA)])),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskBoardScreen(
                    titleBoard: widget.boardTitle, typeId: widget.id),
              ),
            );
          },
        ));
  }
}
