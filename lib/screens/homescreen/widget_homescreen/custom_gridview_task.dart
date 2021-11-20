/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-20 03:26:03
 ///  Description:
 */

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:Dailoz/screens/homescreen/widget_homescreen/canceled.dart';
import 'package:Dailoz/screens/homescreen/widget_homescreen/completed.dart';
import 'package:Dailoz/screens/homescreen/widget_homescreen/ongoing.dart';
import 'package:Dailoz/screens/homescreen/widget_homescreen/pending.dart';

class CustomGridViewTask extends StatefulWidget {
  const CustomGridViewTask({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomGridViewTask> createState() => _CustomGridViewTaskState();
}

class _CustomGridViewTaskState extends State<CustomGridViewTask> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      padding: const EdgeInsets.all(2.0),
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20.0,
      children: const [
        CompletedWidget(),
        PendingWidget(),
        OnGoingWidget(),
        CanceledWidget(),
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
