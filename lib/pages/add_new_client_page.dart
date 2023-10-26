import 'package:flutter/material.dart';
import 'package:todo_app/components/form_container.dart';
import 'package:todo_app/util/localization.dart';

class AddNewClientPage extends StatelessWidget {
  const AddNewClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text(
              context.loc.newClientTitle,
            ),
          ),
          elevation: 0,
        ),
        body: FormContainer());
  }
}
