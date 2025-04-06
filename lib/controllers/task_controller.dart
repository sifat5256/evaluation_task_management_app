// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/task_model.dart';
//
// class TaskController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final RxList<Task> tasks = <Task>[].obs;
//   final RxString error = ''.obs;
//   final RxBool isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchTasks();
//   }
//
//   void fetchTasks() {
//     isLoading.value = true;
//     _firestore.collection('tasks').snapshots().listen(
//             (snapshot) {
//           tasks.value = snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList();
//           isLoading.value = false;
//         },
//         onError: (e) {
//           error.value = 'Failed to fetch tasks: $e';
//           isLoading.value = false;
//         }
//     );
//   }
//
//   Future<void> addTask(Task task) async {
//     try {
//       await _firestore.collection('tasks').doc(task.id).set(task.toJson());
//     } catch (e) {
//       error.value = 'Failed to add task: $e';
//       rethrow;
//     }
//   }
//
//   Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {
//     try {
//       await _firestore.collection('tasks').doc(taskId).update({'isCompleted': isCompleted});
//     } catch (e) {
//       error.value = 'Failed to update task: $e';
//       rethrow;
//     }
//   }
//
//   Future<void> deleteTask(String taskId) async {
//     try {
//       await _firestore.collection('tasks').doc(taskId).delete();
//     } catch (e) {
//       error.value = 'Failed to delete task: $e';
//       rethrow;
//     }
//   }
// }
