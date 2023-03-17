import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EcsTextField extends StatelessWidget {
  String formControlName;
  String labelText;
  String? hintText;
  Icon? prefixIcon;
  Widget? prefix;
  bool obscureText;
  int? minLines;
  int? maxLines;
  bool expanded;
  bool filled;
  TextInputType keyboardType;
  Map<String, String Function(Object)>? validationMessages;
  List<TextInputFormatter>? inputFormatters;

  EcsTextField({
    Key? key,
    required this.formControlName,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.prefix,
    this.obscureText = false,
    this.minLines,
    this.maxLines,
    this.expanded = false,
    this.filled = false,
    this.keyboardType = TextInputType.text,
    this.validationMessages,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: formControlName,
      maxLines: maxLines,
      minLines: minLines,
      expands: expanded,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        prefix: prefix,
        filled: filled,
      ),
      validationMessages: validationMessages,
      inputFormatters: inputFormatters,
    );
  }
}
