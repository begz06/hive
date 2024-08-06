import 'package:flutter/material.dart';
import 'package:hive_todo/home/witgets/my_button.dart';

class DiologBox extends StatelessWidget {
   DiologBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: Container(
        height: 160,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Add new ToDo items',
                filled: true,
                fillColor: Colors.deepPurple.shade200,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: 'Cancel', onPressed: onCancel),
                SizedBox(
                  width: 10,
                ),
                MyButton(text: 'Save', onPressed: onSave)
              ],
            )
          ],
        ),
      ),
    );
  }
}
