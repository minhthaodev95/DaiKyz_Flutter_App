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
