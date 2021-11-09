enum ProcessType {
  completed,
  pending,
  ongoing,
  canceled,
}

class Task {
  String id;
  String title;
  String description;
  DateTime dateStart;
  DateTime dateEnd;
  List<String> tags;
  String typeId;
  ProcessType process;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.dateStart,
      required this.dateEnd,
      required this.tags,
      required this.typeId,
      required this.process});
  factory Task.toJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateStart: json['dateStart'],
      dateEnd: json['dateEnd'],
      process: json['process'],
      typeId: json['typeId'],
      tags: json['tags'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'process': process,
      'typeId': typeId,
      'tags': tags,
    };
  }
}
