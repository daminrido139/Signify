import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 223, 190),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [customcontainer()],
      ),
    );
  }

  Widget customcontainer() {
    return Center(
      child: Container(
        height: 150,
        width: 150,
        child: Center(
          child: const Text(
            "Student",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.5,
                0.7,
                0.9
              ],
              colors: [
                Color.fromRGBO(228, 247, 211, 1),
                Color.fromARGB(255, 234, 240, 206),
                Color.fromARGB(255, 243, 215, 197),
                Color.fromARGB(255, 219, 228, 243)
              ]),
        ),
      ),
    );
  }
}
