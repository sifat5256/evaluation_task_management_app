import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  void _saveTask() async {
    if (_titleController.text.isEmpty || _selectedDate == null) return;

    // Add task to Firestore
    final docRef = await FirebaseFirestore.instance.collection('tasks').add({
      'title': _titleController.text.trim(),
      'description': _descController.text.trim(),
      'dueDate': _selectedDate,
      'isCompleted': false,
    });

    // Store document ID inside the document
    await docRef.update({'id': docRef.id});

    Navigator.pop(context); // Close screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Task Title"),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: "Description (Optional)"),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedDate == null
                    ? "Pick a Due Date"
                    : "Due Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}"),
                ElevatedButton(onPressed: _pickDate, child: Text("Select Date"))
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveTask, child: Text("Save Task")),
          ],
        ),
      ),
    );
  }
}
