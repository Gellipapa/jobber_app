import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/util/validator.dart';
import 'package:todo_app/util/localization.dart';

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
  List<TextFieldKeyValue> allInputs = [];

  _FormPageState() {
    setUpInputsConfig();
  }

  void setUpInputsConfig() {
    allInputs = [
      TextFieldKeyValue(
          key: "firstName",
          options: FormOptions(
              TextInputType.name,
              [],
              InputDecoration(
                  hintText: loc.firstNamePlaceholder,
                  prefixIcon: Icon(Icons.account_box_outlined)),
              [
                ValidatorProps(ValidatorType.REQUIRED),
              ])),
      TextFieldKeyValue(
          key: "lastName",
          options: FormOptions(
              TextInputType.name,
              [],
              InputDecoration(
                  hintText: loc.lastNamePlaceholder,
                  prefixIcon: Icon(Icons.account_box_outlined)),
              [ValidatorProps(ValidatorType.REQUIRED)])),
      TextFieldKeyValue(
          key: "companyName",
          options: FormOptions(
              TextInputType.text,
              [],
              InputDecoration(
                  hintText: loc.companyNamePlaceholder,
                  prefixIcon: Icon(Icons.business_outlined)),
              [ValidatorProps(ValidatorType.REQUIRED)])),
      TextFieldKeyValue(
          key: "phoneNumber",
          options: FormOptions(
              TextInputType.phone,
              [],
              InputDecoration(
                  hintText: loc.phoneNumberPlaceholder,
                  prefixIcon: Icon(Icons.phone_outlined)),
              [ValidatorProps(ValidatorType.REQUIRED)])),
      TextFieldKeyValue(
          key: "email",
          options: FormOptions(
              TextInputType.emailAddress,
              [],
              InputDecoration(
                  hintText: loc.emailPlaceholder,
                  prefixIcon: Icon(Icons.email_outlined)),
              [])),
      TextFieldKeyValue(
          key: "address",
          options: FormOptions(
              TextInputType.streetAddress,
              [],
              InputDecoration(
                  hintText: loc.addressPlaceholder,
                  prefixIcon: Icon(Icons.location_on_outlined)),
              [
                ValidatorProps(ValidatorType.REQUIRED),
              ])),
    ];
  }

  void submitData() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(allInputs
          .map((input) => "${input.key}: ${input.value.toString()}")
          .join(', '));
    }
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        children: [
          ...List.generate(allInputs.length, (index) {
            final options = allInputs[index].options;
            final key = allInputs[index].key;
            final value = allInputs[index].value;

            return Column(
              children: [
                Container(
                  child: TextFormField(
                    keyboardType: options!.keyboardType,
                    decoration: options.inputDecoration,
                    inputFormatters: options.textInputFormatter,
                    style: TextStyle(fontSize: 16.0),
                    validator: (value) => validator.validatorMethod(
                        value, options.validator, key),
                    onSaved: (value) {
                      if (value != null) {
                        allInputs[index].setField(value);
                      }
                    },
                    onChanged: (value) => {
                      setState(() {
                        isFormValid =
                            _formKey.currentState?.validate() ?? false;
                      })
                    },
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            );
          }),
          ElevatedButton(
            onPressed: isFormValid ? submitData : null,
            child: Text(loc.submitButtonText),
          )
        ],
      ),
    );
  }
}
