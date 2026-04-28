import 'package:sqflite/sqflite.dart';
import 'Task.dart';
import 'task_repository.dart';
import 'package:path/path.dart';
class LocalTasksRepository implements TaskRepository {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), 'tasks_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, category TEXT, isCompleted INTEGER)',
        );
      },
      version: 1,
    );
    return _db!;
  }

  @override
  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return maps.map((e) => Task.fromMap(e)).toList();
  }
  
  
  @override
  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
@override
Future<void> updateTask(Task task) async {
  final db = await database; // الحصول على نسخة من قاعدة البيانات [cite: 451, 477]
  await db.update(
    'tasks', // اسم الجدول [cite: 456, 513]
    task.toMap(), // تحويل الكائن إلى Map ليتم تخزينه [cite: 429, 468]
    where: 'id = ?', // شرط التحديث بناءً على المعرف
    whereArgs: [task.id], // تمرير المعرف لتجنب ثغرات SQL Injection
  );
}
}