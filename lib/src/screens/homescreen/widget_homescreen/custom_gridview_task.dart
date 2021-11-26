/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-26 14:08:09
 ///  Description:
 */

import 'package:Dailoz/src/repository/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:Dailoz/src/screens/homescreen/widget_homescreen/canceled.dart';
import 'package:Dailoz/src/screens/homescreen/widget_homescreen/completed.dart';
import 'package:Dailoz/src/screens/homescreen/widget_homescreen/ongoing.dart';
import 'package:Dailoz/src/screens/homescreen/widget_homescreen/pending.dart';

class CustomGridViewTask extends StatefulWidget {
  const CustomGridViewTask({Key? key}) : super(key: key);

  @override
  State<CustomGridViewTask> createState() => _CustomGridViewTaskState();
}

class _CustomGridViewTaskState extends State<CustomGridViewTask> {
  int numCompleted = 0;
  int numOngoing = 0;
  int numCanceled = 0;
  int numPending = 0;
  void _getNumberTaskByProcess() async {
    int _numCompleted = await TaskRepository().numberTask('completed');
    int _numOngoing = await TaskRepository().numberTask('ongoing');
    int _numCanceled = await TaskRepository().numberTask('canceled');
    int _numPending = await TaskRepository().numberTask('pending');
    setState(() {
      numCompleted = _numCompleted;
      numOngoing = _numOngoing;
      numCanceled = _numCanceled;
      numPending = _numPending;
    });
  }

  @override
  void initState() {
    super.initState();
    _getNumberTaskByProcess();
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      padding: const EdgeInsets.all(2.0),
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20.0,
      children: [
        CompletedWidget(num: numCompleted),
        PendingWidget(num: numPending),
        OnGoingWidget(num: numOngoing),
        CanceledWidget(num: numCanceled),
      ],
      staggeredTiles: const <StaggeredTile>[
        StaggeredTile.count(2, 2.1),
        StaggeredTile.count(2, 1.7),
        StaggeredTile.count(2, 2.1),
        StaggeredTile.count(2, 1.7),
      ],
    );
  }
}
