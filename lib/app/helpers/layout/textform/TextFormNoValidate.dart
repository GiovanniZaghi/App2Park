import 'package:flutter/material.dart';

class TextFormNoValidate extends StatelessWidget {
  final String label;
  final String place;
  final controller;
  final String msg;
  final bool obscure;
  final keyboardtype;
  Icon fieldIcon;
  final int lines;
  final maxlength;
  final autocorrect;
  final enableSuggestions;
  final autofocus;
  final initialValues;
  final enabled;

  TextFormNoValidate(
      {this.label = "Label",
      this.place = "PlaceHolder",
      this.controller,
      this.msg = "Por favor, digite os dados corretamente",
      this.obscure = false,
      this.keyboardtype,
      this.fieldIcon,
      this.lines = 1,
      this.maxlength,
      this.autocorrect = false,
        this.enableSuggestions = false,
        this.autofocus = true,
      this.initialValues,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          initialValue: initialValues,
          maxLines: lines,
          keyboardType: keyboardtype,
          maxLength: maxlength,
          autocorrect: autocorrect,
          enableSuggestions: enableSuggestions,
          autofocus: autofocus,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: label,
            icon: fieldIcon,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
          obscureText: obscure,
          controller: controller,
        ),
      ),
    );
  }
}
