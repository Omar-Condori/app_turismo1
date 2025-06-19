import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? iconColor;

  const CustomSearchBar({
    Key? key,
    required this.onChanged,
    required this.hintText,
    this.controller,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          color: textColor ?? Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor ?? Colors.grey[600],
          ),
          prefixIcon: Icon(
            Icons.search,
            color: iconColor ?? Colors.grey[600],
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
} 