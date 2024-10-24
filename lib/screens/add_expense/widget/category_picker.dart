import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryPicker extends StatelessWidget {
  final TextEditingController controller;
  final Widget prefixIcon;
  final VoidCallback onPressed;

  const CategoryPicker({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      readOnly: true,
      onTap: () {
        // Handle any tap logic if necessary
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            FontAwesomeIcons.plus,
            size: 16,
            color: Colors.grey,
          ),
        ),
        hintText: 'Category',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
