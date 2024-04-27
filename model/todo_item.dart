// lib/model/todo_item.dart

class TodoItem {
  String name;
  String id;
  bool isCompleted;

  TodoItem({required this.name, required this.id, this.isCompleted = false});
}
