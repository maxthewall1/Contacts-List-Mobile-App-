// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';


// ignore: must_be_immutable
class FieldForm extends StatelessWidget {
  String label;
  TextEditingController controller;
  bool? isForm = true;
  bool isEmail = false;
  bool isPhone = false;
  FieldForm(
      {required this.label,
      required this.controller,
      this.isForm,
      required this.isEmail,
      required this.isPhone,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: this.isForm,
        controller: controller,
        decoration: InputDecoration(
            filled: true, fillColor: Colors.white, labelText: label),
        validator: (value) {
          if (value!.length < 5) {
            return "Digite o contato corretamente";
          }
          if (this.isEmail && !value.contains('@')) {
            return "Digite o email corretamente";
          }
          // ignore: unnecessary_this
          if (this.isPhone && (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value))) {
            return 'Digite um número de telefone válido';
          }
        });
  }
}
