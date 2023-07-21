import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EcsTextField extends StatelessWidget {
  final String formControlName;
  final String labelText;
  final String? hintText;
  final Icon? prefixIcon;
  final Widget? prefix;
  final bool obscureText;
  final int? minLines;
  final int? maxLines;
  final bool expanded;
  final bool filled;
  final TextInputType keyboardType;
  final Map<String, String Function(Object)>? validationMessages;
  final List<TextInputFormatter>? inputFormatters;

  const EcsTextField({
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
      obscureText: obscureText,
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
