/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-20 03:25:07
 ///  Description:
 */

import 'package:flutter/material.dart';

class TaskType {
  final String id;
  final String title;
  final String icon;
  final Color color;
  final Color colorBackIcon;
  final int totalTask;

  TaskType({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.colorBackIcon,
    required this.totalTask,
  });

  factory TaskType.fromJson(Map<String, dynamic> json) {
    return TaskType(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      color: json['color'],
      colorBackIcon: json['colorBackIcon'],
      totalTask: json['totalTask'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'color': color,
      'colorBackIcon': colorBackIcon,
      'totalTask': totalTask,
    };
  }
}
