import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime dueDate;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.dueDate,
    required this.isCompleted,
  });

  factory Task.fromJson(Map<String, dynamic> json, String docId) {
    return Task(
      id: docId,
      title: json['title'] as String? ?? 'Untitled Task',
      description: json['description'] as String?,
      dueDate: (json['dueDate'] as Timestamp).toDate(),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'dueDate': Timestamp.fromDate(dueDate),
    'isCompleted': isCompleted,
  };
}
