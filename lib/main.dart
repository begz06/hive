import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_todo/home/home_page.dart';
import 'package:path_provider/path_provider.dart';

late Box<dynamic> _box;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initHive();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

Future<void> _initHive() async {
  const String boxName = "task_box";
  final Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  _box = await Hive.openBox<dynamic>(boxName);
}