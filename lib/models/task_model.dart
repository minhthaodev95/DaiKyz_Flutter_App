/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-22 16:29:05
 ///  Description:
 */

// enum ProcessType {
//   completed,
//   pending,
//   ongoing,
//   canceled,
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  String title;
  String description;
  String dateTask;
  DateTime dateStart;
  DateTime dateEnd;
  List<String> tags;
  String typeId;
  String process;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.dateStart,
      required this.dateEnd,
      required this.dateTask,
      required this.tags,
      required this.typeId,
      required this.process});
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? '',
      title: json['title'],
      description: json['description'],
      dateTask: json['dateTask'],
      dateStart: (json['dateStart'] as Timestamp).toDate(),
      dateEnd: (json['dateEnd'] as Timestamp).toDate(),
      process: json['process'] ?? 'ongoing',
      typeId: json['typeId'] ?? '',
      tags: json['tags'].cast<String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'dateTask': dateTask,
      'process': process,
      'typeId': typeId,
      'tags': tags,
    };
  }
}
