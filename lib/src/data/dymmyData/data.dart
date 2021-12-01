/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-12-01 10:37:13
 ///  Description:
 */

import 'package:Dailoz/src/models/type_model.dart';

List<TaskType> typeTask = [
  TaskType(
    id: '1',
    title: 'Personal',
    icon: 'assets/icons/personal.svg',
    color: '0xff858FE9', //withOpacity
    opacity: 0.25,
    colorBoxIcon: '0xff858FE9',
    totalTask: 5,
  ),
  TaskType(
    id: '2',
    title: 'Work',
    icon: 'assets/icons/work_icon.svg',
    color: '0xff7FC9E7',
    opacity: 0.25,
    colorBoxIcon: '0xff7FC9E7',
    totalTask: 3,
  ),
  TaskType(
    id: '3',
    title: 'Private',
    icon: 'assets/icons/private_icon.svg',
    color: '0xffE77D7D',
    opacity: 0.25,
    colorBoxIcon: '0xffE77D7D',
    totalTask: 8,
  ),
  TaskType(
    id: '4',
    title: 'Meeting',
    icon: 'assets/icons/meeting_icon.svg',
    color: '0xffCBF9D8',
    opacity: 0.25,
    colorBoxIcon: '0xff81E89E',
    totalTask: 12,
  ),
  TaskType(
    id: '5',
    title: 'Events',
    icon: 'assets/icons/events_icon.svg',
    color: '0xff858FE9',
    opacity: 0.25,
    colorBoxIcon: '0xff858FE9',
    totalTask: 45,
  ),
];
