

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoWitget extends StatefulWidget {
  TodoWitget(
      {super.key,
      required this.deleteTask,
      required this.taskName,
      required this.taskCompleted,
      this.onChanged});

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  @override
  State<TodoWitget> createState() => _TodoWitgetState();
}

class _TodoWitgetState extends State<TodoWitget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: widget.deleteTask ,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade300,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 0),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Checkbox(
                value: widget.taskCompleted,
                onChanged: widget.onChanged,
                checkColor: Colors.black,
                activeColor: Colors.white,
                side: BorderSide(color: Colors.white),
              ),
              Text(
                widget.taskName,
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
  }
}
