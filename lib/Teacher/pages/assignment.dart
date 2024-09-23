import 'package:flutter/material.dart';

class AssignmentPageTeacher extends StatelessWidget {
  const AssignmentPageTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/img/teacher.jpeg"),
            ),
          ),
          title: const Text(
            'Class',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 243, 227, 173),
          actions: [
            SizedBox(
                height: 30,
                width: 30,
                child: Image.asset("assets/img/classroom.png")),
           const  SizedBox(
              width: 30,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              customlisttitle(context, "C1", "Class 1", Colors.amber),
              customlisttitle(context, "C2", "Class 2",
                  const Color.fromARGB(255, 192, 240, 129)),
              customlisttitle(context, "C3", "Class 3",
                  const Color.fromARGB(255, 131, 231, 238)),
              customlisttitle(context, "C4", "Class 4",
                  const Color.fromARGB(255, 229, 231, 112)),
              customlisttitle(context, "C5", "Class 5",
                  const Color.fromARGB(255, 205, 113, 233)),
              customlisttitle(context, "C6", "Class 6",
                  const Color.fromARGB(255, 201, 192, 73)),
              customlisttitle(context, "C7", "Class 7",
                  const Color.fromARGB(255, 132, 117, 219)),
              customlisttitle(context, "C7", "Class 8",
                  const Color.fromARGB(255, 236, 125, 106)),
            ],
          ),
        ));
  }

  Widget customlisttitle(BuildContext context, icontxt, txt, color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 227, 227),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: color),
                child: const Center(
                    child: Text(
                  "C1",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              txt,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
