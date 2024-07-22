import 'package:flutter/material.dart';
import 'widget/side_menu.dart';

class NextExams extends StatelessWidget {
  const NextExams({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Exams'),
      ),
      drawer:  SideMenu(),
      body: const Center(
        child: Text('Welcome to the Next Exams Page'),
      ),
    );
  }
}
