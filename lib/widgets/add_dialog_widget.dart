import 'package:flutter/material.dart';

// add task
showAddTaskDialog(
    {required context,
    required VoidCallback addAction,
    required TextEditingController titleController,
    required TextEditingController descriptionController}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Ajouter une tache'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Titre',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
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
            onPressed: () => addAction(),
            child: const Text('Ajouter'),
          ),
        ],
      );
    },
  );
}
