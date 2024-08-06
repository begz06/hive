import 'package:flutter/material.dart';
import 'package:hive_todo/home/home_page.dart';


void main() {
  runApp(TodoApp());
}


class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage() ,
    );
  }
}