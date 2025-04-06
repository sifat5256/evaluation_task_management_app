import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task_model.dart';
import 'add_task_screen.dart';


class TaskHomeScreen extends StatelessWidget {
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning!";
    if (hour < 18) return "Good Afternoon!";
    return "Good Evening!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${getGreeting()} Today is ${DateFormat('MMMM dd, yyyy').format(DateTime.now())}"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tasks').orderBy('dueDate').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Center(child: Text("Error loading tasks."));
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final tasks = snapshot.data!.docs.map((doc) {
            return Task.fromJson(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();


          if (tasks.isEmpty) return Center(child: Text("No tasks available."));

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text("Due: ${DateFormat('MMMM dd, yyyy').format(task.dueDate)}"),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(task.id)
                        .update({'isCompleted': value});
                  },
                ),
                onLongPress: () {
                  FirebaseFirestore.instance.collection('tasks').doc(task.id).delete();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddTaskScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}
