
// واجهة تحدد العمليات الأساسية لأي مخزن بيانات
import 'Task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> insertTask(Task task);
  Future<void> deleteTask(int id);
  Future<void> updateTask(Task task);
}