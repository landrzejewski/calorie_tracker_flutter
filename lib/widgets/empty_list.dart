import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
