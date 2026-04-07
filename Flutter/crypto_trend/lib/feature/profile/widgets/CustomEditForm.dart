import 'package:flutter/material.dart';

import '../../../utils/AppColors.dart';

class CustomEditForm extends StatelessWidget {
  const CustomEditForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField("Username", "User1234"),
        const SizedBox(height: 20),
        _buildTextField("Email", "Example@mail.com"),
        const SizedBox(height: 20),
        _buildTextField("Password", "***************", isPassword: true),
        const SizedBox(height: 20),
        _buildTextField("Mobile Number", "+1 234 567 8900"),
      ],
    );
  }
}

Widget _buildTextField(String label, String initialValue, {bool isPassword = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      TextFormField(
        initialValue: initialValue,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondary),
          ),
          suffixIcon: isPassword
              ? const Icon(Icons.visibility_off, color: Colors.grey)
              : null,
        ),
      ),
    ],
  );
}
