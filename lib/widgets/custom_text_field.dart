import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.isPassword,

  });

  final String label;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextField(
        onSubmitted: ,
        obscureText: isPassword ? true : false,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide.none,
          ),
          labelText: label,
        ),
        controller: TextEditingController(),
      ),
    );
  }
}
