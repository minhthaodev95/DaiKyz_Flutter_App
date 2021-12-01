/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-12-01 10:37:16
 ///  Description:
 */

class TaskType {
  final String id;
  final String title;
  final String icon;
  final String color;
  final double opacity;
  final String colorBoxIcon;
  final int totalTask;

  TaskType({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.opacity,
    required this.colorBoxIcon,
    required this.totalTask,
  });

  factory TaskType.fromJson(Map<String, dynamic> json) {
    return TaskType(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      color: json['color'],
      opacity: json['opacity'],
      colorBoxIcon: json['colorBoxIcon'],
      totalTask: json['totalTask'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'color': color,
      'opacity': opacity,
      'colorBoxIcon': colorBoxIcon,
      'totalTask': totalTask,
    };
  }
}
