import 'package:flutter/material.dart';
import 'package:todo_app/components/form_container.dart';
import 'package:todo_app/util/localization.dart';

class AddNewClientPage extends StatelessWidget {
  const AddNewClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(
          title: Text(context.loc.test),
          elevation: 0,
        ),
        body: FormContainer());
  }
}
