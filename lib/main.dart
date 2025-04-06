// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:intl/intl.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(TaskManagerApp());
// }
//
// class TaskManagerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Task Manager',
//       home: TaskHomeScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class TaskHomeScreen extends StatefulWidget {
//   @override
//   _TaskHomeScreenState createState() => _TaskHomeScreenState();
// }
//
// class _TaskHomeScreenState extends State<TaskHomeScreen> {
//   final CollectionReference tasks =
//   FirebaseFirestore.instance.collection('tasks');
//
//   String getGreeting() {
//     final hour = DateTime.now().hour;
//     if (hour < 12) return 'Good Morning!';
//     if (hour < 17) return 'Good Afternoon!';
//     return 'Good Evening!';
//   }
//
//   void _showAddTaskSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (_) => Padding(
//         padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: AddTaskForm(onTaskAdded: () => setState(() {})),
//       ),
//     );
//   }
//
//   void _toggleTaskComplete(DocumentSnapshot doc) {
//     tasks.doc(doc.id).update({'completed': !(doc['completed'] ?? false)});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final today = DateFormat('MMMM d, y').format(DateTime.now());
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Task Manager")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '${getGreeting()} Today is $today',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: tasks.orderBy('dueDate').snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData)
//                     return Center(child: CircularProgressIndicator());
//
//                   final taskDocs = snapshot.data!.docs;
//
//                   if (taskDocs.isEmpty) {
//                     return Center(child: Text("No tasks yet!"));
//                   }
//
//                   return ListView(
//                     children: taskDocs.map((doc) {
//                       final title = doc['title'];
//                       final dueDate = (doc['dueDate'] as Timestamp).toDate();
//                       final completed = doc['completed'] ?? false;
//                       return ListTile(
//                         title: Text(
//                           title,
//                           style: TextStyle(
//                             decoration: completed
//                                 ? TextDecoration.lineThrough
//                                 : TextDecoration.none,
//                           ),
//                         ),
//                         subtitle: Text(DateFormat.yMMMd().format(dueDate)),
//                         trailing: Checkbox(
//                           value: completed,
//                           onChanged: (_) => _toggleTaskComplete(doc),
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showAddTaskSheet,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// class AddTaskForm extends StatefulWidget {
//   final VoidCallback onTaskAdded;
//   AddTaskForm({required this.onTaskAdded});
//
//   @override
//   _AddTaskFormState createState() => _AddTaskFormState();
// }
//
// class _AddTaskFormState extends State<AddTaskForm> {
//   final _formKey = GlobalKey<FormState>();
//   String _title = '';
//   String? _description;
//   DateTime? _dueDate;
//
//   void _submit() {
//     if (_formKey.currentState!.validate() && _dueDate != null) {
//       _formKey.currentState!.save();
//
//       FirebaseFirestore.instance.collection('tasks').add({
//         'title': _title,
//         'description': _description,
//         'dueDate': _dueDate,
//         'completed': false,
//       }).then((_) {
//         widget.onTaskAdded();
//         Navigator.of(context).pop();
//       });
//     }
//   }
//
//   void _pickDate() async {
//     final now = DateTime.now();
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: now,
//       firstDate: now,
//       lastDate: DateTime(now.year + 5),
//     );
//     if (picked != null) {
//       setState(() => _dueDate = picked);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Task Title'),
//               validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//               onSaved: (val) => _title = val!,
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Description (optional)'),
//               onSaved: (val) => _description = val,
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Text(
//                   _dueDate == null
//                       ? 'No date chosen'
//                       : DateFormat.yMMMd().format(_dueDate!),
//                 ),
//                 Spacer(),
//                 TextButton(
//                   onPressed: _pickDate,
//                   child: Text('Pick Due Date'),
//                 )
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _submit,
//               child: Text('Add Task'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const AddTaskSheet(),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning!";
    if (hour < 17) return "Good Afternoon!";
    return "Good Evening!";
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat('MMMM d, yyyy').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${_getGreeting()} Today is $currentDate",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('tasks').orderBy('dueDate').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final tasks = snapshot.data!.docs;
                  if (tasks.isEmpty) {
                    return const Center(child: Text("No tasks yet!"));
                  }

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final title = task['title'];
                      final dueDate = (task['dueDate'] as Timestamp).toDate();
                      final isCompleted = task['isCompleted'] ?? false;

                      return CheckboxListTile(
                        title: Text(
                          title,
                          style: TextStyle(
                            decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        subtitle: Text(DateFormat('MMM d, yyyy').format(dueDate)),
                        value: isCompleted,
                        onChanged: (val) {
                          _firestore.collection('tasks').doc(task.id).update({
                            'isCompleted': val,
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submitTask() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      FirebaseFirestore.instance.collection('tasks').add({
        'title': _titleController.text.trim(),
        'description': _descController.text.trim(),
        'dueDate': _selectedDate,
        'isCompleted': false,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
              validator: (value) =>
              value!.isEmpty ? 'Title is required' : null,
            ),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description (optional)'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? 'No Date Chosen'
                      : 'Due: ${DateFormat('MMM d, yyyy').format(_selectedDate!)}',
                ),
                const Spacer(),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text('Choose Date'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _submitTask,
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}

