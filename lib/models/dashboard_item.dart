
import 'package:flutter/material.dart';

class DashboardItem {
  final String title;
  final String? description;
  final Widget destination;

  DashboardItem({
    required this.title,
    this.description,
    required this.destination,
  });
}