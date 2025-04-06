// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../controllers/task_controller.dart';
// import '../models/task_model.dart';
//
// class TaskItem extends StatelessWidget {
//   final Task task;
//   final TaskController taskController = Get.find();
//
//    TaskItem({Key? key, required this.task}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => ListTile(
//       title: Text(
//         task.title,
//         style: TextStyle(
//           decoration: task.isCompleted ? TextDecoration.lineThrough : null,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       subtitle: Text("Due: ${DateFormat.yMMMd().format(task.dueDate)}"),
//       leading: Checkbox(
//         value: task.isCompleted,
//         onChanged: (value) async {
//           try {
//             await taskController.toggleTaskCompletion(task.id, value ?? false);
//           } catch (e) {
//             Get.snackbar('Error', 'Failed to update task');
//           }
//         },
//       ),
//       trailing: IconButton(
//         icon: const Icon(Icons.delete, color: Colors.red),
//         onPressed: () async {
//           try {
//             await taskController.deleteTask(task.id);
//           } catch (e) {
//             Get.snackbar('Error', 'Failed to delete task');
//           }
//         },
//       ),
//     ));
//   }
// }
