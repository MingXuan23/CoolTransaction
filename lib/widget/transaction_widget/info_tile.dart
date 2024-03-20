import 'package:flutter/material.dart';

Widget InfoTile(String displayInfo, String value, VoidCallback? onTapFunction) {
  Color textColor = const Color(0xFF5465FF);
  return GestureDetector(
    onTap: onTapFunction,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(
          Icons.keyboard_double_arrow_right_rounded,
          color: textColor,
        ),
        title: Text(
          displayInfo,
          style: TextStyle(fontSize: 18, color: textColor),
        ),
        trailing: Text(
          value,
          style: TextStyle(fontSize: 18, color: textColor),
        ),
      ),
    ),
  );
}
