// lib/widgets/task_widget.dart

import 'package:flutter/material.dart';
import 'package:StarGuide/model/todo_item.dart';

class TaskWidget extends StatelessWidget {
  final TodoItem task;
  final Function(bool?)? onCheckboxChanged;
  final Function()? onDelete;

  TaskWidget({
    required this.task,
    this.onCheckboxChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: onCheckboxChanged,
      ),
      title: Text(
        task.name,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
