import 'package:flutter/material.dart';

import '../models/task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // list 
 List<Task> taskItems = [
    Task(title: "Learn Code 1", description: "Learn CPP and Flutter ", isDone: false),
    Task(title: "Go to work",description: "Go to work at 7PM",  isDone: false),
 ];

  // ajout
  void addTask(Task task){
    setState(() {
      if(task.title.isEmpty){
        return;
      }
      taskItems.add(task);
    });
  }

  // suppression
  void removeTask(Task task){
    setState(() {
      taskItems.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      // list de taches
      body: ListView.builder(
        itemCount: taskItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(taskItems[index].title),
            subtitle: Text(taskItems[index].description != null ? taskItems[index].description! : ""),
            trailing: IconButton(
              onPressed: () {
                removeTask(taskItems[index]);
              },
              icon: const Icon(Icons.delete),
            ),
          );
        },
      ),

      // ajout
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _addTaskDialog(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
    
  }
  _addTaskDialog(){
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
                      addTask(Task(title: _titleController.text, description: _descriptionController.text));
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ajouter'),
                  ),
                ],
              );
            },
          );
  }
}
