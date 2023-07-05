import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hintText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final IconData? suffixIcon;
  final IconData prefixIcon;
  final bool readOnly;

  const CustomTextField({
    super.key,
    this.label,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      focusNode: focusNode,
      controller: controller,
      textInputAction: TextInputAction.next,
      keyboardType: inputType,
      validator: validator,
      obscureText: obscureText,
      style: const TextStyle(
          color: Colors.blueGrey, fontWeight: FontWeight.w500, fontSize: 14),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(24)),

        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        hintStyle: Theme.of(context).textTheme.bodySmall,
        focusColor: Colors.blueGrey,
        //border: InputBorder.none,
      ),
    );
  }
}
