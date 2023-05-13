import 'package:flutter/material.dart';

/// A row containing a title and a body to display details for a workout
class WorkoutDetailsRow extends StatelessWidget {
  final String title;
  final String body;

  const WorkoutDetailsRow({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title ', style: TextStyle(color: Colors.grey.shade600)),
          Flexible(child: Text(body))
        ],
      ),
    );
  }
}
