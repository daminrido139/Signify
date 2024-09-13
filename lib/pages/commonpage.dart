import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:signify/pages/assignmentpage.dart';
import 'package:signify/pages/homepage.dart';
import 'package:signify/pages/learningpage.dart';
import 'package:signify/pages/profilepage.dart';
import 'package:signify/pages/writtingpard.dart';

class Commonpage extends StatefulWidget {
  const Commonpage({
    super.key,
  });

  @override
  State<Commonpage> createState() => _HomepageState();
}

class _HomepageState extends State<Commonpage> {
  int selectedPage = 1;
  final pages = const [
    Learningpage(),
    Homepage(),
    Assignmentpage(),
    Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPage],
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
          index: selectedPage,
          height: 70,
          color: Colors.blue.shade100,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (val) {
            setState(() {
              selectedPage = val;
            });
          },
          items: const [
            Icon(Icons.assessment),
            Icon(Icons.home),
            Icon(Icons.book),
            Icon(Icons.person),
          ]),
    );
  }
}
