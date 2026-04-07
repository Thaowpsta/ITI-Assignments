import 'package:flutter/material.dart';
import '../AppColors.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final Widget? icon;
  final bool isObscure;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.text,
    this.icon,
    this.isObscure = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: AppColors.lightGrey),
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: icon,
      ),
    );
  }
}