import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/util/validator.dart';

class FormOptions {
  TextInputType? keyboardType = TextInputType.text;
  List<TextInputFormatter>? textInputFormatter = [];
  InputDecoration? inputDecoration;
  List<ValidatorProps>? validator;

  FormOptions(this.keyboardType, this.textInputFormatter, this.inputDecoration,
      this.validator);
}

class TextFieldKeyValue {
  String key = '';
  String? value = '';
  FormOptions? options;

  TextFieldKeyValue({required this.key, this.value, this.options});

  void setField(String? value) {
    this.value = value;
  }
}

class FormContainer extends StatefulWidget {
  const FormContainer({super.key});

  @override
  State<FormContainer> createState() => _FormPageState();
}

class _FormPageState extends State<FormContainer> {
  final _formKey = GlobalKey<FormState>();
  final validator = AllValidators();
  bool isFormValid = false;
  final allInputs = [
    TextFieldKeyValue(
        key: "username",
        options: FormOptions(
            TextInputType.number,
            [FilteringTextInputFormatter.digitsOnly],
            const InputDecoration(hintText: "Csak számokat írj be"),
            [
              ValidatorProps(ValidatorType.REQUIRED),
              ValidatorProps(ValidatorType.MINMAX, 2, 3)
            ])),
    TextFieldKeyValue(
        key: "password",
        options: FormOptions(
            TextInputType.text,
            [],
            const InputDecoration(hintText: "Írj be valami szöveget"),
            [ValidatorProps(ValidatorType.REQUIRED)]))
  ];

  void submitData() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(
          allInputs.map((input) => "${input.key}: ${input.value}").join(', '));
    }
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: [
          ...List.generate(allInputs.length, (index) {
            final options = allInputs[index].options;
            final key = allInputs[index].key;
            final value = allInputs[index].value;

            return TextFormField(
              keyboardType: options!.keyboardType,
              decoration: options.inputDecoration,
              inputFormatters: options.textInputFormatter,
              validator: (value) =>
                  validator.validatorMethod(value, options.validator, key),
              onSaved: (value) {
                if (value != null) {
                  allInputs[index].setField(value);
                }
              },
              onChanged: (value) => {
                setState(() {
                  isFormValid = _formKey.currentState?.validate() ?? false;
                })
              },
            );
          }),
          ElevatedButton(
            onPressed: isFormValid ? submitData : null,
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
