import 'package:flutter/material.dart';

class MyTabs extends StatelessWidget {
  const MyTabs({
    super.key,
    required this.color,
    required this.text,
  });
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black),
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }
}
