import 'package:flutter/material.dart';

class StudentCheckboxTile extends StatelessWidget {

  final String name;
  final bool value;
  final Function(bool?) onChanged;

  const StudentCheckboxTile({
    super.key,
    required this.name,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        title: Text(name),
      ),
    );
  }
}