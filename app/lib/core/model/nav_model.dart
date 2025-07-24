import 'package:flutter/material.dart';

class NavModel {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  NavModel({required this.icon, required this.label, required this.onTap});
}
