import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Task.dart';
import 'task_repository.dart';

//
// class RemoteTasksRepository implements TaskRepository {
//   final String baseUrl = "ttps://build-wild-moon-3520.fly.dev/tasks";
//
//   Future<List<Task>> getTasks() async {
//     final response = await http.get(Uri.parse(baseUrl));
//     if (response.statusCode == 200) {
//       List data = jsonDecode(response.body);
//       return data.map((e) => Task.fromJson(e)).toList();
//     } else
//       throw Exception("Failed to load tasks");
//   }
//
//
//   @override
//   Future<void> insertTask(Task task) async {
//     final response = await http.post(
//       Uri.parse(baseUrl),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(task.toJson()), // [cite: 419]
//     );
//     if (response.statusCode != 201 &&
//         response.statusCode != 200) throw Exception("Failed to create task");
//   }

//   @override
//   Future<void> deleteTask(int id) {
//
//   }
// }
  class RemoteTasksRepository implements TaskRepository {
  final String baseUrl = "https://build-wild-moon-3520.fly.dev/tasks"; // [cite: 400]

  @override
  Future<List<Task>> getTasks() async {
  final response = await http.get(Uri.parse(baseUrl)); // [cite: 403]
  if (response.statusCode == 200) {
  List data = jsonDecode(response.body);
  return data.map((e) => Task.fromJson(e)).toList(); // [cite: 406]
  }
  throw Exception("Failed to load tasks");
  }

  @override
  Future<void> insertTask(Task task) async {
  final response = await http.post(
  Uri.parse(baseUrl),
  headers: {"Content-Type": "application/json"},
  body: jsonEncode(task.toJson()), // [cite: 419]
  );
  if (response.statusCode != 201 && response.statusCode != 200) throw Exception("Failed to create task");
  }

  @override
  Future<void> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/$id"), // تأكد من عدم وجود \ قبل علامة الـ $
    );

    // نجاح الحذف قد يعود بـ 200 أو 204 (No Content)
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete task: ${response.statusCode}");
    }
  }

  @override
  Future<void> updateTask(Task task) async {
  final response = await http.put(
  Uri.parse("$baseUrl/${task.id}"),
  headers: {"Content-Type":"application/json"}, // تأكد من الـ C كابيتال
  body: jsonEncode(task.toJson()), // السطر ده كان ناقص عشان تبعت التعديلات للسيرفر
  );

  if (response.statusCode != 200) {
  throw Exception("Failed to update task"); // تم تصحيح رسالة الخطأ [cite: 327]
  }
  }

}
