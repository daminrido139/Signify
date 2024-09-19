import 'package:flutter/material.dart';
import 'package:signify/entry.dart';

class HomepageTeacher extends StatelessWidget {
  const HomepageTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const SizedBox(),
        title: const GradientText(
          'Leviosa',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          gradient: LinearGradient(
              colors: [Color.fromRGBO(228, 212, 156, 1), Color(0xffad9c00)]),
        ),
      ),
      body: const Center(
        child: Text('Teacher Homepage currently working '),
      ),
    );
  }
}
