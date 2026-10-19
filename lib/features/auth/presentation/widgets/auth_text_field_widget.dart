import 'package:flutter/material.dart';

import '../../../../core/widgets/app_text_field.dart';

class AuthTextFieldWidget extends StatelessWidget {
  const AuthTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.obscure = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      validator: validator,
      obscure: obscure,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      suffixIcon: suffixIcon,
    );
  }
}
