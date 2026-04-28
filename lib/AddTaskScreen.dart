import 'package:flutter/material.dart';

import 'Task.dart';
import 'task_repository.dart';


class AddTaskScreen extends StatefulWidget {
  final TaskRepository repo;
  const AddTaskScreen({super.key, required this.repo});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = "Personal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: _descController, decoration: const InputDecoration(labelText: "Description")),
            DropdownButtonFormField<String>(
              value: _selectedCategory,

              items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => _selectedCategory = v!),
              decoration: const InputDecoration(labelText: "Category"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_titleController.text.isNotEmpty) {
                  final task = Task(
                    id: DateTime.now().millisecondsSinceEpoch ~/ 1000, // معرف مؤقت للمحلي
                    title: _titleController.text,
                    description: _descController.text,
                    category: _selectedCategory,
                  );
                  await widget.repo.insertTask(task);
                  Navigator.pop(context);
                }
              },
              child: const Text("Save Task"),
            )
          ],
        ),
      ),
    );
  }
}