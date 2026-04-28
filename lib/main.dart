import 'package:flutter/material.dart';

import 'list_task_screen.dart';

void main() {
  // تشغيل التطبيق
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // تفعيل لغة التصميم الحديثة
      ),
      // تحديد الشاشة الرئيسية التي تظهر عند فتح التطبيق
      home: const TaskListScreen(),
    );
  }
}