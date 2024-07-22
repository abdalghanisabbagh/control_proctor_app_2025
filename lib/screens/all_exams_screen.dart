import 'package:flutter/material.dart';
import 'widget/side_menu.dart';

class AllExams extends StatelessWidget {
  const AllExams({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Exams'),
      ),
      drawer:  SideMenu(),
      body: const Center(
        child: Text('Welcome to the All Exams Page'),
      ),
    );
  }
}
