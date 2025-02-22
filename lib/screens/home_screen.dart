
import 'package:flutter/material.dart';
import 'package:todolistapp/screens/todo_screen.dart';

import '../models/dashboard_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<DashboardItem> dashboardItems = [
    DashboardItem(
      title: 'Todo',
      description: 'TodoList App ',
      destination: const TodoScreen(),
    ),
    DashboardItem(
      title: 'About Screen',
      description: 'About developer',
      destination: const Placeholder(),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super App'),
      ),
      body:  Container(
        padding: const EdgeInsets.all(16),
        color: Colors.grey.shade200,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: dashboardItems.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap:(){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => dashboardItems[index].destination)
                );
              }  ,
              child:Card(
              child: ListTile(
                title: Text(dashboardItems[index].title, style: const TextStyle(fontSize: 20),),
                subtitle: Text(dashboardItems[index].description ?? ''),
              ),
            ),
            );
          },
        )
      )
    );
  }
}