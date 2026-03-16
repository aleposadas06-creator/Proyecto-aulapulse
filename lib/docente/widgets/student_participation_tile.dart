import 'package:flutter/material.dart';

class StudentParticipationTile extends StatelessWidget {

  final String name;
  final int points;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const StudentParticipationTile({
    super.key,
    required this.name,
    required this.points,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        title: Text(name),

        subtitle: Text(
          "Participaciones: $points",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              color: Colors.red,
              onPressed: onRemove,
            ),

            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: Colors.green,
              onPressed: onAdd,
            ),

          ],
        ),
      ),
    );
  }
}