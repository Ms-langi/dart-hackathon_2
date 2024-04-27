// lib/screens/task_list_screen.dart

import 'package:flutter/material.dart';
import 'package:StarGuide/model/todo_item.dart'; // import todo_item model class
import 'package:StarGuide/widgets/task_widget.dart'; // import taskwidget

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<TodoItem> tasks = [
    TodoItem(name: 'Prepare lecture slides', id: '1'),
    TodoItem(name: 'Grade assignments', id: '2', isCompleted: true),
    TodoItem(name: 'Meet with students during office hours', id: '3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskWidget(
            task: tasks[index],
            onCheckboxChanged: (value) {
              setState(() {
                tasks[index].isCompleted = value!;
              });
            },
            onDelete:() {
              setState(() {
                tasks.removeAt(index);
              });
            },
            onEdit:(){
              _editTask(context, tasks[index]);
            };
        },
      ),
      floatingActionButton: floatingActionButton(
        onPressed: () {
          _showAddTaskModal(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Function to show modal bottom sheet for adding tasks
  void _showAddTaskModal(BuildContext context) {
    String newTaskName = '';
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Task Name'),
                    onChanged: (value) {
                      setState(() {
                        newTaskName = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add new task if task name is not empty
                      if (newTaskName.isNotEmpty) {
                        setState(() {
                          tasks.add(TodoItem(
                            name: newTaskName,
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                          ));
                        });
                        Navigator.pop(context); // Close modal bottom sheet
                      } else {
                        // Show error message if task name is empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter a task name.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Text('Add Task'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
