import 'package:flutter/material.dart';
import 'widget/side_menu.dart';

class Attendance extends StatelessWidget {
  const Attendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      drawer:  SideMenu(),
      body: const Center(
        child: Text('Welcome to the Attendance Page'),
      ),
    );
  }
}
