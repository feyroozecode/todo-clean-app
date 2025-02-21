import 'package:flutter/material.dart';

import '../models/task.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage2> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage2> {
  // list
  List<Task> taskItems = [
    Task(
        title: "Learn Code 1",
        description: "Learn CPP and Flutter ",
        isDone: false),
    Task(title: "Go to work", description: "Go to work at 7PM", isDone: false),
  ];

  _showAddTaskDialog() {
    final _titleController = TextEditingController();
    final _descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter une tache'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Titre',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            // bouton annuler
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuller'),
            ),

            // bouton ajout
            TextButton(
              onPressed: () {
                _titleController.clear();
                _descriptionController.clear();
                addTask(Task(
                    title: _titleController.text,
                    description: _descriptionController.text));
                Navigator.of(context).pop();
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  // ajout
  void addTask(Task task) {
    setState(() {
      if (task.title.isEmpty) {
        return;
      }
      taskItems.add(task);
    });
  }

  // suppression
  void removeTask(Task task) {
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
        title: Text(widget.title),
      ),
      body: screenWidth > 600 ? _buildGrid() : _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: task.isDone,
            onChanged: (value) {
              setState(() {
                task.isDone = value ?? false;
              });
            },
          ),
          IconButton(
            onPressed: () => removeTask(task),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
