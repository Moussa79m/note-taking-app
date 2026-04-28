import 'package:flutter/material.dart';
import 'Task.dart';
import 'task_repository.dart'; // حرف t سمول
import 'local_tasks_repository.dart';
import 'remote_tasks_repository.dart';
import 'AddTaskScreen.dart';
class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  //  LocalTasksRepository  RemoteTasksRepository
  LocalTasksRepository repository = LocalTasksRepository();

  List<Task> _tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() => isLoading = true);
    try {
      final data = await repository.getTasks();
      setState(() {
        _tasks = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }
///value notifer
  void showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Task"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              // await repository.deleteTask(_tasks[index].id!);
              // _loadData();
              // setState(() {});
              // Navigator.pop(context);

              final id = _tasks[index].id;
              if (id != null) {
                await repository.deleteTask(id);
                _loadData();
              }
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Tasks")
        ,backgroundColor: Colors.greenAccent),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(onTap: ()async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (c) => AddTaskScreen(repo: repository,)));
            _loadData();},
            title: Text(task.title),
            subtitle: Text(task.category),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => showDeleteDialog(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (c) => AddTaskScreen(repo: repository)));
          _loadData();
        },

      ),

    );
  }
}