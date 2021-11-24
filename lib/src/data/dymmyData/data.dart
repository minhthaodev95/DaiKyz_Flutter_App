/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-24 17:52:02
 ///  Description:
 */

import 'package:Dailoz/src/models/type_model.dart';
import 'package:flutter/material.dart';

List<TaskType> typeTask = [
  TaskType(
    id: '1',
    title: 'Personal',
    icon: 'assets/icons/personal.svg',
    color: const Color(0xff858FE9).withOpacity(0.25),
    colorBackIcon: const Color(0xff858FE9),
    totalTask: 5,
  ),
  TaskType(
    id: '2',
    title: 'Work',
    icon: 'assets/icons/work_icon.svg',
    color: const Color(0xff7FC9E7).withOpacity(0.25),
    colorBackIcon: const Color(0xff7FC9E7),
    totalTask: 3,
  ),
  TaskType(
    id: '3',
    title: 'Private',
    icon: 'assets/icons/private_icon.svg',
    color: const Color(0xffE77D7D).withOpacity(0.25),
    colorBackIcon: const Color(0xffE77D7D),
    totalTask: 8,
  ),
  TaskType(
    id: '4',
    title: 'Meeting',
    icon: 'assets/icons/meeting_icon.svg',
    color: const Color(0xffCBF9D8).withOpacity(0.25),
    colorBackIcon: const Color(0xff81E89E),
    totalTask: 12,
  ),
  TaskType(
    id: '5',
    title: 'Events',
    icon: 'assets/icons/events_icon.svg',
    color: const Color(0xffE0E3F9),
    colorBackIcon: const Color(0xff858FE9),
    totalTask: 45,
  ),
];
