import 'package:flutter/material.dart';
import 'package:signify/ui/HR/Work.dart';
import 'package:signify/ui/Parent/Work.dart';

import 'package:signify/ui/auth/createaccount.dart';

import 'package:signify/ui/Teacher/commonpage.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 5, 18),
      body: Column(
        children: [
          const SizedBox(height: 70),
          const GradientText(
            "Leviosa",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            gradient: LinearGradient(
              colors: [Color.fromRGBO(228, 212, 156, 1), Color(0xffad9c00)],
            ),
          ),
          const SizedBox(height: 130),
          const Text(
            "Who's Login?",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customcontainer("Student", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Createaccount()));
              }),
              customcontainer("Teacher", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CommonpageTeacher()));
              }),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customcontainer("Parent", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const WorkPage()));
              }),
              customcontainer("General/Hr", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkHrPage()));
              }),
            ],
          ),
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Made in India by 2024 :)",
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 106, 104, 104),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    "assets/img/icon.jpeg",
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget customcontainer(String name, ontap) {
    return Center(
      child: InkWell(
        onTap: ontap,
        child: Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color.fromRGBO(228, 212, 156, 1), Color(0xffad9c00)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 253, 249, 227),
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(255, 94, 93, 91)
                          .withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 10)
                ]),
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            )),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
