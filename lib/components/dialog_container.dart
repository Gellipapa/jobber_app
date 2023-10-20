import 'package:flutter/material.dart';
import 'package:todo_app/components/button_container.dart';

class DialogContainer extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogContainer(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue,
      content: Container(
          height: 120,
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Add a new task"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonContainer(text: "Save", onPressed: onSave),
                  const SizedBox(width: 8),
                  ButtonContainer(text: "Cancel", onPressed: onCancel)
                ],
              )
            ],
          )),
    );
  }
}
