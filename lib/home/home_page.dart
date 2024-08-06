import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo/home/witgets/show_diolog_witget.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  List<MyListItem> todoList = [];
  late Box _box1;

  @override
  void initState() {
    super.initState();
    initHive();
  }

  void initHive(){
    _box1 = Hive.box("task_box");
  }

  @override
  Widget build(BuildContext context) {
    void checkBoxChanged(int index) {
      setState(() {
        todoList[index].isChecked = !(todoList[index].isChecked ?? false);
      });
    }

    //save new task
    void saveNewTask() {
      setState(() {
        _box1.put("task1", controller.text);
        // todoList.add(MyListItem(isChecked: false, title: controller.text));
        controller.clear();
      });
      Navigator.of(context).pop();
    }

    //create e new task

    void createNewTask() {
      showDialog(
          context: context,
          builder: (ctx) {
            return DiologBox(
              controller: controller,
              onSave: saveNewTask,
              onCancel: Navigator.of(ctx).pop,
            );
          });
    }

    void deleteTask(int index) {
      setState(() {
        _box1.delete("task1");
      });
    }

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: const Text('ToDo App'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: Hive.box('task_box').listenable(),
        builder: (context, box, widget) {
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (_, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (v) {
                          deleteTask(index);
                        },
                        icon: Icons.delete,
                        backgroundColor: Colors.red.shade300,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, right: 20, left: 20, bottom: 0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (v) {
                              // checkBoxChanged(index);
                            },
                            checkColor: Colors.black,
                            activeColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                          ),
                          Text(
                            box.get("task1")??'',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyListItem {
  MyListItem({
    this.isChecked,
    this.title,
  });

  late bool? isChecked;
  final String? title;
}
