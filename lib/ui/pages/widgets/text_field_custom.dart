import 'package:flutter/material.dart';

class FormField {
  final String label;
  final TextInputType inputType;
  final String? initialValue;

  FormField({
    required this.label,
    required this.inputType,
    this.initialValue,
  });
}
