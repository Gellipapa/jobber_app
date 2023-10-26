import 'package:flutter/material.dart';
import 'package:todo_app/components/button_container.dart';
import 'package:todo_app/util/localization.dart';

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
          height: 75,
          child: Column(
            children: [
              Center(child: Text(loc.dialogLeaveMessage)),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonContainer(text: loc.dialogYes, onPressed: onSave),
                  const SizedBox(width: 8),
                  ButtonContainer(text: loc.dialogCancel, onPressed: onCancel)
                ],
              )
            ],
          )),
    );
  }
}
