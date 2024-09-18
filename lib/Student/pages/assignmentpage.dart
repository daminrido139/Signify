import 'package:flutter/material.dart';
import 'package:signify/Student/pages/assignpost.dart';
import 'package:signify/Student/pages/chatpage.dart';
import 'package:signify/Student/pages/drawerpage.dart';
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
  final GlobalKey<ScaffoldState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 233, 223, 190),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                key.currentState!.openDrawer();
              },
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                  "assets/img/profileimage.jpg",
                ),
              ),
            ),
          ),
          title: const Text("Assignments"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Chatpage()));
                },
                icon: const Icon(Icons.message_outlined)),
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
        drawer: const Drawerpage(),
        body: Assignmentpage.pages[index]);
  }
}
