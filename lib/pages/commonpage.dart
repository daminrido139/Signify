import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:signify/pages/homepage.dart';
import 'package:signify/pages/learningpage.dart';
import 'package:signify/pages/profilepage.dart';

class Commonpage extends StatefulWidget {
  const Commonpage({
    super.key,
  });

  @override
  State<Commonpage> createState() => _HomepageState();
}

class _HomepageState extends State<Commonpage> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: const [
          Homepage(),
          Learningpage(),
          Profilepage(),
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
          color: Colors.blue.shade100,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (val) {
            setState(() {
              selectedPage = val;
            });
          },
          items: const [
            Icon(Icons.home),
            Icon(Icons.book),
            Icon(Icons.person),
          ]),
    );
  }
}
