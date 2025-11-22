import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  final DateTime? selectedDate;

  const TodoListPage({super.key, this.selectedDate});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<Task> _tasks = [];

  void _sortTasks() {
    _tasks.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
  }

  void _addTask(String name) {
    setState(() {
      _tasks.add(Task(name: name));
      _sortTasks();
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      _sortTasks();
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _sortTasks();
    });
  }

  void _removeAllTasks() {
    setState(() {
      _tasks.clear();
    });
  }

  Future<void> _showAddTaskDialog() async {
    final controller = TextEditingController();
    final result = await showDialog<String?>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar tarefa'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Nome da tarefa'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      _addTask(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText = widget.selectedDate != null
        ? '${widget.selectedDate!.day}/${widget.selectedDate!.month}/${widget.selectedDate!.year}'
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(dateText != null ? 'To-Do - $dateText' : 'To-Do List'),
      ),

      body: _tasks.isEmpty
          ? Center(
              child: Text(
                'Nenhuma tarefa${dateText != null ? ' para $dateText' : ''}.',
                style: const TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      task.name,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(
                        task.isCompleted
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: task.isCompleted ? Colors.green : null,
                      ),
                      onPressed: () => _toggleTaskCompletion(index),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromRGBO(255, 82, 82, 1),
                      ),
                      onPressed: () => _removeTask(index),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        color: const Color(0xFF0D1117),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _showAddTaskDialog,
              icon: const Icon(Icons.add),
              label: const Text("Adicionar"),
            ),
            const SizedBox(width: 20),
            ElevatedButton.icon(
              onPressed: _removeAllTasks,
              icon: const Icon(Icons.delete_forever),
              label: const Text("Remover todas"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 240, 152, 146),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}
