import 'package:flutter/material.dart';
import 'package:signify/Student/pages/assignpost.dart';

import 'package:signify/Student/pages/writtingpard.dart';

class Assignmentpage extends StatefulWidget {
  const Assignmentpage({super.key});
  static List pages = [
    const Assignpost(),
    const Writtingpard(),
  ];

  @override
  State<Assignmentpage> createState() => _AssignmentpageState();
}

class _AssignmentpageState extends State<Assignmentpage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 233, 223, 190),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                  "assets/img/profileimage.jpg",
                ),
              ),
            ),
          ),
          title: const Text(
            "Assignments",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  if (index == 0) {
                    index = 1;
                  } else {
                    index = 0;
                  }

                  setState(() {});
                },
                icon: Transform.rotate(
                  angle: index == 0 ? 3.14 : 3.14 / 2,
                  child: const Icon(
                    Icons.book_online_outlined,
                  ),
                )),
          ],
        ),
        body: Assignmentpage.pages[index]);
  }
}
