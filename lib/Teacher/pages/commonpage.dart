import 'package:flutter/material.dart';
import 'package:signify/Teacher/pages/assignment.dart';
import 'package:signify/Teacher/pages/calendar.dart';
import 'package:signify/Teacher/pages/home.dart';
import 'package:signify/Teacher/pages/profile.dart';

class CommonpageTeacher extends StatefulWidget {
  const CommonpageTeacher({super.key});

  @override
  State<CommonpageTeacher> createState() => _CommonpageTeacherState();
}

class _CommonpageTeacherState extends State<CommonpageTeacher> {
  static List page = const [
    CalendarTeacher(),
    HomepageTeacher(),
    AssignmentPageTeacher(),
    ProfilePageTeacher()
  ];
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[index],
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 243, 227, 173),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.black,
            )),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
            onPressed: () {
              setState(() {
                index = 0;
              });
            },
            icon: const Icon(
              Icons.calendar_month_outlined,
              size: 20,
            ),
          ),
          index == 1
              ? Stack(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.black,
                          )),
                    ),
                    Positioned(
                      bottom: 0.5,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        icon: const Icon(
                          Icons.home,
                          color: Color.fromARGB(255, 27, 15, 15),
                          size: 27,
                        ),
                      ),
                    )
                  ],
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  icon: const Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 27, 15, 15),
                    size: 25,
                  ),
                ),
          IconButton(
            onPressed: () {
              index = 2;
              setState(() {});
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              index = 3;
              setState(() {});
            },
            icon: const Icon(Icons.person),
          ),
        ]),
      ),
    );
  }
}
