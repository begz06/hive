import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_todo/home/todo_witget.dart';
import 'package:hive_todo/home/witgets/show_diolog_witget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List todoList = [];

    void checkBoxChanged(int index) {
      setState(() {
        todoList[index][1] = !todoList[index][1];
      });
    }

    //save new task
    void saveNewTask() {
      setState(() {
        todoList.add(MyListItem(isChecked: false, title: controller.text));
        print('qoshildi');
        print(todoList.last);
        controller.clear();
        
      });
      // Navigator.of(context).pop();
    }

    //create e new task

    void createNewTask() {
      showDialog(
          context: context,
          builder: (context) {
            return DiologBox(
              controller: controller,
              onSave: saveNewTask,
              onCancel: Navigator.of(context).pop,
            );
          });
    }

    void deleteTask(int index) {
      setState(() {
        todoList.removeAt(index);
      });
    }

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: Text('ToDo App'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            print(todoList.last);
            print('Builder');

            return Slidable(
              endActionPane: ActionPane(
                motion: StretchMotion(),
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
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Checkbox(
                        value: todoList[index][1],
                        onChanged: (v) {
                          checkBoxChanged(index);
                        },
                        checkColor: Colors.black,
                        activeColor: Colors.white,
                        side: BorderSide(color: Colors.white),
                      ),
                      Text(
                        todoList[index][0],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyListItem {
  const MyListItem({
    this.isChecked,
    this.title,
  });
  final bool? isChecked;
  final String? title;
}
