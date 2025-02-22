import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/add_dialog_widget.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key,});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  // list
  List<Task> taskItems = [
    Task(
        title: "Learn Code 1",
        description: "Learn CPP and Flutter ",
        isDone: false),
    Task(title: "Go to work", description: "Go to work at 7PM", isDone: false),
  ];

  // ajout
  void addTask(Task task) {
    setState(() {
      if (task.title.isEmpty) {
        return;
      }
      taskItems.add(task);
    });
    _titleController.clear();
    _descriptionController.clear();
  }

  // suppression
  void removeTask(Task task) {
    // afficher un message avant de supprimer
    setState(() {
      taskItems.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Todo"),
      ),
      body: screenWidth > 600 ? _buildGrid() : _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskDialog(
            context: context,
            addAction: () => addTask(
                  Task(
                    title: _titleController.text,
                    description: _descriptionController.text,
                  ),
                ),
            titleController: _titleController,
            descriptionController: _descriptionController),
        tooltip: 'Ajouter une tâche',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: taskItems.length,
      itemBuilder: (context, index) {
        return _buildTaskItem(taskItems[index]);
      },
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: taskItems.length,
      itemBuilder: (context, index) {
        return _buildTaskItem(taskItems[index]);
      },
    );
  }

  Widget _buildTaskItem(Task task) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description ?? ''),
      leading: Checkbox(
        value: task.isDone,
        onChanged: (value) {
          setState(() {
            task.isDone = value ?? false;
          });
        },
      ),
      trailing: IconButton(
        onPressed: () => removeTask(task),
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
